#Requires -Version 5.1

<#
.SYNOPSIS
    Creates symbolic links for Claude Code configuration on Windows
.DESCRIPTION
    This script creates symbolic links from the dotfiles/claude directory
    to the Windows Claude Code configuration directory (%APPDATA%\Claude)
.NOTES
    Requires Administrator privileges to create symbolic links on Windows
#>

# Stop on any error
$ErrorActionPreference = "Stop"

# Get the directory where this script lives
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$RepoRoot = Split-Path -Parent $ScriptDir
$DotfilesDir = Join-Path $RepoRoot "dotfiles"
$Module = "claude"
$SourceDir = Join-Path $DotfilesDir $Module
$TargetBase = $env:APPDATA
$BackupTimestamp = Get-Date -Format "yyyyMMdd_HHmmss"

# Check if running as Administrator
$IsAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $IsAdmin) {
    Write-Host "ERROR: This script requires Administrator privileges to create symbolic links." -ForegroundColor Red
    Write-Host "Please run PowerShell as Administrator and try again." -ForegroundColor Yellow
    exit 1
}

# Verify dotfiles directory exists
if (-not (Test-Path $DotfilesDir)) {
    Write-Host "Error: Dotfiles directory not found at $DotfilesDir" -ForegroundColor Red
    exit 1
}

# Verify module exists
if (-not (Test-Path $SourceDir)) {
    Write-Host "Error: Module $Module not found in $DotfilesDir" -ForegroundColor Red
    exit 1
}

Write-Host "Setting up symbolic links for $Module..." -ForegroundColor Cyan
Write-Host "Source: $SourceDir"
Write-Host "Target: $TargetBase"
Write-Host ""

# Track backups
$BackedUp = 0

# Define files to symlink with their paths relative to target base
$FilesToLink = @(
    @{
        Source = ".claude\CLAUDE.md"
        Target = "Claude\CLAUDE.md"
        Description = "CLAUDE.md"
    },
    @{
        Source = ".config\ccstatusline\settings.json"
        Target = "ccstatusline\settings.json"
        Description = "ccstatusline settings.json"
    }
)

# Backup existing files if they exist and are not symlinks
foreach ($File in $FilesToLink) {
    $TargetPath = Join-Path $TargetBase $File.Target

    if ((Test-Path $TargetPath) -and -not ((Get-Item $TargetPath).Attributes -band [System.IO.FileAttributes]::ReparsePoint)) {
        $BackupFile = "$TargetPath.backup.$BackupTimestamp"
        Write-Host "📦 Backing up existing $($File.Description)..." -ForegroundColor Yellow

        # Ensure parent directory exists for backup
        $BackupParent = Split-Path -Parent $BackupFile
        if (-not (Test-Path $BackupParent)) {
            New-Item -ItemType Directory -Path $BackupParent -Force | Out-Null
        }

        Move-Item -Path $TargetPath -Destination $BackupFile -Force
        Write-Host "   Saved to: $BackupFile" -ForegroundColor Gray
        $BackedUp++
    }
}

if ($BackedUp -gt 0) {
    Write-Host ""
    Write-Host "ℹ️  $BackedUp file(s) backed up. The module version will be used (module is source of truth)." -ForegroundColor Cyan
    Write-Host ""
}

# Create symbolic links
Write-Host "Creating symbolic links..." -ForegroundColor Cyan
$Errors = 0

foreach ($File in $FilesToLink) {
    $SourcePath = Join-Path $SourceDir $File.Source
    $TargetPath = Join-Path $TargetBase $File.Target
    $TargetParent = Split-Path -Parent $TargetPath

    # Ensure source file exists
    if (-not (Test-Path $SourcePath)) {
        Write-Host "✗ Error: Source file not found: $SourcePath" -ForegroundColor Red
        $Errors++
        continue
    }

    # Ensure target parent directory exists
    if (-not (Test-Path $TargetParent)) {
        Write-Host "  Creating directory: $TargetParent" -ForegroundColor Gray
        New-Item -ItemType Directory -Path $TargetParent -Force | Out-Null
    }

    # Remove existing symlink if it exists
    if (Test-Path $TargetPath) {
        $Item = Get-Item $TargetPath -Force
        if ($Item.Attributes -band [System.IO.FileAttributes]::ReparsePoint) {
            Remove-Item -Path $TargetPath -Force
        }
    }

    # Create symbolic link
    try {
        New-Item -ItemType SymbolicLink -Path $TargetPath -Target $SourcePath -Force | Out-Null
        Write-Host "✓ Created symlink for $($File.Description)" -ForegroundColor Green
    } catch {
        Write-Host "✗ Error creating symlink for $($File.Description): $_" -ForegroundColor Red
        $Errors++
    }
}

# Validate symlinks were created
Write-Host ""
Write-Host "Verifying symlinks..." -ForegroundColor Cyan

foreach ($File in $FilesToLink) {
    $TargetPath = Join-Path $TargetBase $File.Target

    if (Test-Path $TargetPath) {
        $Item = Get-Item $TargetPath -Force
        if ($Item.Attributes -band [System.IO.FileAttributes]::ReparsePoint) {
            $LinkTarget = $Item.Target
            Write-Host "✓ $($File.Description) symlink verified" -ForegroundColor Green
            Write-Host "  $TargetPath -> $LinkTarget" -ForegroundColor Gray
        } else {
            Write-Host "✗ Error: $($File.Description) exists but is not a symlink" -ForegroundColor Red
            $Errors++
        }
    } else {
        Write-Host "✗ Error: $($File.Description) symlink not created" -ForegroundColor Red
        $Errors++
    }
}

Write-Host ""
if ($Errors -eq 0) {
    Write-Host "✅ All symlinks created successfully!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Your configuration is now managed via symbolic links." -ForegroundColor Cyan
    Write-Host "Edit files in: $SourceDir" -ForegroundColor Cyan
    Write-Host "Changes will be reflected immediately in $TargetBase" -ForegroundColor Cyan
    exit 0
} else {
    Write-Host "❌ Failed to create $Errors symlink(s)" -ForegroundColor Red
    Write-Host ""
    Write-Host "Troubleshooting tips:" -ForegroundColor Yellow
    Write-Host "1. Make sure you're running PowerShell as Administrator" -ForegroundColor Yellow
    Write-Host "2. Check that Developer Mode is enabled (Settings > Update & Security > For developers)" -ForegroundColor Yellow
    Write-Host "3. Verify that the source files exist in $SourceDir" -ForegroundColor Yellow
    exit 1
}
