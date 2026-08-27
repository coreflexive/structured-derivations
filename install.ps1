# install.ps1
# Installs this repository as a local Typst package by creating a junction
# from Typst's local package store to this Git working tree.
#
# Run from anywhere:
#   powershell -ExecutionPolicy Bypass -File .\install.ps1
#
# Or, if your execution policy already allows local scripts:
#   .\install.ps1

$ErrorActionPreference = "Stop"

function Fail([string]$Message) {
    Write-Host ""
    Write-Host "ERROR: $Message" -ForegroundColor Red
    exit 1
}

function Read-ManifestValue([string]$Text, [string]$Key) {
    $pattern = "(?m)^\s*" + [regex]::Escape($Key) + "\s*=\s*""([^""]+)""\s*$"
    $match = [regex]::Match($Text, $pattern)

    if (-not $match.Success) {
        Fail "Could not read '$Key' from typst.toml."
    }

    return $match.Groups[1].Value
}

# ---------------------------------------------------------------------------
# 1. Locate the repository and manifest
# ---------------------------------------------------------------------------

$RepoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$ManifestPath = Join-Path $RepoRoot "typst.toml"
$EntrypointPath = Join-Path $RepoRoot "lib.typ"

if (-not (Test-Path -LiteralPath $ManifestPath -PathType Leaf)) {
    Fail "typst.toml was not found beside install.ps1."
}

if (-not (Test-Path -LiteralPath $EntrypointPath -PathType Leaf)) {
    Fail "lib.typ was not found beside install.ps1."
}

$ManifestText = Get-Content -LiteralPath $ManifestPath -Raw
$PackageName = Read-ManifestValue $ManifestText "name"
$PackageVersion = Read-ManifestValue $ManifestText "version"

Write-Host "Structured Derivations installer" -ForegroundColor Cyan
Write-Host ""
Write-Host "Repository : $RepoRoot"
Write-Host "Package    : $PackageName"
Write-Host "Version    : $PackageVersion"

# ---------------------------------------------------------------------------
# 2. Ask Typst where its package directory is
# ---------------------------------------------------------------------------

$Typst = Get-Command typst -ErrorAction SilentlyContinue
if (-not $Typst) {
    Fail "'typst' is not available on PATH."
}

$TypstInfo = (& typst info 2>&1 | Out-String)

if ($LASTEXITCODE -ne 0) {
    Fail "'typst info' failed.`n$TypstInfo"
}

$PackagePathMatch = [regex]::Match(
    $TypstInfo,
    "(?m)^\s*Package path\s+(.+?)\s*$"
)

if (-not $PackagePathMatch.Success) {
    Fail "Could not determine the Typst package path from 'typst info'."
}

$TypstPackageRoot = $PackagePathMatch.Groups[1].Value.Trim()

# Expand environment variables if Typst ever reports them literally.
$TypstPackageRoot = [Environment]::ExpandEnvironmentVariables($TypstPackageRoot)

$PackageParent = Join-Path $TypstPackageRoot ("local\" + $PackageName)
$InstallPath = Join-Path $PackageParent $PackageVersion

Write-Host "Typst path : $TypstPackageRoot"
Write-Host "Install as : $InstallPath"
Write-Host ""

# ---------------------------------------------------------------------------
# 3. Create or refresh the junction
# ---------------------------------------------------------------------------

New-Item -ItemType Directory -Force -Path $PackageParent | Out-Null

if (Test-Path -LiteralPath $InstallPath) {
    $Existing = Get-Item -LiteralPath $InstallPath -Force

    if ($Existing.LinkType -eq "Junction") {
        $ExistingTarget = @($Existing.Target)[0]

        try {
            $ResolvedExisting = (Resolve-Path -LiteralPath $ExistingTarget).Path
            $ResolvedRepo = (Resolve-Path -LiteralPath $RepoRoot).Path
        }
        catch {
            $ResolvedExisting = $ExistingTarget
            $ResolvedRepo = $RepoRoot
        }

        if ($ResolvedExisting -ieq $ResolvedRepo) {
            Write-Host "Existing junction already points at this repository." -ForegroundColor Green
        }
        else {
            Write-Host "Replacing existing junction:" -ForegroundColor Yellow
            Write-Host "  old target: $ExistingTarget"
            Remove-Item -LiteralPath $InstallPath -Force
            New-Item -ItemType Junction -Path $InstallPath -Target $RepoRoot | Out-Null
            Write-Host "Junction updated." -ForegroundColor Green
        }
    }
    else {
        Fail @"
The install path already exists, but it is not a junction:

  $InstallPath

Nothing was removed. Move or delete that directory yourself, then rerun this script.
"@
    }
}
else {
    New-Item -ItemType Junction -Path $InstallPath -Target $RepoRoot | Out-Null
    Write-Host "Junction created." -ForegroundColor Green
}

# ---------------------------------------------------------------------------
# 4. Verify that Typst can resolve the package
# ---------------------------------------------------------------------------

$TempDir = Join-Path ([System.IO.Path]::GetTempPath()) (
    "structured-derivations-install-test-" + [guid]::NewGuid().ToString("N")
)

New-Item -ItemType Directory -Path $TempDir | Out-Null

try {
    $TestTyp = Join-Path $TempDir "test.typ"
    $TestPdf = Join-Path $TempDir "test.pdf"

    $Import = '#import "@local/' + $PackageName + ':' + $PackageVersion + '": *'
    $TestSource = $Import + "`r`n`r`n[Package installation test.]`r`n"

    Set-Content -LiteralPath $TestTyp -Value $TestSource -Encoding UTF8

    $CompileOutput = (& typst compile $TestTyp $TestPdf 2>&1 | Out-String)

    if ($LASTEXITCODE -ne 0) {
        Fail @"
The junction was created, but Typst could not import the package.

Compiler output:

$CompileOutput
"@
    }

    Write-Host "Typst import test passed." -ForegroundColor Green
}
finally {
    if (Test-Path -LiteralPath $TempDir) {
        Remove-Item -LiteralPath $TempDir -Recurse -Force
    }
}

Write-Host ""
Write-Host "Installed successfully." -ForegroundColor Green
Write-Host ""
Write-Host "Use it from any Typst project with:"
Write-Host ""
Write-Host ('  #import "@local/' + $PackageName + ':' + $PackageVersion + '": *') -ForegroundColor Cyan
Write-Host ""
