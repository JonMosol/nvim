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

    -- Register keymaps for which-key (flat list, no groups)
    wk.add({
      -- Telescope (Find)
      { "\\ff", desc = "Find files" },
      { "\\fF", desc = "Find ALL files (hidden + ignored)" },
      { "\\fg", desc = "Live grep" },
      { "\\fb", desc = "Find buffers" },
      { "\\fh", desc = "Help tags" },
      { "\\fr", desc = "Recent files" },
      { "\\fw", desc = "Find word under cursor" },
      
      -- Explorer (nvim-tree & Oil)
      { "\\e", desc = "Toggle nvim-tree" },
      { "\\ef", desc = "Find current file in nvim-tree" },
      { "\\o", desc = "Open Oil file explorer" },
      { "\\O", desc = "Open Oil (floating window)" },
      { "-", desc = "Open parent directory (Oil)" },
      
      -- Debug (DAP) - using \b for "breakpoint/debug"
      { "\\bb", desc = "Toggle breakpoint" },
      { "\\bc", desc = "Continue/Start debugging" },
      { "\\bi", desc = "Step into" },
      { "\\bo", desc = "Step over" },
      { "\\bO", desc = "Step out" },
      { "\\br", desc = "Open REPL" },
      { "\\bl", desc = "Run last" },
      { "\\bt", desc = "Toggle DAP UI" },
      { "\\bx", desc = "Terminate debugging" },
      { "\\bB", desc = "Set conditional breakpoint" },
      { "\\bpm", desc = "Debug Python test method" },
      { "\\bpc", desc = "Debug Python test class" },
      
      -- Diagnostics (LSP) - freed up \d
      { "\\d", desc = "Show diagnostics (float)" },
      
      -- Git operations
      { "\\gg", desc = "LazyGit" },
      { "\\hs", desc = "Stage hunk" },
      { "\\hr", desc = "Reset hunk" },
      { "\\hS", desc = "Stage buffer" },
      { "\\hu", desc = "Undo stage hunk" },
      { "\\hR", desc = "Reset buffer" },
      { "\\hp", desc = "Preview hunk" },
      { "\\hb", desc = "Blame line" },
      { "\\hd", desc = "Diff this" },
      { "\\tb", desc = "Toggle line blame" },
      
      -- Markdown
      { "\\mt", desc = "Toggle markdown rendering" },
      { "\\me", desc = "Enable markdown rendering" },
      { "\\md", desc = "Disable markdown rendering" },
      
      -- Code actions (LSP)
      { "\\ca", desc = "Code action" },
      
      -- Refactor
      { "\\rn", desc = "Rename symbol" },
      
      -- Aerial
      { "\\a", desc = "Toggle Aerial" },
      { "\\an", desc = "Toggle Aerial Navigation" },
      
      -- LSP 'g' prefix mappings (these are buffer-local, shown when LSP is active)
      { "gd", desc = "Go to definition" },
      { "gD", desc = "Go to declaration" },
      { "gr", desc = "Go to references" },
      { "gi", desc = "Go to implementation" },
      { "gp", desc = "Peek definition" },
      { "gs", desc = "Go to definition (split)" },
      { "gv", desc = "Go to definition (vsplit)" },
      { "gow", desc = "Open with... (context menu)" },
      { "gx", desc = "Open with default app" },
      { "gy", desc = "Copy file/folder path" },
      { "gnn", desc = "Start incremental selection" },
      { "grn", desc = "Increment to upper named parent" },
      { "grc", desc = "Increment to upper scope" },
      { "grm", desc = "Decrement to previous node" },
      
      -- LSP Hover and other top-level keys
      { "K", desc = "Hover documentation (LSP)" },
      
      -- Flash motion keys
      { "s", desc = "Flash jump" },
      { "S", desc = "Flash treesitter" },
      
      -- Navigation
      { "[c", desc = "Previous git hunk" },
      { "[d", desc = "Previous diagnostic" },
      { "]c", desc = "Next git hunk" },
      { "]d", desc = "Next diagnostic" },
      
      -- Completion (insert mode - informational only)
      -- Note: These are insert mode mappings, which-key shows them differently
      { "<C-Space>", desc = "Trigger completion", mode = "i" },
      { "<Tab>", desc = "Next completion / Expand snippet", mode = "i" },
      { "<S-Tab>", desc = "Previous completion", mode = "i" },
      
      -- Autopairs
      { "<M-e>", desc = "Fast wrap (autopairs)", mode = "i" },
    })
  end,
}
