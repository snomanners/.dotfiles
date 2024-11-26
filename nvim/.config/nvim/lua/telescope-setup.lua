require('telescope').setup {
  pickers = {
    buffers = {
      theme = "dropdown",
    }
  }
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')
