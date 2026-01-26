return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp", -- Connect LSP to nvim-cmp
  },
  config = function()
    -- Setup Mason first
    require("mason").setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        }
      }
    })

    -- Setup Mason-LSPConfig
    require("mason-lspconfig").setup({
      ensure_installed = {
        "pyright", -- Python LSP
      },
      automatic_installation = true,
    })

    -- Setup LSP capabilities for nvim-cmp
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    -- Function to peek definition in a floating window
    local function peek_definition()
      -- Get the first LSP client to use its position encoding
      local clients = vim.lsp.get_clients({ bufnr = 0 })
      if #clients == 0 then
        print("No LSP client attached")
        return
      end
      local client = clients[1]
      local params = vim.lsp.util.make_position_params(0, client.offset_encoding)
      return vim.lsp.buf_request(0, 'textDocument/definition', params, function(err, result, ctx, config)
        if err or not result or vim.tbl_isempty(result) then
          print("No definition found")
          return
        end
        
        -- Handle both single result and array of results
        local location = result[1] or result
        local uri = location.uri or location.targetUri
        local range = location.range or location.targetRange
        
        -- Get the file path and read it directly to avoid swap file issues
        local filepath = vim.uri_to_fname(uri)
        
        -- Read the file directly
        local file = io.open(filepath, 'r')
        if not file then
          print("Could not open file: " .. filepath)
          return
        end
        
        local all_lines = {}
        for line in file:lines() do
          table.insert(all_lines, line)
        end
        file:close()
        
        -- Get the lines to display
        local start_line = range.start.line
        local end_line = range['end'].line
        local context_start = math.max(1, start_line - 2)
        local context_end = math.min(#all_lines, end_line + 11)
        
        local lines = {}
        for i = context_start, context_end do
          table.insert(lines, all_lines[i])
        end
        
        -- Get the original buffer's filetype for syntax highlighting
        local ft = vim.filetype.match({ filename = filepath }) or 'text'
        
        -- Create floating window
        local width = math.min(80, vim.o.columns - 4)
        local height = math.min(#lines, math.floor(vim.o.lines * 0.4))
        
        local buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
        
        -- Set the filetype for syntax highlighting
        vim.api.nvim_set_option_value('filetype', ft, { buf = buf })
        
        local opts = {
          relative = 'cursor',
          width = width,
          height = height,
          row = 1,
          col = 0,
          style = 'minimal',
          border = 'rounded',
        }
        
        local win = vim.api.nvim_open_win(buf, true, opts)
        
        -- Set window options
        vim.api.nvim_set_option_value('winblend', 10, { win = win })
        vim.api.nvim_buf_set_keymap(buf, 'n', 'q', ':close<CR>', { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(buf, 'n', '<Esc>', ':close<CR>', { noremap = true, silent = true })
      end)
    end

    -- Functions to open definition in different windows
    local function definition_split()
      local clients = vim.lsp.get_clients({ bufnr = 0 })
      if #clients == 0 then return end
      local client = clients[1]
      local params = vim.lsp.util.make_position_params(0, client.offset_encoding)
      
      vim.lsp.buf_request(0, 'textDocument/definition', params, function(err, result, ctx, config)
        if err or not result or vim.tbl_isempty(result) then return end
        local location = result[1] or result
        local uri = location.uri or location.targetUri
        local range = location.range or location.targetRange
        
        vim.cmd('belowright split')  -- Split below
        vim.cmd('edit ' .. vim.uri_to_fname(uri))
        vim.api.nvim_win_set_cursor(0, {range.start.line + 1, range.start.character})
      end)
    end

    local function definition_vsplit()
      local clients = vim.lsp.get_clients({ bufnr = 0 })
      if #clients == 0 then return end
      local client = clients[1]
      local params = vim.lsp.util.make_position_params(0, client.offset_encoding)
      
      vim.lsp.buf_request(0, 'textDocument/definition', params, function(err, result, ctx, config)
        if err or not result or vim.tbl_isempty(result) then return end
        local location = result[1] or result
        local uri = location.uri or location.targetUri
        local range = location.range or location.targetRange
        
        vim.cmd('belowright vsplit')  -- Split to the right
        vim.cmd('edit ' .. vim.uri_to_fname(uri))
        vim.api.nvim_win_set_cursor(0, {range.start.line + 1, range.start.character})
      end)
    end

    -- LSP Keybindings using LspAttach autocmd
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        local bufnr = ev.buf
        
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to definition" })
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = bufnr, desc = "Go to declaration" })
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = bufnr, desc = "Go to references" })
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = bufnr, desc = "Go to implementation" })
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover documentation" })
        vim.keymap.set('n', 'gp', peek_definition, { buffer = bufnr, desc = "Peek definition" })
        vim.keymap.set('n', 'gs', definition_split, { buffer = bufnr, desc = "Go to definition (horizontal split)" })
        vim.keymap.set('n', 'gv', definition_vsplit, { buffer = bufnr, desc = "Go to definition (vertical split)" })
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename symbol" })
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code action" })
        vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { buffer = bufnr, desc = "Show diagnostics" })
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { buffer = bufnr, desc = "Previous diagnostic" })
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { buffer = bufnr, desc = "Next diagnostic" })
      end,
    })

    -- Function to detect Python path from .venv
    local function get_python_path()
      local cwd = vim.fn.getcwd()
      -- Check for common virtual environment locations
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
      
      return nil  -- Use system Python if no venv found
    end

    -- Setup Python LSP (pyright) using new vim.lsp.config API
    local python_path = get_python_path()
    vim.lsp.config.pyright = {
      cmd = { 'pyright-langserver', '--stdio' },
      filetypes = { 'python' },
      root_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', '.git' },
      capabilities = capabilities,
      settings = {
        python = {
          pythonPath = python_path,
          analysis = {
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            diagnosticMode = "workspace",
          }
        }
      }
    }

    vim.lsp.enable('pyright')

    -- Command to manually set Python path and restart LSP
    vim.api.nvim_create_user_command('PythonSetPath', function(opts)
      local path = opts.args
      -- Update the setting
      vim.lsp.config.pyright.settings.python.pythonPath = path
      -- Restart LSP clients
      vim.cmd('LspRestart')
      print('Python path set to: ' .. path)
    end, { nargs = 1, complete = 'file' })
  end,
}
