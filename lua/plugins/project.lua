return {
  "ahmedkhalf/project.nvim",
  config = function()
    require("project_nvim").setup({
      -- Detection methods to use
      detection_methods = { "lsp", "pattern" },
      
      -- Patterns to detect project root
      patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "Cargo.toml", "go.mod" },
      
      -- Show hidden files in telescope
      show_hidden = false,
      
      -- Don't calculate root directory on opening a file
      silent_chdir = true,
      
      -- Path to store project history
      datapath = vim.fn.stdpath("data"),
    })
    
    -- Enable telescope integration
    require('telescope').load_extension('projects')
  end,
}
