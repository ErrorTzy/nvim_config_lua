return {
-- theme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha",
    },
  },
-- file browser
  {
    'stevearc/oil.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup({
        view_options = {
          show_hidden = true
        }
      })
      vim.keymap.set('n', '<C-n>', function ()
        local prev_win = vim.api.nvim_get_current_win()
        vim.cmd("vert Oil")
        vim.api.nvim_set_current_win(prev_win)
      end)
    end
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({
          aliases = {
            ['b'] = "**",
            ['i'] = "*",
          }
        })
    end
  },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = function ()
      require('nvim-autopairs').setup()
      local Rule = require('nvim-autopairs.rule')
      local npairs = require('nvim-autopairs')
      npairs.add_rule(Rule('*','*','markdown'))
    end
    -- use opts = {} for passing setup options
    -- this is equalent to setup({}) function
  },
  {'ErrorTzy/vim-marker-down'},
  {'bullets-vim/bullets.vim'},
}
