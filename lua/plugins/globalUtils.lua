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
      require("oil").setup({})
      vim.keymap.set('n', '<C-n>', '<cmd>:vert new<CR><cmd>Oil<CR>')
    end
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end
  },
  {
    'echasnovski/mini.pairs',
    version = false,
    config = function ()
      require('mini.pairs').setup()
    end
  },
  {'ErrorTzy/vim-marker-down'},
  {'bullets-vim/bullets.vim'}


}
