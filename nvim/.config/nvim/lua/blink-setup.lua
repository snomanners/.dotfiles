require('blink.cmp').setup {
  keymap = { preset = 'default' },

  appearance = {
    -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
    -- Adjusts spacing to ensure icons are aligned
    nerd_font_variant = 'mono'
  },

  completion = {
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 500,
    }
  },

  -- Default list of enabled providers defined so that you can extend it
  -- elsewhere in your config, without redefining it, due to `opts_extend`
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },

  signature = { enabled = true },
}
