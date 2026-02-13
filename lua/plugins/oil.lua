return {
  "stevearc/oil.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- optional, for file icons
  },
  config = function()
    require("oil").setup({
      -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
      default_file_explorer = true,
      
      -- Columns to display in the oil buffer
      columns = {
        "icon",
        -- "permissions",
        -- "size",
        -- "mtime",
      },
      
      -- Buffer-local options to use for oil buffers
      buf_options = {
        buflisted = false,
        bufhidden = "hide",
      },
      
      -- Window-local options to use for oil buffers
      win_options = {
        wrap = false,
        signcolumn = "no",
        cursorcolumn = false,
        foldcolumn = "0",
        spell = false,
        list = false,
        conceallevel = 3,
        concealcursor = "nvic",
      },
      
      -- Send deleted files to the trash instead of permanently deleting them
      delete_to_trash = true,
      
      -- Skip the confirmation popup for simple operations (:help oil.skip_confirm_for_simple_edits)
      skip_confirm_for_simple_edits = false,
      
      -- Selecting a new/moved/renamed file or directory will prompt you to save changes first
      prompt_save_on_select_new_entry = true,
      
      -- Oil will automatically delete hidden buffers after this delay
      cleanup_delay_ms = 2000,
      
      -- Constrain the cursor to the editable parts of the oil buffer
      constrain_cursor = "editable",
      
      -- Set to true to watch the filesystem for changes and reload oil
      watch_for_changes = false,
      
      -- Keymaps in oil buffer
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-v>"] = { "actions.select", opts = { vertical = true }, desc = "Open in vertical split" },
        ["<C-x>"] = { "actions.select", opts = { horizontal = true }, desc = "Open in horizontal split" },
        ["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open in new tab" },
        ["<C-p>"] = {
          function()
            -- Save current splitright setting
            local old_splitright = vim.o.splitright
            -- Set splitright to true to make preview open on the right
            vim.o.splitright = true
            -- Call the preview action
            require("oil.actions").preview.callback()
            -- Restore original splitright setting
            vim.o.splitright = old_splitright
          end,
          desc = "Preview file on the right"
        },
        ["<C-c>"] = "actions.close",
        ["<C-l>"] = "actions.refresh",
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory" },
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["g."] = "actions.toggle_hidden",
        ["g\\"] = "actions.toggle_trash",
        ["gy"] = "actions.copy_entry_path",
        ["<leader>ff"] = {
          function()
            require("telescope.builtin").find_files({
              cwd = require("oil").get_current_dir()
            })
          end,
          desc = "Find files in current directory",
        },
        ["<leader>gg"] = {
          function()
            -- Ensure lazygit is loaded
            require("lazy").load({ plugins = { "lazygit.nvim" } })
            
            local oil = require("oil")
            local dir = oil.get_current_dir()
            if dir then
              -- Change to the directory and open lazygit
              vim.cmd("cd " .. vim.fn.fnameescape(dir))
              vim.cmd("LazyGit")
            else
              vim.notify("Could not get current directory from oil", vim.log.levels.ERROR)
            end
          end,
          desc = "Open LazyGit in current directory",
        },
        ["gow"] = {
          function()
            local oil = require("oil")
            local entry = oil.get_cursor_entry()
            local dir = oil.get_current_dir()
            
            if not entry or not dir then
              vim.notify("No file selected", vim.log.levels.WARN)
              return
            end
            
            local filepath = dir .. entry.name
            
            -- Define your "Open With" applications here
            -- You can customize this list with your preferred applications
            local apps = {
              { name = "Default Application", cmd = "start" },
              { name = "GIMP", cmd = "gimp" },
              { name = "Paint", cmd = "mspaint" },
              { name = "Notepad", cmd = "notepad" },
              { name = "VS Code", cmd = "code" },
              { name = "Windows Photo Viewer", cmd = "rundll32.exe C:\\Windows\\System32\\shimgvw.dll,ImageView_Fullscreen" },
              { name = "VLC Media Player", cmd = "vlc" },
            }
            
            vim.ui.select(apps, {
              prompt = "Open with:",
              format_item = function(item)
                return item.name
              end,
            }, function(choice)
              if not choice then
                return
              end
              
              -- Use vim.system for better Windows compatibility
              -- This avoids issues with WezTerm or other custom shells
              local args
              if choice.cmd == "start" then
                -- Use default application
                -- The empty string after "start" is the window title (Windows quirk)
                args = { "cmd.exe", "/c", "start", "", filepath }
              else
                -- Use specific application
                args = { "cmd.exe", "/c", "start", "", choice.cmd, filepath }
              end
              
              -- Use vim.system (Neovim 0.10+) or fallback to jobstart
              if vim.system then
                vim.system(args, { detach = true }, function(result)
                  -- Schedule notification to avoid fast event context error
                  vim.schedule(function()
                    if result.code ~= 0 then
                      vim.notify("Failed to open file with " .. choice.name, vim.log.levels.ERROR)
                    else
                      vim.notify("Opened with " .. choice.name, vim.log.levels.INFO)
                    end
                  end)
                end)
              else
                -- Fallback for older Neovim versions
                vim.fn.jobstart(args, {
                  detach = true,
                  on_exit = function(_, exit_code)
                    vim.schedule(function()
                      if exit_code ~= 0 then
                        vim.notify("Failed to open file with " .. choice.name, vim.log.levels.ERROR)
                      else
                        vim.notify("Opened with " .. choice.name, vim.log.levels.INFO)
                      end
                    end)
                  end,
                })
              end
            end)
          end,
          desc = "Open with... (context menu)",
        },
      },
      
      -- Set to false to disable all of the above keymaps
      use_default_keymaps = true,
      
      view_options = {
        -- Show files and directories that start with "."
        show_hidden = true,
        
        -- This function defines what is considered a "hidden" file
        is_hidden_file = function(name, bufnr)
          return vim.startswith(name, ".")
        end,
        
        -- This function defines what will never be shown, even when `show_hidden` is set
        is_always_hidden = function(name, bufnr)
          return false
        end,
        
        -- Sort file names in a more intuitive order for humans
        natural_order = true,
        
        sort = {
          -- sort order can be "asc" or "desc"
          { "type", "asc" },
          { "name", "asc" },
        },
      },
      
      -- Configuration for the floating window in oil.open_float
      float = {
        -- Padding around the floating window
        padding = 2,
        max_width = 0,
        max_height = 0,
        border = "rounded",
        win_options = {
          winblend = 0,
        },
        -- preview_split: Split direction: "auto", "left", "right", "above", "below".
        preview_split = "right",
        -- This is the config that will be passed to nvim_open_win.
        -- Change values here to customize the layout
        override = function(conf)
          return conf
        end,
      },
      
      -- Configuration for the actions floating preview window
      preview = {
        -- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        max_width = 0.9,
        -- min_width = {40, 0.4} means "the greater of 40 columns or 40% of total"
        min_width = { 40, 0.4 },
        -- optionally define an integer/float for the exact width of the preview window
        width = nil,
        -- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        max_height = 0.9,
        min_height = { 5, 0.1 },
        -- optionally define an integer/float for the exact height of the preview window
        height = nil,
        border = "rounded",
        win_options = {
          winblend = 0,
        },
        -- Whether the preview window is automatically updated when the cursor is moved
        update_on_cursor_moved = true,
      },
      
      -- Configuration for the floating progress window
      progress = {
        max_width = 0.9,
        min_width = { 40, 0.4 },
        width = nil,
        max_height = { 10, 0.9 },
        min_height = { 5, 0.1 },
        height = nil,
        border = "rounded",
        minimized_border = "none",
        win_options = {
          winblend = 0,
        },
      },
      
      -- Configuration for the floating SSH window
      ssh = {
        border = "rounded",
      },
    })

    -- Keybindings to open oil
    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    vim.keymap.set("n", "<leader>o", "<CMD>Oil<CR>", { desc = "Open oil file explorer" })
    vim.keymap.set("n", "<leader>O", "<CMD>Oil --float<CR>", { desc = "Open oil in floating window" })
  end,
}
