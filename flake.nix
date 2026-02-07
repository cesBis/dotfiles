{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    repl = { url = "github:pappasam/nvim-repl"; flake = false; };
    chatbot = { url = "github:robitx/gp.nvim"; flake = false; };
  };

  outputs = inputs @ { self, nixpkgs, ... }: {

    packages.x86_64-linux.default = self.pkgs.buildEnv {
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
        ruff air-formatter
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
  };
}
