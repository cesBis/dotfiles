options(
  help_type='html',
  # https://stackoverflow.com/a/1448823
  # https://gist.github.com/fnky/458719343aabd01cfb17a3a4f7296797#color-codes
  prompt = '\x01\x1b[1;13;35m\x02>\x01\x1b[0m\x02 ',
  continue = '\x01\x1b[1;13;35m\x02+\x01\x1b[0m\x02 '
)

# only apply to the host R installation, not distrobox R installations
if (R.version$version.string == "R version 4.3.3 (2024-02-29)") {
  Sys.setenv("R_LIBS_USER" = "~/.local/lib/R/library")
  .libPaths(Sys.getenv("R_LIBS_USER"), include.site = FALSE)
  options(
    repos = c(POSIT = "https://p3m.dev/cran/__linux__/noble/2024-04-23"),
    # https://docs.posit.co/rspm/admin/serving-binaries/#binary-user-agents
    HTTPUserAgent = sprintf("R/%s R (%s)", getRversion(), paste(getRversion(), R.version["platform"], R.version["arch"], R.version["os"]))
  )
}
