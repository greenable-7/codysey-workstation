#!/usr/bin/env bash
set -Eeuo pipefail

IMAGE_NAME="codysey-nginx:mission"
WEB_CONTAINER="codysey-web-test"
WRITE_CONTAINER="codysey-volume-write"
READ_CONTAINER="codysey-volume-read"
VOLUME_NAME="codysey-mission-data"
HOST_PORT="${HOST_PORT:-8080}"

cleanup() {
  docker rm -f "$WEB_CONTAINER" "$WRITE_CONTAINER" "$READ_CONTAINER" >/dev/null 2>&1 || true
  docker volume rm "$VOLUME_NAME" >/dev/null 2>&1 || true
  docker image rm "$IMAGE_NAME" >/dev/null 2>&1 || true
}

trap cleanup EXIT

# A previous interrupted test may have left resources with these dedicated names.
cleanup

echo "[1/9] Docker CLI and daemon"
docker --version
docker info --format 'Server={{.ServerVersion}} OS={{.OperatingSystem}}'

echo "[2/9] hello-world"
docker run --rm hello-world

echo "[3/9] Build Dockerfile"
docker build -t "$IMAGE_NAME" .

echo "[4/9] Port mapping and HTTP response"
docker run -d --name "$WEB_CONTAINER" -p "${HOST_PORT}:80" "$IMAGE_NAME"
response=""
for attempt in 1 2 3 4 5; do
  if response="$(curl --fail --silent --show-error "http://localhost:${HOST_PORT}")"; then
    break
  fi
  sleep 1
done
printf '%s\n' "$response"
printf '%s' "$response" | grep -F 'Hello SoHye!'
docker ps --filter "name=${WEB_CONTAINER}" --format 'table {{.Names}}\t{{.Ports}}\t{{.Status}}'

echo "[5/9] Write named-volume data"
docker volume create "$VOLUME_NAME"
docker run --name "$WRITE_CONTAINER" -v "${VOLUME_NAME}:/data" ubuntu:latest \
  sh -c 'printf "Hello Volume!\n" > /data/hello.txt'
docker run --rm -v "${VOLUME_NAME}:/data" ubuntu:latest cat /data/hello.txt

echo "[6/9] Delete the writer container"
docker rm "$WRITE_CONTAINER"

echo "[7/9] Read the same data from a new container"
docker run --name "$READ_CONTAINER" -v "${VOLUME_NAME}:/data" ubuntu:latest \
  sh -c 'test "$(cat /data/hello.txt)" = "Hello Volume!" && cat /data/hello.txt'

echo "[8/9] Lists before cleanup"
docker ps -a --filter "name=codysey-" --format 'table {{.Names}}\t{{.Image}}\t{{.Status}}'
docker images "$IMAGE_NAME"
docker volume ls --filter "name=${VOLUME_NAME}"

echo "[9/9] Cleanup and lists after cleanup"
cleanup
trap - EXIT
docker ps -a --filter "name=codysey-" --format 'table {{.Names}}\t{{.Image}}\t{{.Status}}'
docker images "$IMAGE_NAME"
docker volume ls --filter "name=${VOLUME_NAME}"

echo "[PASS] all Docker checks completed"
