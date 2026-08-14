# codysey-workstation

# Codyssey 개발 워크스테이션 구축 미션

## 1. 프로젝트 개요

Terminal, OrbStack, Docker, Git, GitHub를 사용하여
재현 가능한 개발 환경을 구성하는 미션입니다.

## 2. 실행 환경

- OS: macOS
- Shell:# Codyssey Developer Workstation Mission
- docker version #수정
- git version #수정 

## 1. 프로젝트 개요

이 프로젝트는 개발에 필요한 기본 워크스테이션을 직접 구축하고 검증하기 위한 미션이다.

macOS 터미널에서 파일과 디렉토리를 관리하고 권한을 변경했으며, OrbStack을 통해 Docker 환경을 구성했다. 또한 Docker 이미지와 컨테이너를 실행·관리하고, Dockerfile을 사용해 정적 웹 서버 이미지를 제작한다.

포트 매핑을 통해 호스트 컴퓨터에서 컨테이너의 웹 서버에 접속하고, 바인드 마운트와 Docker 볼륨을 이용해 파일 변경 반영과 데이터 영속성을 검증한다. 모든 과정은 Git으로 버전 관리한 뒤 GitHub 저장소에 게시한다.

## 2. 실행 환경
ㅣ
| 구분           | 실행 결과                      |
| ------------ | -------------------------- |
| 운영체제         | macOS `[sw_vers 실행 결과]`    |
| CPU 아키텍처     | `[arm64 또는 x86_64]`        |
| Shell        | `[echo "$SHELL" 실행 결과]`    |
| Shell 버전     | `[zsh --version 실행 결과]`    |
| 터미널          | `[TERM_PROGRAM 실행 결과]`     |
| Docker 실행 환경 | OrbStack                   |
| Docker 버전    | `[docker --version 실행 결과]` |
| Git 버전       | `[git --version 실행 결과]`    |
| 기본 Git 브랜치   | main                       |

### 실행 환경 확인 명령

```bash
sw_vers
uname -m
echo "$SHELL"
zsh --version
echo "$TERM_PROGRAM"
git --version
docker --version
docker info
```

### 실행 결과

전체 실행 결과는 다음 로그에서 확인할 수 있다.

* [`logs/01-environment.txt`](logs/01-environment.txt)
* [`logs/02-docker-info.txt`](logs/02-docker-info.txt)

### 실행 환경 확인 화면

![프로젝트 폴더 확인](docs/screenshots/01-project-directory.png)

![Docker 및 실행 환경 확인](docs/screenshots/02-environment-check.png)

## 3. 수행 체크리스트

* [ ] 터미널 기본 조작
* [ ] 절대 경로와 상대 경로 확인
* [ ] 파일과 디렉토리 권한 변경
* [ ] Docker 설치 및 동작 점검
* [ ] Docker 이미지 다운로드 및 확인
* [ ] Docker 컨테이너 실행·중지·삭제
* [ ] hello-world 실행
* [ ] Ubuntu 컨테이너 내부 명령 실행
* [ ] Dockerfile 기반 커스텀 이미지 제작
* [ ] 포트 매핑 및 웹 브라우저 접속
* [ ] 바인드 마운트 변경 반영 확인
* [ ] Docker 볼륨 데이터 영속성 확인
* [ ] Git 설정 및 버전 관리
* [ ] GitHub 및 VS Code 연동
* [ ] 트러블슈팅 2건 이상 기록

- Docker 실행 환경: OrbStack
- Docker 버전:Docker version 28.5.2, build ecc6942
- Git 버전: git version 2.53.0
- Editor: VS Code

## 3. 수행 체크리스트

- [x] 터미널 기본 조작
  [x] 절대경로와 상대경로 확인 
- [ ] 파일 및 디렉토리 권한 변경
- [ ] Docker 기본 점검
- [ ] Dockerfile 기반 이미지 제작
- [ ] 포트 매핑
- [ ] 바인드 마운트
- [ ] Docker 볼륨 영속성
- [ ] GitHub 연동
- [ ] 트러블슈팅 2건

## 4. 수행 과정

### 4.1. 터미널 기본 조작
#### 4.1.1 현재 위치 및 목록 확인
현재 작업 중인 디렉터리 위치와 파일 목록을 확인했다.  
`ls -a`를 사용하여 숨김 파일도 함께 확인했다.  

```bash
$ pwd
/Users/dreamitator5528/Desktop/codysey-workstation

$ ls
docs  README.md  terminal-practice

$ ls -a
.  ..  .git  .gitignore  docs  README.md  terminal-practice

$ ls -l
total 8
drwxr-xr-x  3 dreamitator5528  dreamitator5528    96  7 29 23:42 docs
-rw-r--r--  1 dreamitator5528  dreamitator5528  3660  7 29 23:22 README.md
drwxr-xr-x  2 dreamitator5528  dreamitator5528    64  7 29 21:31 terminal-practice
```

![현재 위치 및 목록 확인](docs/screenshots/terminal-basic-01.png)


!#### 4.1.2 파일 생성·복사·이름 변경·이동·삭제

연습용 디렉터리로 이동한 뒤 폴더와 파일을 생성하고, 복사·이름 변경·이동·삭제를 수행했다.

```bash
$ cd terminal-practice
$ mkdir practice-room
$ cd practice-room

$ touch empty.txt
$ echo "Hello Terminal" > message.txt

$ cat message.txt
Hello Terminal

$ cp message.txt message-copy.txt
$ mv message-copy.txt copied-message.txt

$ mkdir backup
$ mv copied-message.txt backup/
$ rm backup/copied-message.txt

$ ls backup
```

`ls backup` 실행 후 아무 파일도 출력되지 않아 복사본이 삭제되었음을 확인했다.

![파일 생성·복사·이름 변경·이동·삭제](docs/screenshots/terminal-basic-02.png)

파일 권한 변경
chmod 600 app/index.html

chmod 600을 수행했다. 소유자만 읽기,쓰기 가능하고
나머지 권한 없음이다. 
r- read 4
w- write 2
x- execute 1
6이 소유자, 0이 그룹, 0이 others

디렉토리 권한 변경
chmod 700 permission-test-dir

### 4.2. 절대경로와 상대경로 확인

프로젝트 최상위 디렉터리에서 같은 파일을 상대경로와 절대경로로 각각 확인했다.

#### 현재 위치 확인

```bash
$ pwd
/Users/dreamitator5528/Desktop/codysey-workstation
```

`pwd`는 현재 작업 중인 디렉터리의 절대경로를 보여주는 명령어이다.

#### 상대경로로 파일 확인

```bash
$ ls app/index.html
app/index.html
```

`app/index.html`은 현재 위치인 `codysey-workstation`을 기준으로 작성한 상대경로이다.

#### 절대경로로 파일 확인

```bash
$ ls /Users/dreamitator5528/Desktop/codysey-workstation/app/index.html
/Users/dreamitator5528/Desktop/codysey-workstation/app/index.html
```

절대경로는 `/`부터 시작하며 파일이 있는 위치를 처음부터 끝까지 모두 나타낸다.

상대경로와 절대경로는 작성 방식은 다르지만, 위 실습에서는 같은 `index.html` 파일을 가리킨다.

![절대경로와 상대경로 확인](docs/screenshots/path-practice-01.png)


#### 배운 점

절대경로는 현재 위치가 바뀌어도 같은 파일을 가리킨다. 상대경로는 현재 작업 중인 디렉터리를 기준으로 하기 때문에 현재 위치에 따라 의미가 달라질 수 있다.
## 5. 트러블슈팅

실습 중 발생한 문제와 해결 과정을 기록합니다.

## 6. 배운 점

미션을 통해 이해한 내용을 정리합니다. 


## 7. Docker 실행 환경 확인 및 기본 실습

docker --version 으로 버전을 확인했다. 
Docker version 28.5.2, build ecc6942

docker info 를 확인했다.
Docker 
<img width="858" height="726" alt="image" src="https://github.com/user-attachments/assets/a4f63807-8a23-42d8-ba5c-cc6d0e6c4925" />

docker run hello-world
<img width="850" height="534" alt="image" src="https://github.com/user-attachments/assets/39aabce9-331b-4b19-86d3-0fbd96e48c09" />


docker images로 이미지 목록을 확인했다. 

REPOSITORY    TAG       IMAGE ID       CREATED        SIZE
hello-world   latest    e2ac70e7319a   4 months ago   10.1kB

Ubuntu 이미지를 기반으로 Dockerfile을 작성하고, 이를 빌드하여 `codysey-ubuntu`라는 커스텀 이미지를 생성한 뒤 컨테이너로 실행해 정상 동작을 확인했다.



docker logs 06c4c92e3312
도커 로그를 확인하다. 
06c4c92e3312: 컨테이너 ID


Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/

docker run -d --name stats-test ubuntu sleep 300
sleep 300으로 5분동안 Ubuntu 컨테이너를 실행 상태로 유지시킴

docker stats 
--no-stream
CONTAINER ID   NAME         CPU %     MEM USAGE / LIMIT     MEM %     NET I/O         BLOCK I/O   PIDS
6cb8a8d5ec48   stats-test   0.00%     1.715MiB / 15.67GiB   0.01%     1.13kB / 126B   0B / 0B     1
`docker stats`는 실행 중인 컨테이너의 CPU·메모리 사용량을 실시간으로 계속 보여준다. `--no-stream` 옵션을 사용하면 실시간 갱신을 하지 않고 현재 상태를 한 번만 출력한 뒤 종료한다.
핵심은 docker stats = 계속 갱신, docker stats --no-stream = 한 번만 확인이야.


### 7-9. Dockerfile을 이용한 커스텀 이미지 빌드
Dockerfile 내용:

```dockerfile
FROM ubuntu:latest
RUN apt-get update
```

이미지 빌드 및 확인:

```bash
docker build -t codysey-ubuntu .
docker images
```

컨테이너 실행 및 확인:

```bash
docker run -it codysey-ubuntu bash
cat /etc/os-release
exit
docker ps -a
```
-it: 터미널에 입력창을 만들어준다.
ps: 도커의 모든 컨테이너 목록을 보여주었다.

### 7-10. nginx 설치 및 포트 매핑

기존 Ubuntu 기반 Dockerfile에 nginx 웹서버를 설치하도록 내용을 추가했다.

Dockerfile 내용:

```dockerfile
FROM ubuntu:latest
RUN apt-get update
RUN apt-get install -y nginx
```
```bash
docker run -d -p 8080:80 codysey-nginx nginx -g "daemon off;"
docker ps
docker stop b966e0b44a40
```
![alt text](image.png)
-detach 백그라운드에서 실행하고
-p: port로 8080을 80에 연결한다. 
왜 연결이 필요한가? 컨테이너에 있는 내용물을 컴퓨터에서 보고 싶어서 연결했다.
도커를 통해 만들어지지 않은 컴퓨터 프로그램들의 실행환경이랑 도커의 실행환경은 분리되어 있다.
0.0.0.0:8080->80/tcp
http://localhost:8080
포트 매핑 확인 결과:
<img width="1376" height="718" alt="image" src="https://github.com/user-attachments/assets/66abc893-4b82-445c-bf35-d6d0a0870675" />

```text
0.0.0.0:8080->80/tcp
```
브라우저 접속 주소:

http://localhost:8080
### 7-11. Bind Mount 실습
호스트의 `app` 폴더를 컨테이너의 nginx 웹 폴더와 연결하기 위해 Bind Mount를 사용했다.
실행 명령:

```bash
docker run -d -p 8080:80 -v "$(pwd)/app:/var/www/html" codysey-nginx nginx -g "daemon off;"
```
`-v "$(pwd)/app:/var/www/html"` 옵션으로 호스트의 `app` 폴더와 컨테이너의 `/var/www/html` 폴더를 연결했다.
Bind Mount 연결 확인:
<img width="564" height="303" alt="bind mount  전 수정" src="https://github.com/user-attachments/assets/e77a0929-99db-4e85-917a-02853eaa5642" />
<img width="309" height="255" alt="스크린샷 2026-08-14 오후 8 20 43" src="https://github.com/user-attachments/assets/6e3e3e76-a7f7-4a6d-8382-6f5d3664a77b" />

```bash
docker inspect b106c3b57867
```
확인 결과 `Source`는 호스트의 `app` 폴더, `Destination`은 컨테이너의 `/var/www/html`로 표시되었다.
실제 웹페이지 반영 확인:

```bash
curl http://localhost:8080
```

결과:

```html
<h1>Hello SoHye!</h1>
```

이를 통해 호스트의 `app/index.html` 변경 내용이 컨테이너의 nginx 웹서버에 정상 반영되는 것을 확인했다.
![Uploading 스크린샷 2026-08-14 오후 8.20.43.png…]()
