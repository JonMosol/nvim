return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
  ft = { 'markdown' },  -- Only load for markdown files
  config = function()
    require('render-markdown').setup({
      -- Headings with different styles per level
      headings = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
      
      -- Checkbox rendering
      checkbox = {
        unchecked = '󰄱 ',
        checked = '󰱒 ',
      },
      
      -- Code blocks
      code = {
        enabled = true,
        sign = true,
        style = 'full',
        position = 'left',
        width = 'full',
        left_pad = 0,
        right_pad = 0,
        min_width = 0,
        border = 'thin',
        above = '▄',
        below = '▀',
        highlight = 'RenderMarkdownCode',
        highlight_inline = 'RenderMarkdownCodeInline',
      },
      
      -- Bullet points
      bullets = { '●', '○', '◆', '◇' },
      
      -- Quote styling
      quote = '┃',
      
      -- Horizontal rule
      dash = '─',
      
      -- Pipe tables
      pipe_table = {
        enabled = true,
        style = 'full',
        cell = 'padded',
        border = {
          '┌', '┬', '┐',
          '├', '┼', '┤',
          '└', '┴', '┘',
          '│', '─',
        },
      },
      
      -- Link rendering
      link = {
        enabled = true,
        image = '󰥶 ',
        hyperlink = '󰌹 ',
        highlight = 'RenderMarkdownLink',
      },
      
      -- Signs in the sign column
      sign = {
        enabled = true,
        highlight = 'RenderMarkdownSign',
      },
      
      -- Conceal markdown syntax when not editing
      anti_conceal = {
        enabled = true,
      },
      
      -- Enable rendering
      enabled = true,
      
      -- Maximum file size to render (in MB)
      max_file_size = 1.5,
      
      -- Debounce rendering (ms)
      debounce = 100,
    })
    
    -- Keybindings
    vim.keymap.set('n', '<leader>mt', ':RenderMarkdown toggle<CR>', { desc = 'Toggle markdown rendering', silent = true })
    vim.keymap.set('n', '<leader>me', ':RenderMarkdown enable<CR>', { desc = 'Enable markdown rendering', silent = true })
    vim.keymap.set('n', '<leader>md', ':RenderMarkdown disable<CR>', { desc = 'Disable markdown rendering', silent = true })
  end,
}
