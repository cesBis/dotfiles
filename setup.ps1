# Sets up a Windows user account from this repo. Runs on Windows PowerShell 5.1 and is safe to re-run.
# Each step reports what failed and the script carries on. See README.md for prerequisites.

$ErrorActionPreference = 'Stop'

function Step($name, [scriptblock]$body) {
  Write-Host "==> $name"
  try { & $body } catch { Write-Warning "$name failed: $_" }
}

function Install-WingetPackage($id) {
  if (-not (Get-Command winget -ErrorAction SilentlyContinue)) { throw 'winget not found' }
  winget list --id $id --exact --accept-source-agreements *> $null
  if ($LASTEXITCODE -eq 0) { Write-Host "$id already installed"; return }
  winget install --id $id --exact --scope user --silent --accept-package-agreements --accept-source-agreements
  if ($LASTEXITCODE -ne 0) { throw "winget install $id exited with $LASTEXITCODE" }
}

function Copy-Dotfile($relativePath, $destination) {
  New-Item -ItemType Directory -Force (Split-Path $destination) | Out-Null
  Copy-Item (Join-Path $PSScriptRoot $relativePath) $destination -Force
  Write-Host "copied $relativePath -> $destination"
}

Step 'Copy dotfiles' {
  Copy-Dotfile '.vimrc' (Join-Path $HOME '.vimrc')
  $documents = [Environment]::GetFolderPath('MyDocuments')
  Copy-Dotfile 'Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1' (Join-Path $documents 'WindowsPowerShell\Microsoft.PowerShell_profile.ps1')
  Copy-Dotfile 'Documents\PowerShell\Microsoft.PowerShell_profile.ps1' (Join-Path $documents 'PowerShell\Microsoft.PowerShell_profile.ps1')
}

Step 'Install fzf' { Install-WingetPackage 'junegunn.fzf' }
Step 'Install bat' { Install-WingetPackage 'sharkdp.bat' }

Step 'Clone fzf vim plugin' {
  $plugin = Join-Path $HOME '.vim\pack\dev\start\fzf'
  if (Test-Path $plugin) { Write-Host "$plugin already exists"; return }
  git clone --depth 1 https://github.com/junegunn/fzf.git $plugin
  if ($LASTEXITCODE -ne 0) { throw "git clone exited with $LASTEXITCODE" }
}

Step 'Install PSFzf' {
  if (Get-Module -ListAvailable PSFzf) { Write-Host 'PSFzf already installed'; return }
  Install-PackageProvider NuGet -Scope CurrentUser -Force | Out-Null
  Install-Module PSFzf -Scope CurrentUser -Force
}

Step 'Set EDITOR' {
  [Environment]::SetEnvironmentVariable('EDITOR', 'vim', 'User')
}

Step 'Enable dark mode' {
  $key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize'
  foreach ($name in 'AppsUseLightTheme', 'SystemUsesLightTheme') {
    Set-ItemProperty $key -Name $name -Value 0 -Type DWord
  }
}

Step 'Auto-hide taskbar' {
  Add-Type -Namespace Win32 -Name Taskbar -MemberDefinition @'
    [StructLayout(LayoutKind.Sequential)]
    public struct APPBARDATA {
      public uint cbSize; public IntPtr hWnd; public uint uCallbackMessage; public uint uEdge;
      public int left, top, right, bottom; public IntPtr lParam;
    }
    [DllImport("shell32.dll")] public static extern UIntPtr SHAppBarMessage(uint message, ref APPBARDATA data);
    [DllImport("user32.dll")] public static extern IntPtr FindWindow(string className, string windowName);
'@
  $data = New-Object Win32.Taskbar+APPBARDATA
  $data.cbSize = [Runtime.InteropServices.Marshal]::SizeOf($data)
  $data.hWnd = [Win32.Taskbar]::FindWindow('Shell_TrayWnd', $null)
  $data.lParam = [IntPtr]1 # ABS_AUTOHIDE
  [Win32.Taskbar]::SHAppBarMessage(10, [ref]$data) | Out-Null # ABM_SETSTATE
  $state = [Win32.Taskbar]::SHAppBarMessage(4, [ref]$data).ToUInt32() # ABM_GETSTATE
  if (-not ($state -band 1)) { throw 'the taskbar did not accept the auto-hide state' }
}
