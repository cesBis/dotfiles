-- https://github.com/nvim-lualine/lualine.nvim#default-configuration
-- only need to be explicit when varying from default

require('lualine').setup {
  options = {
    globalstatus = true,
  },
  sections = {
    lualine_a = {{'filename', path = 1}},
    lualine_b = {'progress'},
    lualine_c = {'diagnostics'},
    lualine_x = {},
    lualine_y = {'diff', 'branch'},
    lualine_z = {'filetype', 'encoding', 'fileformat'},
  },
}
