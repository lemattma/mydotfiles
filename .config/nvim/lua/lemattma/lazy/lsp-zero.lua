return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v4.x',
    dependencies = {
      'neovim/nvim-lspconfig',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/nvim-cmp',
      {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        lazy = false
      },

      {
        "williamboman/mason-lspconfig.nvim",
      },
    },
    lazy = false,
    config = function()
      -- Reserve a space in the gutter
      -- This will avoid an annoying layout shift in the screen
      vim.opt.signcolumn = 'yes'

      -- Add cmp_nvim_lsp capabilities settings to lspconfig
      -- This should be executed before you configure any language server
      local lspconfig_defaults = require('lspconfig').util.default_config
      lspconfig_defaults.capabilities = vim.tbl_deep_extend(
        'force',
        lspconfig_defaults.capabilities,
        require('cmp_nvim_lsp').default_capabilities()
      )

      -- This is where you enable features that only work
      -- if there is a language server active in the file
      vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function(event)
          local opts = { buffer = event.buf }

          vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
          vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
          vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
          vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
          vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
          vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
          vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
          vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
          vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
          vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
        end,
      })

      require("mason").setup()
      require('mason-lspconfig').setup({
        -- Replace the language servers listed here
        -- with the ones you want to install
        ensure_installed = { 'lua_ls', 'pyright' },
        handlers = {
          function(server_name)
            require('lspconfig')[server_name].setup({})
          end,
        }
      })
      -- Servers

      require 'lspconfig'.lua_ls.setup {
        lazy = false,
        on_init = function(client)

          if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc') then
              return
            end
          end

          client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
              -- Tell the language server which version of Lua you're using
              -- (most likely LuaJIT in the case of Neovim)
              version = 'LuaJIT'
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME
                -- Depending on the usage, you might want to add additional paths here.
                -- "${3rd}/luv/library"
                -- "${3rd}/busted/library",
              }
              -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
              -- library = vim.api.nvim_get_runtime_file("", true)
            }
          })
        end,
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' }
            }
          }
        }
      }

      -- Autocompletion
      local cmp = require('cmp')
      cmp.setup({
        sources = {
          { name = 'nvim_lsp' },
        },
        snippet = {
          expand = function(args)
            -- You need Neovim v0.10 to use vim.snippet
            vim.snippet.expand(args.body)
          end,
        },
        mapping = {
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<A-o>"] = cmp.mapping.select_prev_item(),
          ["<A-i>"] = cmp.mapping.select_next_item(),
          ["<A-u>"] = cmp.mapping.confirm({ select = true }),
          ["<C-e>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
          }),
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
          ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        },
        -- mapping = cmp.mapping.preset.insert({}),
      })

      local lsp = require('lsp-zero')
      -- lsp.preset('recommended')
      lsp.ensure_installed({
          'pyright', -- Python language server
          'tsserver', -- TypeScript language server
          'eslint', -- JavaScript and TypeScript linter
          'html', -- HTML language server
          'cssls', -- CSS language server
          'jsonls', -- JSON language server
          'tailwindcss', -- Tailwind CSS language server
          'sqlls', -- SQL language server for TypeORM
          -- 'prisma', -- Prisma language server
          -- 'graphql', -- GraphQL language server
          'yamlls', -- YAML language server
          'bashls', -- Bash language server
          'dockerls', -- Docker language server
          -- 'gopls', -- Go language server
          -- 'rust_analyzer', -- Rust language server
          -- 'terraformls', -- Terraform language server
          -- 'tflint', -- Terraform linter
          'lua_ls', -- Lua language server
          'vimls', -- Vim script language server
          'marksman', -- Markdown language server
          -- 'zk', -- Zettelkasten note-taking language server
          -- 'jdtls', -- Java language server
          -- 'kotlin_language_server', -- Kotlin language server
          -- 'texlab', -- LaTeX language server
          -- 'r_language_server', -- R language server
          'taplo', -- TOML language server
      })

      -- Associate Tiltfile with Python
      vim.cmd([[
        autocmd BufRead,BufNewFile Tiltfile set filetype=python
      ]])

      lsp.setup()
    end
  },


}
