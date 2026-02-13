return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    -- Store the default previewer maker
    local default_maker = require("telescope.previewers").buffer_previewer_maker
    
    require("telescope").setup({
      defaults = {
        mappings = {
          i = {
            ["<C-j>"] = "move_selection_next",
            ["<C-k>"] = "move_selection_previous",
            -- Open in splits without closing Telescope
            ["<C-x>"] = "select_horizontal",
            ["<C-v>"] = "select_vertical",
            ["<C-t>"] = "select_tab",
            -- Open selected file's directory in Oil
            ["<leader>O"] = {
              function(prompt_bufnr)
                local actions = require("telescope.actions")
                local action_state = require("telescope.actions.state")
                local selection = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                
                if selection then
                  local filepath = selection.path or selection.filename
                  if filepath then
                    local dir = vim.fn.fnamemodify(filepath, ":h")
                    require("oil").open(dir)
                  end
                end
              end,
              type = "action",
              opts = { desc = "Open directory in Oil" }
            },
          },
          n = {
            ["<C-x>"] = "select_horizontal",
            ["<C-v>"] = "select_vertical",
            ["<C-t>"] = "select_tab",
            -- Open selected file's directory in Oil
            ["-"] = {
              function(prompt_bufnr)
                local actions = require("telescope.actions")
                local action_state = require("telescope.actions.state")
                local selection = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                
                if selection then
                  local filepath = selection.path or selection.filename
                  if filepath then
                    local dir = vim.fn.fnamemodify(filepath, ":h")
                    require("oil").open(dir)
                  end
                end
              end,
              type = "action",
              opts = { desc = "Open directory in Oil" }
            },
          },
        },
        -- Disable treesitter highlighting in preview to avoid ft_to_lang error
        preview = {
          treesitter = false,
        },
        buffer_previewer_maker = function(filepath, bufnr, opts)
          -- Check if file is an image
          local image_extensions = {"png", "jpg", "jpeg", "gif", "bmp", "webp", "tiff", "tif", "svg"}
          local ext = vim.fn.fnamemodify(filepath, ":e"):lower()
          
          if vim.tbl_contains(image_extensions, ext) then
            -- For images, show a message instead of binary data
            local file_stat = vim.loop.fs_stat(filepath)
            local size = file_stat and file_stat.size or 0
            local size_kb = math.floor(size / 1024)
            
            -- Set buffer options to prevent neo-img from triggering
            vim.schedule(function()
              if vim.api.nvim_buf_is_valid(bufnr) then
                -- Mark this as a special buffer type to prevent neo-img auto-display
                vim.api.nvim_buf_set_option(bufnr, 'buftype', 'nofile')
                vim.api.nvim_buf_set_option(bufnr, 'filetype', 'telescope-image-preview')
                
                vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {
                  "╔════════════════════════════════════════╗",
                  "║           IMAGE FILE PREVIEW           ║",
                  "╚════════════════════════════════════════╝",
                  "",
                  "📄 File: " .. vim.fn.fnamemodify(filepath, ":t"),
                  "📁 Path: " .. filepath,
                  "📊 Size: " .. size_kb .. " KB",
                  "🖼️  Type: " .. ext:upper(),
                  "",
                  "Press <Enter> to open with sixel preview",
                  "",
                  "(Image data not shown in preview window)",
                })
              end
            end)
          else
            -- For non-images, use the default previewer
            default_maker(filepath, bufnr, opts)
          end
        end,
      },
    })

    -- Keybindings
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
    vim.keymap.set('n', '<leader>fF', function()
      builtin.find_files({ hidden = true, no_ignore = true })
    end, { desc = 'Find ALL files (hidden + ignored)' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live grep' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find buffers' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Help tags' })
    vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = 'Recent files' })
    vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = 'Find word under cursor' })
  end,
}
