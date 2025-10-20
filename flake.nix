{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    blink-cmp.url = "github:Saghen/blink.cmp/v1.7.0";
    repl = { url = "github:pappasam/nvim-repl"; flake = false; };
    chatbot = { url = "github:robitx/gp.nvim"; flake = false; };
  };

  outputs = inputs @ { self, nixpkgs, ... }: {

    packages.x86_64-linux.devtools = self.pkgs.buildEnv {
      name  = "devtools";
      paths = with self.pkgs; [
# https://search.nixos.org/packages
        zsh zsh-autosuggestions zsh-syntax-highlighting
        tmux bat fzf jq
        self.neovim copilot-language-server
      ];
    };

    packages.x86_64-linux.formatters = self.pkgs.buildEnv {
      name  = "formatters";
      paths = with self.pkgs; [
        ruff
        self.air
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
          blink-cmp
          copilot-lua
          ccc-nvim
          oil-nvim
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

    air = self.pkgs.stdenv.mkDerivation {
      pname = "air";
      version = "0.4.1";

      src = self.pkgs.fetchurl {
        url = "https://github.com/posit-dev/air/releases/download/0.4.1/air-x86_64-unknown-linux-gnu.tar.gz";
        sha256 = "10f7f682f888dfac0cc132eaad30f8d294e1fb7ae18713a1b428a97843e26934";
      };

      installPhase = ''
        mkdir -p $out/bin
        tar --directory $out/bin --file $src --strip-components 1 --extract --auto-compress
      '';
    };

  };
}
