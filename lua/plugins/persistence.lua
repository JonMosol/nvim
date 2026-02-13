return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  opts = {
    -- Directory where session files are saved
    dir = vim.fn.stdpath("state") .. "/sessions/",
    -- Minimum number of file buffers that need to be open to save
    need = 1,
    -- Use git branch in session name
    branch = true,
  },
  keys = {
    -- Restore the session for the current directory
    { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
    -- Restore the last session
    { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
    -- Stop auto-saving (useful before exiting without saving the session)
    { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Session" },
  },
}
