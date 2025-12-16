# =====================================================================
# Scoop – Install Required CLI Tools
# =====================================================================

# Check if Scoop is installed
if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
    Write-Host "Scoop not found. Installing Scoop..." -ForegroundColor Yellow
    Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
    Invoke-RestMethod get.scoop.sh | Invoke-Expression
} else {
    Write-Host "Scoop is already installed." -ForegroundColor Green
}

# Buckets
scoop bucket add main
scoop bucket add extras
scoop bucket add nerd-fonts
scoop bucket add versions

# Required tools
$tools = @(
    "git",
    "oh-my-posh",
    "starship",
    "fzf",
    "zoxide",
    "bat",
    "eza",
    "fd",
    "ripgrep",
    "delta",
    "neovim",
    "lazygit",
    "btm",
    "dust",
    "duf",
    "procs",
    "bandwhich",
    "dog",
    "glow",
    "neofetch"
)

Write-Host "`nInstalling required tools..." -ForegroundColor Cyan

foreach ($tool in $tools) {
    if (-not (scoop list | Select-String $tool)) {
        Write-Host "Installing $tool..." -ForegroundColor Yellow
        scoop install $tool
    } else {
        Write-Host "$tool already installed." -ForegroundColor Green
    }
}

Write-Host "`nAll tools installed and ready!" -ForegroundColor Cyan
# =====================================================================
