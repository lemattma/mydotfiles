return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    requires = { { 'nvim-lua/plenary.nvim' } },
    config = function()
      local builtin = require('telescope.builtin')


      -- vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Telescope find files' })

      vim.keymap.set('n', '<C-p>', function()
        builtin.find_files({ hidden = true })
      end)

      vim.keymap.set('n', '<C-g>', function()
        builtin.git_files({ show_untracked = true })
      end)

      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})

      vim.keymap.set('n', '<leader>b', builtin.buffers)

      vim.keymap.set('n', ';', ':Telescope buffers sort_lastused=true<CR>', { noremap = true, silent = true })


      --vim.keymap.set('n', '<leader>ps', function()
      --	builtin.grep_string({ search = vim.fn.input("Grep > ") });
      --end)
      -- vim.keymap.nnoremap { '<leader>ff', ':Telescope find_files<CR>' }
      -- vim.keymap.nnoremap { '<leader>fg', ':Telescope live_grep<CR>' }
      -- vim.keymap.nnoremap { '<leader>fh', ':Telescope help_tags<CR>' }
    end
  },
}
