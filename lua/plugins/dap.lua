return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "mfussenegger/nvim-dap-python",
    "theHamsta/nvim-dap-virtual-text",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    local dap_python = require("dap-python")

    -- Setup DAP UI
    dapui.setup({
      icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
      mappings = {
        -- Use a table to apply multiple mappings
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
      },
      layouts = {
        {
          elements = {
            { id = "scopes", size = 0.25 },
            { id = "breakpoints", size = 0.25 },
            { id = "stacks", size = 0.25 },
            { id = "watches", size = 0.25 },
          },
          size = 40,
          position = "left",
        },
        {
          elements = {
            { id = "repl", size = 0.5 },
            { id = "console", size = 0.5 },
          },
          size = 10,
          position = "bottom",
        },
      },
    })

    -- Setup virtual text
    require("nvim-dap-virtual-text").setup({
      enabled = true,
      enabled_commands = true,
      highlight_changed_variables = true,
      highlight_new_as_changed = false,
      show_stop_reason = true,
      commented = false,
      only_first_definition = true,
      all_references = false,
    })

    -- Setup Python debugging
    -- Automatically finds python in your virtualenv
    local function get_python_path()
      local cwd = vim.fn.getcwd()
      local venv_paths = {
        cwd .. '/.venv/Scripts/python.exe',  -- Windows
        cwd .. '/.venv/bin/python',          -- Linux/Mac
        cwd .. '/venv/Scripts/python.exe',   -- Windows alternative
        cwd .. '/venv/bin/python',           -- Linux/Mac alternative
      }
      
      for _, path in ipairs(venv_paths) do
        if vim.fn.filereadable(path) == 1 then
          return path
        end
      end
      
      return 'python'  -- Fallback to system python
    end

    dap_python.setup(get_python_path())

    -- Automatically open/close UI when debugging starts/ends
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    -- Keybindings (using \b for "breakpoint/debug")
    vim.keymap.set('n', '<leader>bb', dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
    vim.keymap.set('n', '<leader>bc', dap.continue, { desc = "Continue/Start debugging" })
    vim.keymap.set('n', '<leader>bi', dap.step_into, { desc = "Step into" })
    vim.keymap.set('n', '<leader>bo', dap.step_over, { desc = "Step over" })
    vim.keymap.set('n', '<leader>bO', dap.step_out, { desc = "Step out" })
    vim.keymap.set('n', '<leader>br', dap.repl.open, { desc = "Open REPL" })
    vim.keymap.set('n', '<leader>bl', dap.run_last, { desc = "Run last" })
    vim.keymap.set('n', '<leader>bt', dapui.toggle, { desc = "Toggle DAP UI" })
    vim.keymap.set('n', '<leader>bx', dap.terminate, { desc = "Terminate debugging" })
    vim.keymap.set('n', '<leader>bB', function()
      dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
    end, { desc = "Set conditional breakpoint" })

    -- Python-specific keybindings
    vim.keymap.set('n', '<leader>bpm', function()
      require('dap-python').test_method()
    end, { desc = "Debug Python test method" })
    vim.keymap.set('n', '<leader>bpc', function()
      require('dap-python').test_class()
    end, { desc = "Debug Python test class" })

    -- DAP signs (icons in the gutter)
    vim.fn.sign_define('DapBreakpoint', { text='●', texthl='DapBreakpoint', linehl='', numhl='' })
    vim.fn.sign_define('DapBreakpointCondition', { text='◆', texthl='DapBreakpoint', linehl='', numhl='' })
    vim.fn.sign_define('DapBreakpointRejected', { text='○', texthl='DapBreakpoint', linehl='', numhl='' })
    vim.fn.sign_define('DapStopped', { text='→', texthl='DapStopped', linehl='debugPC', numhl='' })
  end,
}
