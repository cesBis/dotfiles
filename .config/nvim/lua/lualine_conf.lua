-- https://github.com/nvim-lualine/lualine.nvim#default-configuration
-- only need to be explicit when varying from default

return {
  sections = {
    lualine_a = {{'filename', path = 1}},
    lualine_b = {{'diagnostics', colored = false}},
    lualine_c = {'progress'},
    lualine_x = {'encoding', 'fileformat', {'filetype', icon_only = true}},
    lualine_y = {{'diff', colored = false}},
    lualine_z = {'branch'},
  },
  options = {
    globalstatus = true,
    component_separators = '',
    section_separators = '',
    theme = {
      normal = {
        a = { fg = '#00afff', bg = '#303030' },
        b = { fg = '#303030', bg = '#00afff' },
        c = { fg = '#909090', bg = '#080808' },
      },
    }
  },
}
