{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    repl = { url = "github:pappasam/nvim-repl"; flake = false; };
    chatbot = { url = "github:robitx/gp.nvim"; flake = false; };
    copilot = { url = "github:github/copilot.vim"; flake = false; };
  };

  outputs = inputs @ { self, nixpkgs, ... }: {
# https://search.nixos.org/packages
    devtools = with self.pkgs; [
      zsh zsh-autosuggestions zsh-syntax-highlighting
      self.wrapped_nvim
      tmux
      bat
      fzf
      ranger
      jq
    ];

    formatters = with self.pkgs; [
      self.pkgs.ruff
      self.air
    ];

    chosen_vim_packages = with self.pkgs.vimPlugins; [
      nvim-web-devicons # used by lualine and oil
      nvim-autopairs
      lualine-nvim
      vim-fugitive vim-rhubarb
      vim-commentary
      vim-surround
      coc-nvim
      ccc-nvim
      oil-nvim
      (self.rollVimPkg inputs.repl "repl")
      (self.rollVimPkg inputs.chatbot "chatbot")
      (self.rollVimPkg inputs.copilot "copilot")
    ];

    pkgs = nixpkgs.legacyPackages.x86_64-linux;

    rollVimPkg = src: pname: self.pkgs.vimUtils.buildVimPlugin {
      inherit pname src;
      version = src.lastModifiedDate;
    };

    nvim_wrapper_config = self.pkgs.neovimUtils.makeNeovimConfig {
      withPython3 = false;
      extraPython3Packages = (_: [ ]);
      withNodeJs = true; # coc.nvim and copilot.vim require nodejs
      withRuby = false;
      extraLuaPackages = (_: [ ]);
      plugins = self.chosen_vim_packages;
      wrapRc = false;
    };
    wrapped_nvim = self.pkgs.wrapNeovimUnstable self.pkgs.neovim-unwrapped self.nvim_wrapper_config;

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

    packages.x86_64-linux.devtools = self.pkgs.buildEnv {
      name  = "devtools";
      paths = self.devtools;
    };

    packages.x86_64-linux.formatters = self.pkgs.buildEnv {
      name  = "formatters";
      paths = self.formatters;
    };
  };
}
