# Upgrade: `nixos-25.11` → `nixos-26.05`

**Release:** 26.05 "Yarara" (2026-05-30)
**Full release notes:** https://nixos.org/manual/nixos/stable/release-notes#sec-release-26.05

## nixpkgs revisions

| Branch | nixpkgs rev |
|--------|-------------|
| `nixos-25.11` (current) | `4e92bbcdb030f3b4782be4751dc08e6b6cb6ccf2` |
| `nixos-26.05` (target)  | `667d5cf1c59585031d743c78b394b0a647537c35` |

The 26.05 rev above was obtained with:

```sh
nix flake metadata "github:nixos/nixpkgs/nixos-26.05" --json | jq -r '.locked.rev'
```

To check what version string a branch resolves to:

```sh
nix eval --raw "github:nixos/nixpkgs/nixos-26.05#lib.version"
# → 26.05.20260623.667d5cf
```

To query a package version from any branch/rev without installing it:

```sh
nix eval --raw "github:nixos/nixpkgs/nixos-26.05#neovim.version"
nix eval --raw "github:nixos/nixpkgs/4e92bbcdb030f3b4782be4751dc08e6b6cb6ccf2#neovim.version"
# vim plugins live under vimPlugins.<name>:
nix eval --raw "github:nixos/nixpkgs/nixos-26.05#vimPlugins.blink-cmp.version"
```

---

## Core devtools package changes

- zsh
  - 25.11 version: 5.9
  - 26.05 version: 5.9.1
- zsh-autosuggestions
  - 25.11 version: 0.7.1
  - 26.05 version: 0.7.1
- zsh-syntax-highlighting
  - 25.11 version: 0.8.0
  - 26.05 version: 0.8.0
- tmux
  - 25.11 version: 3.6a
  - 26.05 version: 3.6a
- bat
  - 25.11 version: 0.26.1
  - 26.05 version: 0.26.1
- fzf
  - 25.11 version: 0.67.0
  - 26.05 version: 0.72.0
- jq
  - 25.11 version: 1.8.1
  - 26.05 version: 1.8.1
- neovim
  - 25.11 version: 0.11.7
  - 26.05 version: 0.12.3

---

## Neovim plugin changes

- nvim-web-devicons
  - 25.11 version: 0.100-1
  - 26.05 version: 0.100-1
- lualine-nvim
  - 25.11 version: scm-1
  - 26.05 version: scm-4
- vim-fugitive
  - 25.11 version: 2025-07-15
  - 26.05 version: 3.7 (2026-03-07)
- vim-rhubarb
  - 25.11 version: 2025-06-27
  - 26.05 version: 0-unstable-2025-06-27
- vim-commentary
  - 25.11 version: 2024-10-22
  - 26.05 version: 1.3 (2024-10-22)
- blink-cmp
  - 25.11 version: 1.8.0
  - 26.05 version: 1.10.2
- blink-copilot
  - 25.11 version: 2025-10-29
  - 26.05 version: 1.4.1 (2025-10-29)
- nvim-lspconfig
  - 25.11 version: 2025-11-20
  - 26.05 version: 2.9.0
| ccc-nvim | 2025-05-06 | 2.0.3 (2025-05-06) | **versioned release** |
| oil-nvim | 2.15.0 | 2.15.0 | same |
| outline-nvim | 2025-09-07 | 1.2.0 (2026-03-29) | **versioned release** |

Notable: `nvim-lspconfig` jumps to `2.9.0` — this version introduced breaking API changes
(handlers, `on_attach`, default capabilities). Review `:h lspconfig-changelog` after upgrade.
