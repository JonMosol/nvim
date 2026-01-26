return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- optional, for file icons
  },
  config = function()
    -- Disable netrw (recommended for nvim-tree)
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    require("nvim-tree").setup({
      sort = {
        sorter = "case_sensitive",
      },
      view = {
        adaptive_size = true,
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = false,
        git_ignored = false,
      },
    })

    -- Keybindings
    vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<cr>', { desc = "Toggle file explorer" })
    vim.keymap.set('n', '<leader>ef', '<cmd>NvimTreeFindFile<cr>', { desc = "Find current file in explorer" })
  end,
}
