-- https://github.com/nvim-lualine/lualine.nvim#default-configuration
-- only need to be explicit when varying from default

require('lualine').setup {
  options = {
    theme = '16color',
    globalstatus = true,
    component_separators = '',
    section_separators = '',
  },
  sections = {
    lualine_a = {{'filename', path = 1}},
    lualine_b = {{'diagnostics', colored = false}},
    lualine_c = {'progress'},
    lualine_x = {'encoding', 'fileformat', {'filetype', icon_only = true}},
    lualine_y = {{'diff', colored = false}},
    lualine_z = {'branch'},
  },
}
