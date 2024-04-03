New-Alias time-sheet C:\Users\Conner.Smith\Documents\time\sheet.ps1

# by default R is aliased to Invoke-History, but I want it to start R
Remove-Alias R

# vi-mode
Set-PSReadlineOption -EditMode vi
function OnViModeChange {
    if ($args[0] -eq 'Command') {
        # Set the cursor to a block.
        Write-Host -NoNewLine "`e[2 q"
    } else {
        # Set the cursor to a line.
        Write-Host -NoNewLine "`e[6 q"
    }
}
Set-PSReadLineOption -ViModeIndicator Script -ViModeChangeHandler $Function:OnViModeChange -BellStyle None
