return {
{ "junegunn/fzf", build = "./install --bin" },
{
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- calling `setup` is optional for customization
    require("fzf-lua").setup({})
    vim.keymap.set("n", 
    "<C-f>", 
    "<cmd>lua require('fzf-lua').files()<CR>", 
    { silent = true })
  end
},
}
