# Notes, configs, and more for setting up my dev space

`main` is for linux systems. The repo is cloned and runs `setup` with the repo as the working directory on GitHub codespace creation.
Also maintain a far less fancy `windows` branch.
Used to maintain a `wsl` branch as well, but let that go in favor of documenting its quirks in this README.

## WSL

As of now, I spend most of my time developing in WSL, so some of these notes are less about WSL and more about comforts for my pet.

### `/etc/wsl.conf`

https://learn.microsoft.com/en-us/windows/wsl/wsl-config

TODO: when rebuilding wsl with debian trixie circa 4/20, I didn't have to touch this file at all. Network just worked and `systemd = true` was already there.
Haven't installed docker or podman yet though, and I think the final command addressed a podman warning.

```
[network]
generateResolvConf = false
generateHosts = false

[boot]
systemd = true
command = mount --make-rshared /
```

See also [`wsl --manage <distro> --set-sparse true`](https://devblogs.microsoft.com/commandline/windows-subsystem-for-linux-september-2023-update/) command.

### `.Renviron`

```
# the sandbox slows down R startup time. https://rstudio.github.io/renv/reference/sandbox.html
# I don't use the site-library, and the default library only has base and recommended R packages, so it shouldn't be necessary on this machine
RENV_CONFIG_SANDBOX_ENABLED=FALSE
```

### `.Rprofile`

```R
options(help_type='html')

# reserve the user library for my current primary R version
# TODO see about "R_LIBS_USER" = paste0("~/.local/lib/R/", getRversion())
if (R.version$version.string == "R version 4.3.3 (2024-02-29)") {
  Sys.setenv("R_LIBS_USER" = "~/.local/lib/R/library")
  .libPaths(Sys.getenv("R_LIBS_USER"), include.site = FALSE)
  options(
    repos = c(POSIT = "https://p3m.dev/cran/__linux__/noble/2024-04-23"),
    # https://docs.posit.co/rspm/admin/serving-binaries/#binary-user-agents
    HTTPUserAgent = sprintf("R/%s R (%s)", getRversion(), paste(getRversion(), R.version["platform"], R.version["arch"], R.version["os"]))
  )
}
```

### `.gitconfig`

Use the github cli for authentication to GitHub.

```
gh auth login
gh auth setup-git
```

### Extra Environment Variables

Environment variables I don't want in the git managed `.zshrc` because they aren't applicable to codespaces, or because they're secret.

Put these in `.profile`

```
export BROWSER=wslview
# unlike .Rprofile and .zshrc, python doesn't have a startup script by default, but this gives it one
export PYTHONSTARTUP=$HOME/.pyrc
# Default WSL Path has a bunch of stuff from windows that slows down tab autocomplete
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
```

Secrets should go in `.zshenv`

```
export GITHUB_PAT=
export AWS_ACCESS_KEY_ID=
export AWS_SECRET_ACCESS_KEY=

export DATABRICKS_HOST=
export DATABRICKS_TOKEN=
export SPARK_REMOTE="sc://$DATABRICKS_HOST:443/;token=$DATABRICKS_TOKEN;x-databricks-cluster-id=$DATABRICKS_CLUSTER_ID"

export DATABRICKS_CLUSTER_ID=
#export DATABRICKS_CLUSTER_ID= # another cluster. I can switch between them by commenting out the other

export AZUREOPENAI_API_VERSION=
export AZUREOPENAI_ENDPOINT=
export AZUREOPENAI_API_KEY=
```

## Nix

When installed by curling the shell script, a `~/.nix-profile/etc/profile.d/nix.sh` is provided, which handles this.
When installed with apt, put this in `~/.profile`.

```
NIX_LINK="$HOME/.nix-profile"
if [ -e $NIX_LINK ]; then
  export PATH="$NIX_LINK/bin:$PATH"
  export XDG_DATA_DIRS="/usr/local/share/:/usr/share/:$NIX_LINK/share"
fi
```

Add to `/etc/nix/nix.conf` to let my `~/.config/nix/nix.conf` set certain options, like substituters (aka binary caches)

```
extra-trusted-users = conner
```
