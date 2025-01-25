# ANSI color codes for PowerShell
$RED = "`e[0;31m"
$GREEN = "`e[0;32m"
$YELLOW = "`e[0;33m"
$NC = "`e[0m" # No Color

# Function to check if Git is installed
function Check-GitInstalled {
    if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
        Error-Message "Git is not installed. Please install Git before running this script."
    }
}

# Function to display help message
function Show-Help {
    Write-Host "${GREEN}Usage: $($MyInvocation.MyCommand) [-h|--help] [-d|--directory <path>] [-p|--print]${NC}"
    Write-Host ""
    Write-Host "This script opens the remote Git repository URL in your default web browser."
    Write-Host ""
    Write-Host "${YELLOW}Options:${NC}"
    Write-Host "  -h, --help                Show this help message and exit"
    Write-Host "  -d, --directory <path>    Specify the Git repository directory (default: current directory)"
    Write-Host "  -p, --print               Only print the URL, don't open in browser"
}

# Function to display error messages
function Error-Message {
    Write-Host "${RED}Error: $($_)${NC}" -ForegroundColor Red
    exit 1
}

# Function to get the remote URL
function Get-RemoteUrl {
    git -C $args[0] config --get remote.origin.url 2>$null
}

# Function to convert SSH URL to HTTPS and clean up URL
function Clean-Url {
    param ($url)
    if ($url -match '^git@([^:]+):(.+)\.git$') {
        $domain = $matches[1]
        $path = $matches[2]
        return "https://$domain/$path"
    } elseif ($url -match '^git://') {
        return $url -replace '^git:', 'https:' -replace '\.git$', ''
    } elseif ($url -match '^https?://') {
        return $url -replace '\.git$', ''
    } else {
        return $url
    }
}

# Function to find the root of the Git repository
function Find-GitRoot {
    git -C $args[0] rev-parse --show-toplevel 2>$null
}

# Main script
Check-GitInstalled

# Default values
$RepoDir = "."
$PrintOnly = $false

# Parse command line arguments
for ($i = 0; $i -lt $args.Count; $i++) {
    switch ($args[$i]) {
        '-h' { Show-Help; exit 0 }
        '--help' { Show-Help; exit 0 }
        '-d' {
            if ($i + 1 -lt $args.Count) {
                $RepoDir = $args[$i + 1]
                $i++
            } else {
                Error-Message "Directory path is missing after -d|--directory option"
            }
        }
        '--directory' {
            if ($i + 1 -lt $args.Count) {
                $RepoDir = $args[$i + 1]
                $i++
            } else {
                Error-Message "Directory path is missing after -d|--directory option"
            }
        }
        '-p' { $PrintOnly = $true }
        '--print' { $PrintOnly = $true }
        default { Error-Message "Unknown option: $($args[$i])`nUse -h or --help for usage information" }
    }
}

# Validate the specified directory
if (-not (Test-Path $RepoDir)) {
    Error-Message "The specified directory does not exist: $RepoDir"
}

# Main script logic
$GitRoot = Find-GitRoot $RepoDir

if (-not $GitRoot) {
    Error-Message "Not a Git repository: $RepoDir"
}

$RemoteUrl = Get-RemoteUrl $GitRoot

if (-not $RemoteUrl) {
    Error-Message "No remote URL found in the Git repository: $GitRoot"
}

# Clean up the URL
$RemoteUrl = Clean-Url $RemoteUrl

if ($PrintOnly) {
    Write-Host "${GREEN}$RemoteUrl${NC}"
} else {
    # Open the URL in the default browser
    Start-Process $RemoteUrl
    Write-Host "${YELLOW}Opening URL: ${GREEN}$RemoteUrl${NC}"
}
