{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    # https://history.nix-packages.com/ or github:jamesbrink/nxv
    R433.url = "github:nixos/nixpkgs/87f7f76";
    R452.url = "github:nixos/nixpkgs/9bce378";
  };

  outputs = inputs @ { self, ... }: {

    pkgs = import inputs.nixpkgs { system = "x86_64-linux"; config.allowUnfree = true; };

    packages.x86_64-linux.devtools = self.pkgs.buildEnv {
      name  = "devtools";
      paths = with self.pkgs; [
        # https://search.nixos.org/packages
        zsh zsh-autosuggestions zsh-syntax-highlighting
        tmux bat fzf jq
        self.packages.x86_64-linux.tmux-workspace
        self.neovim
        opencode
      ];
    };

    packages.x86_64-linux.tmux-workspace = self.pkgs.writeShellApplication {
      name = "tmux-workspace";
      runtimeInputs = [ self.pkgs.tmux self.neovim self.pkgs.zsh self.pkgs.opencode ];
      text = builtins.readFile ./nix/tmux-workspace.sh;
    };

    packages.x86_64-linux.github-copilot = self.pkgs.buildEnv {
      name = "github copilot integration";
      paths = with self.pkgs; [
        copilot-language-server github-copilot-cli
      ];
    };

    packages.x86_64-linux.R = let
      rpkgs = inputs.R452.legacyPackages.x86_64-linux;
      rdeps = self.mkRDeps rpkgs;
      compilerSuffix = builtins.replaceStrings [ "-" ] [ "_" ] rpkgs.stdenv.hostPlatform.config;
      base = self.pkgs.buildEnv {
        name = "R 4.5.2";
        paths = [ rpkgs.R rpkgs.rPackages.renv self.pkgs.air-formatter self.pkgs.pandoc ];
      };
    in self.pkgs.symlinkJoin {
      name = "R 4.5.2 wrapped";
      paths = [ base ];
      nativeBuildInputs = [ self.pkgs.makeWrapper ];
      postBuild = ''
        for program in R Rscript; do
          wrapProgram "$out/bin/$program" \
            --prefix PATH : ${self.pkgs.lib.makeBinPath rdeps.nativeBuildInputs} \
            --set LD_LIBRARY_PATH "${rdeps.LD_LIBRARY_PATH}" \
            --set PKG_CONFIG_PATH "${rdeps.PKG_CONFIG_PATH}" \
            --prefix NIX_CFLAGS_COMPILE_${compilerSuffix} " " "${rdeps.NIX_CFLAGS_COMPILE}" \
            --prefix NIX_LDFLAGS_${compilerSuffix} " " "${rdeps.NIX_LDFLAGS}" \
            --set LOCALE_ARCHIVE "${self.pkgs.glibcLocales}/lib/locale/locale-archive" \
            --set-default LANG "en_US.UTF-8" \
            --set-default TZ "America/Indiana/Indianapolis" \
            --set RENV_CONFIG_SYSREQS_CHECK "${rdeps.RENV_CONFIG_SYSREQS_CHECK}" \
            --set RENV_CONFIG_PPM_ENABLED "${rdeps.RENV_CONFIG_PPM_ENABLED}" \
            --set-default PAGER "${self.pkgs.bat}/bin/bat" \
            --run 'export R_LIBS_SITE="$HOME/.nix-profile/library''${R_LIBS_SITE:+:$R_LIBS_SITE}"' \
            --run 'export R_LIBS_USER="$HOME/.local/lib/R"'
        done
      '';
    };

    devShells.x86_64-linux.R433 = let
      rpkgs = inputs.R433.legacyPackages.x86_64-linux;
      rdeps = self.mkRDeps rpkgs;
    in self.pkgs.mkShell {
      name = "R 4.3.3";
      packages = [ rpkgs.R self.pkgs.air-formatter ];
      inherit (rdeps) nativeBuildInputs buildInputs LD_LIBRARY_PATH PKG_CONFIG_PATH RENV_CONFIG_SYSREQS_CHECK RENV_CONFIG_PPM_ENABLED;
    };

    mkRDeps = rpkgs: let
      # https://nixos.org/manual/nixpkgs/stable/#ssec-stdenv-dependencies-overview
      nativeBuildInputs = with rpkgs; [ gcc gfortran pkg-config cmake gnumake ];
      buildInputs = with rpkgs; [ icu zlib curl openssl fontconfig harfbuzz fribidi freetype libpng libjpeg libtiff libwebp libxml2 cairo libuv ];
      # so that renv can find the .so files in /nix/store
      LD_LIBRARY_PATH = self.pkgs.lib.makeLibraryPath buildInputs;
      # so that source installs compile against the same libs (e.g. icu) that LD_LIBRARY_PATH provides at runtime
      PKG_CONFIG_PATH = self.pkgs.lib.makeSearchPath "lib/pkgconfig" (map self.pkgs.lib.getDev buildInputs);
      # Installed wrappers don't run mkShell's setup hooks; expose headers and linker paths explicitly.
      NIX_CFLAGS_COMPILE = self.pkgs.lib.concatMapStringsSep " " (pkg: "-I${self.pkgs.lib.getDev pkg}/include") buildInputs;
      NIX_LDFLAGS = self.pkgs.lib.concatMapStringsSep " " (pkg: "-L${self.pkgs.lib.getLib pkg}/lib") buildInputs;
      # disable renv behavior that's ignorant of nix, to install things from source code with the versions nix brought in
      RENV_CONFIG_PPM_ENABLED = "FALSE";
      RENV_CONFIG_SYSREQS_CHECK = "FALSE";
    in {
      inherit nativeBuildInputs buildInputs LD_LIBRARY_PATH PKG_CONFIG_PATH NIX_CFLAGS_COMPILE NIX_LDFLAGS RENV_CONFIG_PPM_ENABLED RENV_CONFIG_SYSREQS_CHECK;
    };

    neovim = self.pkgs.wrapNeovimUnstable self.pkgs.neovim-unwrapped {
    # general guidance on setting up neovim with nix https://github.com/NixOS/nixpkgs/blob/nixos-26.05/doc/languages-frameworks/neovim.section.md
    # wrapNeovimUnstable is https://github.com/NixOS/nixpkgs/blob/nixos-26.05/pkgs/applications/editors/neovim/wrapper.nix
        plugins = with self.pkgs.vimPlugins; [
          nvim-web-devicons # used by lualine and oil
          lualine-nvim
          vim-fugitive vim-rhubarb
          blink-cmp blink-copilot
          nvim-lspconfig
          ccc-nvim
          oil-nvim
          outline-nvim
          vim-slime
        ];
        wrapRc = false;
        # set to true when the machine has a gui
        waylandSupport = false;
    };

  };
}
