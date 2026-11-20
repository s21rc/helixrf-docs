<#
.SYNOPSIS
  Publish a product manual (or the landing page) to docs.helixrf.com.

.DESCRIPTION
  Runs on the PC from the repo root, with .venv present.
  -Version builds products/<Product>/mkdocs.yml with mike, publishes it as that
  version, moves "latest" to it and pushes the gh-pages branch (GitHub Pages
  serves it within a minute or two).
  -Landing copies landing/ to the root of gh-pages (keeps CNAME and .nojekyll).
  Both make the result public.

.EXAMPLE
  .\publish-docs.ps1 -Version 1.0                     # SSPA Controller 1.0, becomes latest
  .\publish-docs.ps1 -Product helixrf-nmos-highside-switch -Version 1.0
  .\publish-docs.ps1 -Version 1.1 -NoLatest           # publish 1.1 without moving latest
  .\publish-docs.ps1 -Landing                         # update the landing page only
  .\publish-docs.ps1 -List                            # show published versions
#>
param(
    [string]$Product = 'helixrf-sspa-controller',
    [string]$Version,
    [switch]$NoLatest,
    [switch]$Landing,
    [switch]$List,
    [switch]$Yes
)

$ErrorActionPreference = 'Stop'
$env:NO_MKDOCS_2_WARNING = '1'
Set-Location $PSScriptRoot

$mike   = Join-Path $PSScriptRoot '.venv\Scripts\mike.exe'
$mkdocs = Join-Path $PSScriptRoot '.venv\Scripts\mkdocs.exe'
$config = "products/$Product/mkdocs.yml"

if (-not (Test-Path $mike)) { throw 'mike not found. Create .venv and run: pip install -r requirements.txt' }

function Confirm-Publish([string]$what) {
    if ($Yes) { return }
    $answer = Read-Host "Publish $what to docs.helixrf.com (public)? (y/N)"
    if ($answer -notmatch '^(y|yes)$') { Write-Host 'Cancelled.'; exit 0 }
}

# Keep the local gh-pages branch level with GitHub before mike or the landing step touch it.
git fetch -q origin gh-pages:gh-pages 2>$null

if ($List) {
    & $mike list -F $config --deploy-prefix $Product
    exit $LASTEXITCODE
}

if ($Version) {
    if (-not (Test-Path $config)) { throw "No such product: $config" }
    if (git status --porcelain) {
        Write-Warning 'There are uncommitted changes. Commit and push main first so the published docs match git.'
    }

    Write-Host "Checking $Product (mkdocs build --strict)..." -ForegroundColor DarkGray
    & $mkdocs build --strict -q -f $config -d "$env:TEMP\helixrf-docs-check"
    if ($LASTEXITCODE -ne 0) { throw 'Strict build failed. Fix the warnings above first.' }
    Remove-Item -Recurse -Force "$env:TEMP\helixrf-docs-check" -ErrorAction SilentlyContinue

    $target = if ($NoLatest) { $Version } else { "$Version (and latest)" }
    Confirm-Publish "$Product $target"

    if ($NoLatest) {
        & $mike deploy -F $config --deploy-prefix $Product --push $Version
    }
    else {
        & $mike deploy -F $config --deploy-prefix $Product --push --update-aliases $Version latest
        if ($LASTEXITCODE -eq 0) {
            & $mike set-default -F $config --deploy-prefix $Product --push latest
        }
    }
    if ($LASTEXITCODE -ne 0) { throw "mike failed (exit $LASTEXITCODE)." }
    Write-Host "Published: https://docs.helixrf.com/$Product/$Version/" -ForegroundColor Green
}

if ($Landing) {
    Confirm-Publish 'the landing page'
    $pages = Join-Path (Split-Path $PSScriptRoot -Parent) 'helixrf-docs-pages'
    git worktree add -q $pages gh-pages
    try {
        Copy-Item -Recurse -Force (Join-Path $PSScriptRoot 'landing\*') $pages
        Push-Location $pages
        try {
            git add -A
            if (git status --porcelain) {
                git commit -q -m 'Update landing page'
                git push -q origin gh-pages
                Write-Host 'Landing page published: https://docs.helixrf.com/' -ForegroundColor Green
            }
            else {
                Write-Host 'Landing page unchanged; nothing to publish.'
            }
        }
        finally { Pop-Location }
    }
    finally {
        git worktree remove --force $pages
    }
}

if (-not ($Version -or $Landing -or $List)) {
    Get-Help $PSCommandPath -Examples
}
