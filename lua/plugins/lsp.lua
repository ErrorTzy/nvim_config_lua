return {
{
	"L3MON4D3/LuaSnip",
  version = "v2.*",
	build = "make install_jsregexp",
  config = function ()
    local ls = require("luasnip")
    vim.keymap.set({"i"}, "<Tab>", function() ls.expand() end, {silent = true})
    vim.keymap.set({"i", "s"}, "<Tab>", function() ls.jump( 1) end, {silent = true})
    vim.keymap.set({"i", "s"}, "<S-Tab>", function() ls.jump(-1) end, {silent = true})
  end
},
{
  "neovim/nvim-lspconfig",
  config = function ()
    require("luasnip.loaders.from_lua").load({
      paths = "~/.config/nvim/snippets/"
    })
    require("luasnip").config.set_config({
      enable_autosnippets = true,
    })
    local untrigger = function()
      -- get the snippet
      local snip = require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()].parent.snippet
      -- get its trigger
      local trig = snip.trigger
      -- replace that region with the trigger
      local node_from, node_to = snip.mark:pos_begin_end_raw()
      vim.api.nvim_buf_set_text(
        0,
        node_from[1],
        node_from[2],
        node_to[1],
        node_to[2],
        { trig }
      )
      -- reset the cursor-position to ahead the trigger
      vim.fn.setpos(".", { 0, node_from[1] + 1, node_from[2] + 1 + string.len(trig) })
    end


    vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
      if require("luasnip").in_snippet() then
        untrigger()
        require("luasnip").unlink_current()
      end
    end, {
      desc = "Undo a snippet",
    })
  end
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
          completion = { callSnippet = "Replace"},
          diagnostics = {
            globals = {
              'ls', -- require("luasnip")
              's', -- ls.snippet
              'sn', -- ls.snippet_node
              't', -- ls.text_node
              'i', -- ls.insert_node
              'f', -- ls.function_node
              'd', -- ls.dynamic_node
              'fmt', -- require("luasnip.extras.fmt").fmt
              'fmta', -- require("luasnip.extras.fmt").fmta
              'rep', -- require("luasnip.extras").rep
            }
          }
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
        {
          name = 'latex_symbols',
          option = {
            strategy = 0
          }
        },
      }, {
        { name = 'buffer' },
      })
    })

    -- specific filetype configuration
    cmp.setup.filetype('tex', {
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        {
          name = 'latex_symbols',
          option = {
            strategy = 2
          }
        },
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
