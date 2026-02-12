return {
  "skardyy/neo-img",
  build = ":NeoImg Install", -- Installs ttyimg backend automatically
  config = function()
    -- Patch nvim_win_get_position to handle invalid windows gracefully
    local original_win_get_pos = vim.api.nvim_win_get_position
    vim.api.nvim_win_get_position = function(win)
      if not vim.api.nvim_win_is_valid(win) then
        return {0, 0}  -- Return default position instead of erroring
      end
      return original_win_get_pos(win)
    end
    
    require("neo-img").setup({
      supported_extensions = {
        png = true,
        jpg = true,
        jpeg = true,
        tiff = true,
        tif = true,
        svg = true,
        webp = true,
        bmp = true,
        gif = true, -- static only (no animation)
      },
      
      -- Important settings
      size = "100%", -- size of the image in percent
      center = true, -- center the image in the window
      auto_open = false, -- Disable auto-open to prevent Telescope conflicts
      
      -- Backend configuration
      backend = "auto", -- auto will detect sixel support in WezTerm
      resizeMode = "Fit", -- Fit / Stretch / Crop
      offset = "0x0", -- offset in cells (e.g., "2x3" = 2 cells x, 3 cells y)
      ttyimg = "local", -- local (installed by plugin) / global (system-wide)
      
      -- Integration settings
      oil_preview = true, -- if you use oil.nvim for file browsing
    })
    
    -- Auto-display images when opening image files (manually trigger to avoid Telescope conflicts)
    local image_display_group = vim.api.nvim_create_augroup("NeoImgAutoDisplay", { clear = true })
    
    vim.api.nvim_create_autocmd("BufReadPost", {
      group = image_display_group,
      pattern = "*.png,*.jpg,*.jpeg,*.gif,*.bmp,*.webp,*.tiff,*.tif,*.svg",
      callback = function()
        -- Add a small delay to ensure window is fully loaded
        vim.defer_fn(function()
          local win = vim.api.nvim_get_current_win()
          local buf = vim.api.nvim_get_current_buf()
          local bufname = vim.api.nvim_buf_get_name(buf)
          
          -- Check if Telescope is currently active
          local telescope_active = pcall(vim.api.nvim_buf_get_var, buf, "neo_img_telescope_active")
          
          -- Only auto-display if we're in a normal window (not Telescope preview or while Telescope is open)
          if win and vim.api.nvim_win_is_valid(win) 
             and not bufname:match("telescope://")
             and vim.bo[buf].buftype == ""
             and not telescope_active then
            pcall(vim.cmd, "NeoImg DisplayImage")
          end
        end, 100)
      end,
    })
    
    -- Prevent neo-img from trying to display in invalid windows when Telescope is active
    vim.api.nvim_create_autocmd("FileType", {
      group = image_display_group,
      pattern = "TelescopePrompt",
      callback = function()
        -- Mark all image buffers as "telescope-active" to prevent auto-display attempts
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if vim.api.nvim_buf_is_valid(buf) then
            local bufname = vim.api.nvim_buf_get_name(buf)
            local ext = vim.fn.fnamemodify(bufname, ":e"):lower()
            local image_exts = {"png", "jpg", "jpeg", "gif", "bmp", "webp", "tiff", "tif", "svg"}
            
            if vim.tbl_contains(image_exts, ext) then
              -- Set a buffer variable to prevent re-display while Telescope is open
              pcall(vim.api.nvim_buf_set_var, buf, "neo_img_telescope_active", true)
            end
          end
        end
      end,
    })
    
    -- Clear the telescope flag when Telescope closes
    vim.api.nvim_create_autocmd("User", {
      group = image_display_group,
      pattern = "TelescopeClose",
      callback = function()
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if vim.api.nvim_buf_is_valid(buf) then
            pcall(vim.api.nvim_buf_del_var, buf, "neo_img_telescope_active")
          end
        end
      end,
    })
  end,
}
