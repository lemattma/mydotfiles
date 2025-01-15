return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",  -- required
    "sindrets/diffview.nvim", -- optional - Diff integration

    -- Only one of these is needed.
    "nvim-telescope/telescope.nvim", -- optional
    "ibhagwan/fzf-lua",              -- optional
    "echasnovski/mini.pick",         -- optional
  },
  lazy = false,
  config = true,
  keys = {
    { "<leader>gc", "<cmd>lua require('neogit').open({'commit'})<CR>", desc = "Git commit" },
    { "<leader>gg", "<cmd>lua require('neogit').open()<CR>",           desc = "Git commit" },
  },
}
