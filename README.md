# Windows branch

Far less fancy than `main`. Aims to work on arbitrary Windows endpoints, so setup is a single re-runnable `setup.ps1` that assumes as little as possible. Each step prints a warning if it fails and the script carries on.

`setup.ps1` copies the dotfiles, installs `fzf` and `bat` with winget, clones the fzf vim plugin into `~\.vim\pack`, installs the PSFzf module, sets `EDITOR`, enables dark mode, and auto-hides the taskbar.

## Prerequisites

- Windows PowerShell 5.1 is enough to run `setup.ps1`; PowerShell 7 is optional, but [soon should be built in to Windows](https://devblogs.microsoft.com/powershell/powershell-7-coming-to-windows/)
- [Git for Windows](https://gitforwindows.org/), which also provides vim, less, and friends. Its `usr\bin` directory must be on `PATH` (`vim` is set as `EDITOR`, and `bat` pages through `less`).
- `winget` for user-scope installs (`fzf`, `bat`). Skip or fall back to manual download where unavailable.
- PowerShell Gallery access, for modules such as PSFzf.

## Design constraints

- No admin rights: symlinks may not be allowed, so files are copied (or hardlinked), not symlinked.
- Process creation can be slow on managed endpoints, so keep shell startup and prompts free of subprocesses.
- Nothing may assume a persistent profile; setup must be safe to re-run.
