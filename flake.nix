{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
  outputs = { self, nixpkgs }: {
    packages.x86_64-linux.default = nixpkgs.legacyPackages.x86_64-linux.buildEnv {
      name  = "devtools";
      paths = with nixpkgs.legacyPackages.x86_64-linux; [
# https://search.nixos.org/packages
        zsh zsh-autosuggestions zsh-syntax-highlighting
        neovim nodejs_18 # coc.nvim and copilot.vim require nodejs
        tmux
        bat
        fzf
        ranger
      ];
    };
  };
}
