# =====================================================================
#  PowerShell Profile
#  Author: Krzysztof
#  Description: Modern terminal setup for Windows
#  Date: 17.12.25
# =====================================================================

# -----------------------------
# Prompt Selector
# -----------------------------
Write-Host "Select prompt engine:" -ForegroundColor Cyan
Write-Host "1 - oh-my-posh"
Write-Host "2 - starship"

$choice = Read-Host "Enter number"

switch ($choice) {
    "1" {
        oh-my-posh init pwsh --config "$HOME\Documents\PowerShell\gsystem.json" | Invoke-Expression
        Write-Host "Loaded oh-my-posh" -ForegroundColor Green
    }
    "2" {
        $ENV:STARSHIP_CONFIG = "$HOME\.config\starship\starship.toml"
        Invoke-Expression (& starship init powershell)
        Write-Host "Loaded starship" -ForegroundColor Green
    }
    default {
        Write-Host "Invalid choice, loading oh-my-posh" -ForegroundColor Yellow
        oh-my-posh init pwsh --config "$HOME\Documents\PowerShell\gsystem.json" | Invoke-Expression
    }
}

# -----------------------------
# History Viewer
# -----------------------------
function Show-HistoryFile {
    bat "$env:APPDATA\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt"
}
Set-Alias hist Show-HistoryFile

# -----------------------------
# Modules
# -----------------------------
Import-Module Terminal-Icons
Import-Module posh-git
Import-Module PSFzf

# zoxide (smart cd)
Invoke-Expression (& { (zoxide init powershell | Out-String) })

# -----------------------------
# Aliases (Linux-like tools)
# -----------------------------
Set-Alias cat bat
Set-Alias ls eza
Set-Alias grep rg
Set-Alias find fd
Set-Alias ll "eza -lh"
Set-Alias la "eza -lha"
Set-Alias tree "eza --tree"

# -----------------------------
# PSReadLine (history + suggestions)
# -----------------------------
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -Colors @{
    "Command"   = "Yellow"
    "Parameter" = "Cyan"
    "String"    = "Magenta"
}

# -----------------------------
# Fuzzy Finder (fzf)
# -----------------------------
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' `
                -PSReadlineChordReverseHistory 'Ctrl+r' `
                -TabExpansion 'Ctrl+Spacebar'

# -----------------------------
# Git Enhancements (delta)
# -----------------------------
git config --global core.pager delta
git config --global interactive.diffFilter "delta --color-only"
git config --global delta.navigate true
git config --global delta.light true

# -----------------------------
# Installed CLI Tools (reference)
# -----------------------------
# btm       → system monitor
# dust      → disk usage
# duf       → disk free
# procs     → process viewer
# bandwhich → network monitor
# dog       → DNS lookup
# glow      → Markdown viewer
# lazygit   → Git UI
# nvim      → terminal editor
# neofetch  → system info
# =====================================================================
