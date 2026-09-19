vim.pack.add {
  {
    src = 'https://github.com/nvim-treesitter/nvim-treesitter',
    version = 'main',
  },

}

local languages = {
  'lua',
  'vim',
  'vimdoc',
  'query',

  'html',
  'css',
  'scss',
  'javascript',
  'typescript',
  'tsx',
  'vue',
  'json',
  'jsonc',

  'python',
  'sql',
  'htmldjango',

  'yaml',
  'toml',
  'dockerfile',
  'bash',

  'markdown',
  'markdown_inline',
  'gitignore',

  'c',
  'cpp',
  'go',
  'rust',
}

require('nvim-treesitter').install(languages)


vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    if args.match == 'neo-tree' then
      return
    end

    pcall(vim.treesitter.start, args.buf)
  end,
})
