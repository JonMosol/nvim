return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- For icons (you already have this)
  },
  config = function()
    local wk = require("which-key")
    
    wk.setup({
      preset = "modern", -- Use modern preset for clean look
      delay = 500, -- 500ms delay before showing popup
      
      plugins = {
        marks = true, -- Shows marks when pressing ' and `
        registers = true, -- Shows registers when pressing " in normal/insert mode
        spelling = {
          enabled = true, -- Shows spelling suggestions when pressing z=
          suggestions = 20,
        },
        presets = {
          operators = true, -- Help for operators like d, y, c, etc.
          motions = true, -- Help for motions
          text_objects = true, -- Help for text objects (e.g., diw, ciw)
          windows = true, -- Default bindings on <C-w>
          nav = true, -- Misc bindings for navigation
          z = true, -- Bindings for folds, spelling, etc.
          g = true, -- Bindings prefixed with g
        },
      },
      
      icons = {
        breadcrumb = "»", -- Symbol for command mode breadcrumb
        separator = "➜", -- Symbol between key and description
        group = "+", -- Symbol prepended to group name
      },
      
      win = {
        border = "rounded", -- Border style: single, double, rounded, solid, shadow
        padding = { 1, 2 }, -- Extra padding [top/bottom, right/left]
      },
    })

    -- Register group names for better organization
    -- These create category headers when you press the leader key
    wk.add({
      { "\\f", group = "Find (Telescope)" },
      { "\\e", group = "Explorer (nvim-tree)" },
      { "\\d", group = "Debug (DAP)" },
      { "\\dp", group = "Debug Python" },
      { "\\g", group = "Git" },
      { "\\c", group = "Code (LSP)" },
      { "\\r", group = "Refactor" },
      
      -- LSP 'g' prefix mappings (these are buffer-local, shown when LSP is active)
      { "g", group = "Go to (LSP)" },
      { "gd", desc = "Go to definition" },
      { "gD", desc = "Go to declaration" },
      { "gr", desc = "Go to references" },
      { "gi", desc = "Go to implementation" },
      { "gp", desc = "Peek definition" },
      { "gs", desc = "Go to definition (split)" },
      { "gv", desc = "Go to definition (vsplit)" },
      
      -- Diagnostic navigation
      { "[", group = "Previous" },
      { "[d", desc = "Previous diagnostic" },
      { "]", group = "Next" },
      { "]d", desc = "Next diagnostic" },
    })
  end,
}
