# Prompt
Import-Module posh-git
Import-Module oh-my-posh
# Set-PoshPrompt Night-owl

# Load prompt config
function Get-ScriptDirectory { Split-Path $MyInvocation.ScriptName }
$PROMPT_CONFIG = Join-Path (Get-ScriptDirectory) 'takuya.omp.json'
oh-my-posh --init --shell pwsh --config $PROMPT_CONFIG | Invoke-Expression
 
# Icons
Import-Module -Name Terminal-Icons

# PSReadLine
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView

# Fzf
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

# Alias
Set-Alias g git
Set-Alias grep findstr
Set-Alias ll ls
Set-Alias vim nvim

function Get-GitStatus { & git status $args }
New-Alias -Name gst -Value Get-GitStatus -Force -Option AllScope

function Get-GitCommit { & git commit -m $args }
New-Alias -Name gc -Value Get-GitCommit -Force -Option AllScope

function git-checkout { git checkout $args }
Set-Alias -Name gco -Value git-checkout

function git-addall { git add $args }
Set-Alias -Name ga -Value git-addall

function git-fetch { git fetch }
Set-Alias -Name gf -Value git-fetch

function Get-GitBranch { & git branch -av $args }
New-Alias -Name gb -Value Get-GitBranch -Force -Option AllScope

# Utilities

function which ($command) {
  Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

function back-dir { cd .. }
Set-Alias -Name .. -Value back-dir

function back-root { cd ~ }
Set-Alias -Name ~ -Value back-root
