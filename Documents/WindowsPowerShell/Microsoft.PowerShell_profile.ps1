# Windows PowerShell 5.1 profile; PowerShell 7 dot-sources this file.

# by default R is aliased to Invoke-History, but I want it to start R
Remove-Item Alias:R -Force -ErrorAction SilentlyContinue

# git aliases, see .zshrc on main. Some names collide with built-in read-only aliases (gc, gl, gm, gps)
$gitAliases = [ordered]@{
  g = 'git'
  ga = 'git add'
  gapa = 'git add --patch'
  gau = 'git add --update'
  gb = 'git branch'
  gba = 'git branch --all'
  gbd = 'git branch --delete'
  gcp = 'git cherry-pick'
  gcpa = 'git cherry-pick --abort'
  gcpc = 'git cherry-pick --continue'
  gc = 'git commit --verbose'
  gd = 'git diff'
  gf = 'git fetch'
  gl = 'git log'
  glo = 'git log --oneline --decorate'
  gm = 'git merge'
  gma = 'git merge --abort'
  gmc = 'git merge --continue'
  gpl = 'git pull'
  gpr = 'git pull --rebase'
  gps = 'git push'
  grm = 'git rm'
  gstall = 'git stash --all'
  gstaa = 'git stash apply'
  gstc = 'git stash clear'
  gstd = 'git stash drop'
  gstl = 'git stash list'
  gstp = 'git stash pop'
  gst = 'git status'
  gss = 'git status --short'
  gsb = 'git status --short --branch'
  gsw = 'git switch'
  gswc = 'git switch --create'
}
foreach ($name in $gitAliases.Keys) {
  Remove-Item "Alias:$name" -Force -ErrorAction SilentlyContinue
  Set-Item "Function:global:$name" -Value ([scriptblock]::Create("$($gitAliases[$name]) @args"))
}

function la { Get-ChildItem -Force @args | Sort-Object { -[int]$_.PSIsContainer }, Name }
function lv { la @args | Format-Table Mode, Length, LastWriteTime, Name }

# vi-mode
Set-PSReadLineOption -EditMode Vi
function OnViModeChange {
  if ($args[0] -eq 'Command') {
    # Set the cursor to a block.
    Write-Host -NoNewLine "$([char]27)[2 q"
  } else {
    # Set the cursor to a line.
    Write-Host -NoNewLine "$([char]27)[6 q"
  }
}
Set-PSReadLineOption -ViModeIndicator Script -ViModeChangeHandler $Function:OnViModeChange -BellStyle None

foreach ($mode in 'Insert', 'Command') {
  Set-PSReadLineKeyHandler -ViMode $mode -Chord Ctrl+l -Function ClearScreen
}
Set-PSReadLineKeyHandler -ViMode Insert -Chord Tab -Function MenuComplete

# fzf key bindings (Ctrl+r history, Ctrl+t files), if PSFzf is installed
if (Get-Module -ListAvailable PSFzf) {
  Import-Module PSFzf
  Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
}
