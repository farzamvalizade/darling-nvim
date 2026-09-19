vim.pack.add {
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/mason-org/mason-lspconfig.nvim',
  'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim',
  'https://github.com/j-hui/fidget.nvim',
}

-- =========================================================
-- Mason
-- =========================================================

require('mason').setup()

require('mason-tool-installer').setup {
  ensure_installed = {
    -- Python
    'pyright',
    'ruff',

    -- JavaScript / TypeScript / Vue
    'typescript-language-server',
    'vue-language-server',

    -- Web
    'html-lsp',
    'css-lsp',
    'tailwindcss-language-server',
    'json-lsp',

    -- Config / DevOps
    'yaml-language-server',
    'dockerfile-language-server',
    'terraform-ls',

    -- SQL
    'sqlls',

    -- Lua / Neovim
    'lua-language-server',
    'stylua',
  },
}

-- =========================================================
-- Fidget
-- =========================================================

require('fidget').setup {
  notification = {
    window = {
      winblend = 0,
    },
  },
}

-- =========================================================
-- LSP capabilities
-- =========================================================

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities = vim.tbl_deep_extend(
  'force',
  capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

-- =========================================================
-- LSP keymaps
-- =========================================================

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),

  callback = function(event)
    local map = function(keys, func, desc, mode)
      vim.keymap.set(mode or 'n', keys, func, {
        buffer = event.buf,
        desc = 'LSP: ' .. desc,
      })
    end

    local builtin = require('telescope.builtin')

    -- Navigation
    map('gd', builtin.lsp_definitions, 'Goto Definition')
    map('gr', builtin.lsp_references, 'Goto References')
    map('gI', builtin.lsp_implementations, 'Goto Implementation')
    map('gD', vim.lsp.buf.declaration, 'Goto Declaration')

    map(
      '<leader>D',
      builtin.lsp_type_definitions,
      'Goto Type Definition'
    )

    -- Symbols
    map(
      '<leader>ds',
      builtin.lsp_document_symbols,
      'Document Symbols'
    )

    map(
      '<leader>ws',
      builtin.lsp_dynamic_workspace_symbols,
      'Workspace Symbols'
    )

    -- Actions
    map('<leader>rn', vim.lsp.buf.rename, 'Rename')

    map(
      '<leader>ca',
      vim.lsp.buf.code_action,
      'Code Action',
      { 'n', 'x' }
    )

    -- Documentation
    map('K', vim.lsp.buf.hover, 'Hover Documentation')

    map(
      '<C-k>',
      vim.lsp.buf.signature_help,
      'Signature Help',
      'i'
    )

    -- =====================================================
    -- Document highlighting
    -- =====================================================

    local client = vim.lsp.get_client_by_id(event.data.client_id)

    if client
      and client:supports_method(
        vim.lsp.protocol.Methods.textDocument_documentHighlight
      )
    then
      local highlight_group = vim.api.nvim_create_augroup(
        'lsp-highlight',
        { clear = false }
      )

      vim.api.nvim_create_autocmd(
        { 'CursorHold', 'CursorHoldI' },
        {
          buffer = event.buf,
          group = highlight_group,
          callback = vim.lsp.buf.document_highlight,
        }
      )

      vim.api.nvim_create_autocmd(
        { 'CursorMoved', 'CursorMovedI' },
        {
          buffer = event.buf,
          group = highlight_group,
          callback = vim.lsp.buf.clear_references,
        }
      )
    end

    -- =====================================================
    -- Inlay hints
    -- =====================================================

    if client
      and client:supports_method(
        vim.lsp.protocol.Methods.textDocument_inlayHint
      )
    then
      map('<leader>th', function()
        vim.lsp.inlay_hint.enable(
          not vim.lsp.inlay_hint.is_enabled {
            bufnr = event.buf,
          }
        )
      end, 'Toggle Inlay Hints')
    end
  end,
})

-- =========================================================
-- LSP servers
-- =========================================================

local servers = {

  -- =======================================================
  -- Python
  -- =======================================================

  pyright = {
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = 'workspace',
          typeCheckingMode = 'basic',
        },
      },
    },
  },

  ruff = {},

  -- =======================================================
  -- JavaScript / TypeScript / React
  -- =======================================================

  ts_ls = {
    settings = {
      javascript = {
        inlayHints = {
          includeInlayParameterNameHints = 'all',
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
        },
      },

      typescript = {
        inlayHints = {
          includeInlayParameterNameHints = 'all',
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
        },
      },
    },
  },

  -- =======================================================
  -- Vue
  -- =======================================================

  vue_ls = {},

  -- =======================================================
  -- HTML
  -- =======================================================

  html = {
    filetypes = {
      'html',
      'htmldjango',
      'twig',
      'hbs',
    },
  },

  -- =======================================================
  -- CSS / SCSS
  -- =======================================================

  cssls = {
    filetypes = {
      'css',
      'scss',
      'less',
    },
  },

  -- =======================================================
  -- Tailwind
  -- =======================================================

  tailwindcss = {
    filetypes = {
      'html',
      'htmldjango',
      'css',
      'scss',
      'javascript',
      'javascriptreact',
      'typescript',
      'typescriptreact',
      'vue',
    },
  },

  -- =======================================================
  -- JSON
  -- =======================================================

  jsonls = {},

  -- =======================================================
  -- YAML
  -- =======================================================

  yamlls = {},

  -- =======================================================
  -- Docker
  -- =======================================================

  dockerls = {},

  -- =======================================================
  -- SQL
  -- =======================================================

  sqlls = {},

  -- =======================================================
  -- Terraform
  -- =======================================================

  terraformls = {},

  -- =======================================================
  -- Lua / Neovim
  -- =======================================================

  lua_ls = {
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
        },

        completion = {
          callSnippet = 'Replace',
        },

        workspace = {
          checkThirdParty = false,
          library = vim.api.nvim_get_runtime_file('', true),
        },

        diagnostics = {
          globals = {
            'vim',
          },

          disable = {
            'missing-fields',
          },
        },

        format = {
          enable = false,
        },
      },
    },
  },
}

-- =========================================================
-- Configure + enable LSPs
-- =========================================================

for server, config in pairs(servers) do
  config.capabilities = vim.tbl_deep_extend(
    'force',
    {},
    capabilities,
    config.capabilities or {}
  )

  vim.lsp.config(server, config)
  vim.lsp.enable(server)
end
