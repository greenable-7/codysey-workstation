param(
    [string]$OutputPath = "docs/screenshots/git-github-link.png"
)

$ErrorActionPreference = "Stop"

function Invoke-GitText {
    param([string[]]$Arguments)

    $output = & git -c core.fsmonitor=false @Arguments 2>&1
    if ($LASTEXITCODE -ne 0) {
        throw "git $($Arguments -join ' ') failed: $output"
    }
    return @($output | ForEach-Object { $_.ToString().TrimEnd() })
}

function Add-Lines {
    param([object[]]$Text)

    foreach ($line in $Text) {
        $lines.Add($line.ToString())
    }
}

$lines = [System.Collections.Generic.List[string]]::new()
$lines.Add('$ git --version')
Add-Lines (git --version)
$lines.Add('')
$lines.Add('$ git config --get user.name')
Add-Lines (Invoke-GitText @('config', '--get', 'user.name'))
$lines.Add('$ git config --get user.email')
Add-Lines (Invoke-GitText @('config', '--get', 'user.email'))
$lines.Add('')
$lines.Add('$ git status --short --branch')
Add-Lines (Invoke-GitText @('status', '--short', '--branch'))
$lines.Add('')
$lines.Add('$ git remote -v')
Add-Lines (Invoke-GitText @('remote', '-v'))
$lines.Add('')
$lines.Add('$ git log -3 --oneline')
Add-Lines (Invoke-GitText @('log', '-3', '--oneline'))

Add-Type -AssemblyName System.Drawing
$font = [System.Drawing.Font]::new('Consolas', 18, [System.Drawing.FontStyle]::Regular)
$width = 1500
$padding = 32
$lineHeight = 31
$height = ($padding * 2) + ($lines.Count * $lineHeight)
$bitmap = [System.Drawing.Bitmap]::new($width, $height)
$graphics = [System.Drawing.Graphics]::FromImage($bitmap)
$graphics.Clear([System.Drawing.Color]::FromArgb(17, 17, 17))
$graphics.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::ClearTypeGridFit
$brush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(238, 238, 238))

try {
    for ($index = 0; $index -lt $lines.Count; $index++) {
        $graphics.DrawString($lines[$index], $font, $brush, $padding, $padding + ($index * $lineHeight))
    }

    $resolvedOutput = [System.IO.Path]::GetFullPath((Join-Path (Get-Location) $OutputPath))
    $outputDirectory = [System.IO.Path]::GetDirectoryName($resolvedOutput)
    [System.IO.Directory]::CreateDirectory($outputDirectory) | Out-Null
    $bitmap.Save($resolvedOutput, [System.Drawing.Imaging.ImageFormat]::Png)
    Write-Output $resolvedOutput
}
finally {
    $brush.Dispose()
    $graphics.Dispose()
    $bitmap.Dispose()
    $font.Dispose()
}
