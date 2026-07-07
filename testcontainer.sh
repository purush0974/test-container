#!/bin/bash
export GITHUB_TOKEN=GITHUB_TOKEN

$ErrorActionPreference = "Stop"

$REPO_DIR = "test-container"

$GIT_PUSH_USER = "discoverpurush0974"
$GIT_AUTHOR_NAME = "ppalani"
$GIT_AUTHOR_EMAIL = "purshothaman0974@gmail.com"

$GITHUB_USERNAME = "ppalani"
$REPO_NAME = "container-validation-test"

if (-not $env:GITHUB_TOKEN) {
    Write-Host "ERROR: GITHUB_TOKEN is not set"
    exit 1
}

if (Test-Path $REPO_DIR) {
    Remove-Item -Recurse -Force $REPO_DIR
}

git clone "https://$GIT_PUSH_USER`:$env:GITHUB_TOKEN@github.com/$GITHUB_USERNAME/$REPO_NAME.git"

Set-Location $REPO_DIR

git config user.name "$GIT_AUTHOR_NAME"
git config user.email "$GIT_AUTHOR_EMAIL"

$date = Get-Date
Add-Content -Path "test.py" -Value "# touched from Windows at $date"

git add test.py
git commit -m "Container validation update"

git push origin main