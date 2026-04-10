{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    repl = { url = "github:pappasam/nvim-repl"; flake = false; };
    # https://history.nix-packages.com/ or github:jamesbrink/nxv
    R433nixpkgs.url = "github:nixos/nixpkgs/87f7f76";
  };

  outputs = inputs @ { self, ... }: {

    pkgs = import inputs.nixpkgs { system = "x86_64-linux"; config.allowUnfree = true; };
    young-pkgs = import inputs.nixpkgs-unstable { system = "x86_64-linux"; config.allowUnfree = true; };

    packages.x86_64-linux.default = self.pkgs.buildEnv {
      name = "devtools";
      paths = with self.pkgs; [
        # https://search.nixos.org/packages
        zsh zsh-autosuggestions zsh-syntax-highlighting
        tmux bat fzf jq
        self.neovim
        self.young-pkgs.opencode
      ];
    };

    packages.x86_64-linux.github-copilot = self.pkgs.buildEnv {
      name = "github copilot integration";
      paths = with self.pkgs; [
        copilot-language-server github-copilot-cli
      ];
    };

    packages.x86_64-linux.py = self.pkgs.buildEnv {
      name = "python tools";
      paths = with self.pkgs; [
        uv ruff
      ];
    };

    packages.x86_64-linux.R433 = self.pkgs.buildEnv {
      name = "R 4.3.3";
      paths = [ inputs.R433nixpkgs.legacyPackages.x86_64-linux.R self.pkgs.air-formatter ];
    };

    neovim = self.pkgs.wrapNeovimUnstable self.pkgs.neovim-unwrapped (
      self.pkgs.neovimUtils.makeNeovimConfig {
        plugins = with self.pkgs.vimPlugins; [
          nvim-web-devicons # used by lualine and oil
          lualine-nvim
          vim-fugitive vim-rhubarb
          vim-commentary
          blink-cmp blink-copilot
          nvim-lspconfig
          ccc-nvim
          oil-nvim
          outline-nvim
          (self.rollVimPkg inputs.repl "repl")
          self.young-pkgs.vimPlugins.opencode-nvim
        ];
        withNodeJs = false;
        withPython3 = false;
        extraPython3Packages = (_: [ ]);
        withRuby = false;
        extraLuaPackages = (_: [ ]);
        wrapRc = false;
      }
    );

    rollVimPkg = src: pname: self.pkgs.vimUtils.buildVimPlugin { inherit pname src; version = src.lastModifiedDate; };

  };
}
