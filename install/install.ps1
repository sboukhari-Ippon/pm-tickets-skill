# Installe le skill pm-tickets pour Codex, OpenCode, DeepSeek Harness et Claude Code
# (Claude Code peut aussi l'installer depuis le catalogue LiteLLM).
#
# Usage : powershell -ExecutionPolicy Bypass -File install\install.ps1
#
# - Copie skills\pm-tickets dans %USERPROFILE%\.agents\skills\ et %USERPROFILE%\.claude\skills\,
#   et dans %DSH_HOME%\skills\ (défaut %USERPROFILE%\.dsh\skills\) si DeepSeek Harness est présent.
#   Une version déjà installée du skill est remplacée.
# - Crée la mémoire %USERPROFILE%\.pm-tickets\ si elle manque, sans jamais modifier son contenu.
# - Reprend, s'ils existent, les réglages et exemples de l'ancien agent DeepSeek Harness
#   (%USERPROFILE%\.dsh\pm-tickets\), sans écraser ce qui existe déjà.
$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent $PSScriptRoot
$src = Join-Path $root 'skills\pm-tickets'
if (-not (Test-Path (Join-Path $src 'SKILL.md'))) {
    Write-Error "SKILL.md introuvable dans $src"
    exit 1
}

$userHome = $env:USERPROFILE
$dshHome = if ($env:DSH_HOME) { $env:DSH_HOME } else { Join-Path $userHome '.dsh' }
$targets = @((Join-Path $userHome '.agents\skills'), (Join-Path $userHome '.claude\skills'))
if (Test-Path $dshHome) { $targets += (Join-Path $dshHome 'skills') }

foreach ($target in $targets) {
    New-Item -ItemType Directory -Force -Path $target | Out-Null
    $dest = Join-Path $target 'pm-tickets'
    if (Test-Path $dest) { Remove-Item -Recurse -Force $dest }
    Copy-Item -Recurse $src $dest
    Write-Host "Skill installé : $dest"
}

$memory = Join-Path $userHome '.pm-tickets'
New-Item -ItemType Directory -Force -Path (Join-Path $memory 'examples') | Out-Null
New-Item -ItemType Directory -Force -Path (Join-Path $memory 'cache') | Out-Null

$old = Join-Path $dshHome 'pm-tickets'
$oldConfig = Join-Path $old 'config.json'
$newConfig = Join-Path $memory 'config.json'
if ((-not (Test-Path $newConfig)) -and (Test-Path $oldConfig)) {
    Copy-Item $oldConfig $newConfig
    Write-Host "Réglages repris de l'ancien agent : $oldConfig"
}
$oldExamples = Join-Path $old 'examples'
if (Test-Path $oldExamples) {
    Get-ChildItem -File $oldExamples | ForEach-Object {
        $destFile = Join-Path (Join-Path $memory 'examples') $_.Name
        if (-not (Test-Path $destFile)) {
            Copy-Item $_.FullName $destFile
            Write-Host "Exemple repris : $($_.Name)"
        }
    }
}

Write-Host "Mémoire : $memory"
Write-Host "Prochaine étape : redémarrer le harness, puis décrire un besoin (« j'ai besoin d'un ticket pour… »)."
