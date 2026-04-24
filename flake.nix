{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    repl = { url = "github:pappasam/nvim-repl"; flake = false; };
    # https://history.nix-packages.com/ or github:jamesbrink/nxv
    R433.url = "github:nixos/nixpkgs/87f7f76";
    R452.url = "github:nixos/nixpkgs/9bce378";
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

    devShells.x86_64-linux.R452 = let
      rpkgs = inputs.R452.legacyPackages.x86_64-linux;
      rdeps = self.mkRDeps rpkgs;
    in self.pkgs.mkShell {
      name = "R 4.5.2";
      packages = [ rpkgs.R self.pkgs.air-formatter self.pkgs.pandoc ];
      nativeBuildInputs = rdeps.nativeBuildInputs;
      buildInputs = rdeps.buildInputs;
      LD_LIBRARY_PATH = rdeps.LD_LIBRARY_PATH;
    };

    devShells.x86_64-linux.R433 = let
      rpkgs = inputs.R433.legacyPackages.x86_64-linux;
      rdeps = self.mkRDeps rpkgs;
    in self.pkgs.mkShell {
      name = "R 4.3.3";
      packages = [ rpkgs.R self.pkgs.air-formatter self.pkgs.pandoc ];
      nativeBuildInputs = rdeps.nativeBuildInputs;
      buildInputs = rdeps.buildInputs;
      LD_LIBRARY_PATH = rdeps.LD_LIBRARY_PATH;
    };

    mkRDeps = rpkgs: let
      # https://nixos.org/manual/nixpkgs/stable/#ssec-stdenv-dependencies-overview
      nativeBuildInputs = with rpkgs; [ pkg-config cmake ];
      buildInputs = with rpkgs; [ icu zlib curl openssl fontconfig harfbuzz fribidi freetype libpng libjpeg libtiff libxml2 cairo ];
      # so that renv can find the .so files in /nix/store
      LD_LIBRARY_PATH = self.pkgs.lib.makeLibraryPath buildInputs;
    in {
      inherit nativeBuildInputs buildInputs LD_LIBRARY_PATH;
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
