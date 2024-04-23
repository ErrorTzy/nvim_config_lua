return {
-- { "folke/neodev.nvim",},
{
  "neovim/nvim-lspconfig"
},
{
	"L3MON4D3/LuaSnip",
  version = "v2.*",
	build = "make install_jsregexp"
},
{
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "saadparwaiz1/cmp_luasnip",
    "kdheepak/cmp-latex-symbols",
    "folke/neodev.nvim",
  },
  config = function()
    local neodev = require('neodev')
    neodev.setup({
      opts = {
        override = function(_,library)
          library.enabled = true
          library.plugins = true
        end,
      }
    })
    local lspconfig = require('lspconfig')
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    lspconfig.lua_ls.setup({
      settings = {
        Lua = {
          completion = { callSnippet = "Replace"}
        }
      }
    })
    lspconfig.pyright.setup {
      capabilities = capabilities
    }

    lspconfig.texlab.setup {
      capabilities = require('cmp_nvim_lsp').default_capabilities(),
      settings = {
        texlab = {
          build = {
            onSave = true,
            args = {
              "-pdf",
              "-interaction=nonstopmode",
              "-synctex=1",
              "-outdir=/home/scott/Documents/app_storage/LatexBuildfiles/",
              "%f"
            },
          },
          lint = { onSave = true,},
        },
      },
    }

    lspconfig.bashls.setup{}


    local cmp = require('cmp')
    cmp.setup({
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
      },

      mapping = cmp.mapping.preset.insert({
        ['<Tab>'] = cmp.mapping.confirm({ select = true })
      }),

      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
      }, {
        { name = 'buffer' },
      })
    })

    -- specific filetype configuration
    cmp.setup.filetype('gitcommit', {
      sources = cmp.config.sources({
        { name = 'git' },
      }, {
        { name = 'buffer' },
      })
    })

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
       { name = 'buffer' }
      }
    })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' }
     }, {
       { name = 'cmdline' }
     }),
     matching = { disallow_symbol_nonprefix_matching = false }
    })


  end,
}
}
