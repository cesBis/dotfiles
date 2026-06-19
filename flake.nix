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

    packages.x86_64-linux.devtools = self.pkgs.buildEnv {
      name  = "devtools";
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

    packages.x86_64-linux.R = let
      rpkgs = inputs.R452.legacyPackages.x86_64-linux;
      rdeps = self.mkRDeps rpkgs;
      base = self.pkgs.buildEnv {
        name = "R 4.5.2";
        paths = [ rpkgs.R self.pkgs.air-formatter rpkgs.rPackages.renv ];
      };
    in self.pkgs.symlinkJoin {
      name = "R 4.5.2 wrapped";
      paths = [ base ];
      nativeBuildInputs = [ self.pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/R \
          --prefix PATH : ${self.pkgs.lib.makeBinPath rdeps.nativeBuildInputs} \
          --set LD_LIBRARY_PATH "${rdeps.LD_LIBRARY_PATH}" \
          --run 'export R_LIBS_SITE="$HOME/.nix-profile/library''${R_LIBS_SITE:+:$R_LIBS_SITE}"' \
          --run 'export R_LIBS_USER="$HOME/.local/lib/R"'
        wrapProgram $out/bin/Rscript \
          --prefix PATH : ${self.pkgs.lib.makeBinPath rdeps.nativeBuildInputs} \
          --set LD_LIBRARY_PATH "${rdeps.LD_LIBRARY_PATH}" \
          --run 'export R_LIBS_SITE="$HOME/.nix-profile/library''${R_LIBS_SITE:+:$R_LIBS_SITE}"' \
          --run 'export R_LIBS_USER="$HOME/.local/lib/R"'
      '';
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
      # TODO: consider explicit compiler tools (gcc, gfortran, make) for source package installs. maybe also pandoc?
      nativeBuildInputs = with rpkgs; [ pkg-config cmake ];
      buildInputs = with rpkgs; [ icu zlib curl openssl fontconfig harfbuzz fribidi freetype libpng libjpeg libtiff libxml2 cairo libuv ];
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
