require('telescope').setup {
  pickers = {
    buffers = {
      theme = "dropdown",
    },
    diagnostics = {
      theme = "dropdown",
      previewer = false,
    }
  }
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')
