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

| Package | 25.11 | 26.05 | Changed? |
|---------|-------|-------|----------|
| zsh | 5.9 | 5.9.1 | patch bump |
| zsh-autosuggestions | 0.7.1 | 0.7.1 | same |
| zsh-syntax-highlighting | 0.8.0 | 0.8.0 | same |
| tmux | 3.6a | 3.6a | same |
| bat | 0.26.1 | 0.26.1 | same |
| fzf | 0.67.0 | 0.72.0 | **minor bump** |
| jq | 1.8.1 | 1.8.1 | same |
| neovim | 0.11.7 | 0.12.3 | **minor bump** |

---

## Neovim plugin changes

| Plugin | 25.11 | 26.05 | Notes |
|--------|-------|-------|-------|
| nvim-web-devicons | 0.100-1 | 0.100-1 | same |
| lualine-nvim | scm-1 | scm-4 | upstream commits |
| vim-fugitive | 2025-07-15 | 3.7 (2026-03-07) | **versioned release** |
| vim-rhubarb | 2025-06-27 | 0-unstable-2025-06-27 | same content |
| vim-commentary | 2024-10-22 | 1.3 (2024-10-22) | **versioned release** |
| blink-cmp | 1.8.0 | 1.10.2 | **minor bump** |
| blink-copilot | 2025-10-29 | 1.4.1 (2025-10-29) | **versioned release** |
| nvim-lspconfig | 2025-11-20 | 2.9.0 | **versioned release** |
| ccc-nvim | 2025-05-06 | 2.0.3 (2025-05-06) | **versioned release** |
| oil-nvim | 2.15.0 | 2.15.0 | same |
| outline-nvim | 2025-09-07 | 1.2.0 (2026-03-29) | **versioned release** |

Notable: `nvim-lspconfig` jumps to `2.9.0` — this version introduced breaking API changes
(handlers, `on_attach`, default capabilities). Review `:h lspconfig-changelog` after upgrade.
