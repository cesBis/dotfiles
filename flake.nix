{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    # many nvim packages are provided in nixpkgs, but not all
    repl = { url = "github:pappasam/nvim-repl"; flake = false; };
    chatbot = { url = "github:robitx/gp.nvim"; flake = false; };
    copilot = { url = "github:github/copilot.vim"; flake = false; };
  };

  outputs = inputs @ { self, nixpkgs, ... }: {

    rollVimPkg = src: pname:
      nixpkgs.legacyPackages.x86_64-linux.vimUtils.buildVimPlugin {
        inherit pname src;
        version = src.lastModifiedDate;
      };

    nvim_wrapper_config = nixpkgs.legacyPackages.x86_64-linux.neovimUtils.makeNeovimConfig {
      withPython3 = false;
      extraPython3Packages = (_: [ ]);
      withNodeJs = false;
      withRuby = false;
      extraLuaPackages = (_: [ ]);
      plugins = with nixpkgs.legacyPackages.x86_64-linux.vimPlugins; [
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
      wrapRc = false;
    };
    wrapped_nvim = nixpkgs.legacyPackages.x86_64-linux.wrapNeovimUnstable nixpkgs.legacyPackages.x86_64-linux.neovim-unwrapped self.nvim_wrapper_config;

    packages.x86_64-linux.default = nixpkgs.legacyPackages.x86_64-linux.buildEnv {
      name  = "devtools";
      paths = with nixpkgs.legacyPackages.x86_64-linux; [
# https://search.nixos.org/packages
        zsh zsh-autosuggestions zsh-syntax-highlighting
        self.wrapped_nvim nodejs_18 # coc.nvim and copilot.vim require nodejs
        tmux
        bat
        fzf
        ranger
      ];
    };
  };
}
