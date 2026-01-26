return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    local status_ok, configs = pcall(require, "nvim-treesitter.configs")
    if not status_ok then
      return
    end
    
    configs.setup({
      -- Install parsers for these languages
      ensure_installed = {
        "python",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "markdown",
        "markdown_inline",
      },
      
      -- Install parsers synchronously (only applied to ensure_installed)
      sync_install = false,
      
      -- Automatically install missing parsers when entering buffer
      auto_install = true,
      
      -- Highlighting
      highlight = {
        enable = true,
        
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
      },
      
      -- Indentation based on treesitter
      indent = {
        enable = true,
      },
      
      -- Incremental selection based on the named nodes from the grammar
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn",    -- Start incremental selection
          node_incremental = "grn",  -- Increment to the upper named parent
          scope_incremental = "grc", -- Increment to the upper scope
          node_decremental = "grm",  -- Decrement to the previous node
        },
      },
    })
  end,
}
