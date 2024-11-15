require("oil").setup {
  -- true breaks :GBrowse
  default_file_explorer = false,
  skip_confirm_for_simple_edits = true,
  view_options = {
      show_hidden = true,
    },
}
