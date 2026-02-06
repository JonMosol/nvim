return {
  "folke/tokyonight.nvim",
  priority = 1000, -- Load before other plugins
  config = function()
    require("tokyonight").setup({
      -- Style options: "storm" (default), "moon", "night", "day"
      style = "storm",
      
      -- Enable transparency
      transparent = false,
      terminal_colors = true,
      
      styles = {
        -- Style to be applied to different syntax groups
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        -- Background styles: "dark", "transparent", "normal"
        sidebars = "dark",
        floats = "dark",
      },
      
      -- Set to true to dim inactive windows
      dim_inactive = false,
      
      -- Adjusts the brightness of the colors of the **Day** style
      day_brightness = 0.3,
      
      -- Configure the colors used when opening a `:terminal`
      on_colors = function(colors) end,
      
      -- Override specific highlight groups
      on_highlights = function(highlights, colors) end,
    })

    -- Set colorscheme
    vim.cmd("colorscheme tokyonight")
    
    -- Alternative variants you can use:
    -- vim.cmd("colorscheme tokyonight-night")  -- Darker variant
    -- vim.cmd("colorscheme tokyonight-storm")  -- Default variant (explicit)
    -- vim.cmd("colorscheme tokyonight-moon")   -- More contrast variant
    -- vim.cmd("colorscheme tokyonight-day")    -- Light variant
  end,
}
