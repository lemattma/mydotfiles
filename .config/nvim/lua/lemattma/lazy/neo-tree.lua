return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = function()
      require("neo-tree").setup({
        filesystem = {
          filtered_items = {
            visible = true,
            show_hidden_count = true,
            never_show = {},
            hide_hidden = false,
            hide_dotfiles = false,
          }
        }
      })

      vim.cmd([[nnoremap \ :Neotree reveal<cr>]])
      vim.cmd([[nnoremap \| :Neotree toggle<cr>]])
      -- vim.keymap.set('n', '<C-n>', ':Neotree reveal left<CR>')
    end
  }
}
