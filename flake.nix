{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    repl = { url = "github:pappasam/nvim-repl"; flake = false; };
    chatbot = { url = "github:robitx/gp.nvim"; flake = false; };
  };

  outputs = inputs @ { self, nixpkgs, ... }: {

    packages.x86_64-linux.default = self.pkgs.buildEnv {
      name = "devtools";
      paths = with self.pkgs; [
# https://search.nixos.org/packages
        zsh zsh-autosuggestions zsh-syntax-highlighting
        tmux bat fzf jq
        self.neovim copilot-language-server
      ];
    };

    packages.x86_64-linux.py = self.pkgs.buildEnv {
      name = "python tools";
      paths = with self.pkgs; [
        uv ruff
      ];
    };

    packages.x86_64-linux.R = self.pkgs.buildEnv {
      name = "R tools";
      paths = with self.pkgs; [
        self.rig air-formatter
      ];
    };

    pkgs = import nixpkgs { system = "x86_64-linux"; config.allowUnfree = true; };

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
          (self.rollVimPkg inputs.chatbot "chatbot")
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

    rig = self.pkgs.stdenv.mkDerivation {
      pname = "rig";
      version = "0.7.1";

      src = self.pkgs.fetchurl {
        url = "https://github.com/r-lib/rig/releases/download/v0.7.1/rig-linux-0.7.1.tar.gz";
        sha256 = "5b48c32120d724b3932e1704e5a2d29b6757b6ccea6634876094b59c00075e9e";
      };

      buildPhase = ''
        tar --directory . --file $src --extract --auto-compress
      '';

      sourceRoot = "."; # https://stackoverflow.com/questions/77160863/nix-derivation-error-unpacker-produced-multiple-directories

      installPhase = ''
        mkdir -p $out/bin
        cp bin/rig $out/bin/rig
        cp -r share $out
      '';
    };
  };
}
