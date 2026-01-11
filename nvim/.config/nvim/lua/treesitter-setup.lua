vim.defer_fn(function()
  -- Install does not run if all languages installed
  local languages = { 'lua', 'python', 'odin', 'javascript', 'typescript', 'vimdoc', 'vim'}
  require('nvim-treesitter').install(languages)

  -- Finally got it working through the docs at https://github.com/MeanderingProgrammer/treesitter-modules.nvim
  vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('treesitter.setup', {}),
    callback = function(args)
      local buf = args.buf
      local filetype = args.match

      local language = vim.treesitter.language.get_lang(filetype) or filetype
      if not vim.treesitter.language.add(language) then
        return
      end

      vim.treesitter.start(buf, language)
      vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      vim.wo.foldmethod = 'expr'

      vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  })
end, 0)
