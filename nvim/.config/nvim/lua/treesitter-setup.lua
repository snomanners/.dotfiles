-- Install is deferred so it never slows startup; it's a no-op when everything is installed.
vim.defer_fn(function()
  require('nvim-treesitter').install({
    'lua', 'vim', 'vimdoc', 'query',
    'python', 'odin', 'go', 'gomod', 'gosum', 'kotlin',
    'javascript', 'typescript', 'tsx', 'html', 'css', 'svelte', 'angular',
    'json', 'yaml', 'toml', 'bash', 'markdown', 'markdown_inline',
    'gitcommit', 'git_rebase', 'git_config', 'gitignore', 'diff',
  })
end, 0)

-- Registered immediately (not deferred) so the first file opened from the
-- command line also gets treesitter highlighting.
-- See https://github.com/MeanderingProgrammer/treesitter-modules.nvim
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('treesitter.setup', {}),
  callback = function(args)
    local buf = args.buf
    local language = vim.treesitter.language.get_lang(args.match) or args.match
    if not vim.treesitter.language.add(language) then
      return
    end

    vim.treesitter.start(buf, language)
    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.wo.foldmethod = 'expr'

    if vim.treesitter.query.get(language, 'indents') then
      vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})
