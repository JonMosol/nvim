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
      -- Telescope (Find)
      { "\\f", group = "Find (Telescope)" },
      { "\\ff", desc = "Find files" },
      { "\\fF", desc = "Find ALL files (hidden + ignored)" },
      { "\\fg", desc = "Live grep" },
      { "\\fb", desc = "Find buffers" },
      { "\\fh", desc = "Help tags" },
      { "\\fr", desc = "Recent files" },
      { "\\fw", desc = "Find word under cursor" },
      
      -- Explorer (nvim-tree)
      { "\\e", group = "Explorer (nvim-tree)" },
      { "\\ef", desc = "Find current file in explorer" },
      
      -- Debug (DAP)
      { "\\d", group = "Debug (DAP)" },
      { "\\db", desc = "Toggle breakpoint" },
      { "\\dc", desc = "Continue/Start debugging" },
      { "\\di", desc = "Step into" },
      { "\\do", desc = "Step over" },
      { "\\dO", desc = "Step out" },
      { "\\dr", desc = "Open REPL" },
      { "\\dl", desc = "Run last" },
      { "\\dt", desc = "Toggle DAP UI" },
      { "\\dx", desc = "Terminate debugging" },
      { "\\dB", desc = "Set conditional breakpoint" },
      { "\\dp", group = "Debug Python" },
      { "\\dpm", desc = "Debug Python test method" },
      { "\\dpc", desc = "Debug Python test class" },
      
      -- Git operations
      { "\\g", group = "Git" },
      { "\\gg", desc = "LazyGit" },
      { "\\h", group = "Git Hunks" },
      { "\\hs", desc = "Stage hunk" },
      { "\\hr", desc = "Reset hunk" },
      { "\\hS", desc = "Stage buffer" },
      { "\\hu", desc = "Undo stage hunk" },
      { "\\hR", desc = "Reset buffer" },
      { "\\hp", desc = "Preview hunk" },
      { "\\hb", desc = "Blame line" },
      { "\\hd", desc = "Diff this" },
      
      -- Toggles
      { "\\t", group = "Toggle" },
      { "\\tb", desc = "Toggle line blame" },
      
      -- Markdown
      { "\\m", group = "Markdown" },
      { "\\mt", desc = "Toggle markdown rendering" },
      { "\\me", desc = "Enable markdown rendering" },
      { "\\md", desc = "Disable markdown rendering" },
      
      -- Code actions (LSP)
      { "\\c", group = "Code (LSP)" },
      { "\\ca", desc = "Code action" },
      
      -- Refactor
      { "\\r", group = "Refactor" },
      { "\\rn", desc = "Rename symbol" },
      
      -- Aerial
      { "\\a", desc = "Toggle Aerial" },
      { "\\o", desc = "Toggle Aerial Navigation" },
      
      -- LSP 'g' prefix mappings (these are buffer-local, shown when LSP is active)
      { "g", group = "Go to (LSP)" },
      { "gd", desc = "Go to definition" },
      { "gD", desc = "Go to declaration" },
      { "gr", desc = "Go to references" },
      { "gi", desc = "Go to implementation" },
      { "gp", desc = "Peek definition" },
      { "gs", desc = "Go to definition (split)" },
      { "gv", desc = "Go to definition (vsplit)" },
      
      -- Navigation
      { "[", group = "Previous" },
      { "[c", desc = "Previous git hunk" },
      { "[d", desc = "Previous diagnostic" },
      { "]", group = "Next" },
      { "]c", desc = "Next git hunk" },
      { "]d", desc = "Next diagnostic" },
    })
  end,
}
