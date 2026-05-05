require('lualine').setup {
  options = {
    component_separators = '',
    section_separators = '',
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {''},
    lualine_y = {'progress'},
    lualine_z = {'lsp_status', 'location'}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {'fzf'}
}
