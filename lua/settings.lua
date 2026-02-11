-- Leader keys
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

-- Editor settings
vim.opt.scrolloff = 20         -- Keep 8 lines above/below cursor
vim.opt.sidescrolloff = 8     -- Keep 8 columns left/right of cursor
vim.opt.wrap = false          -- Disable word wrap

-- Line numbers
vim.opt.number = true         -- Show absolute line numbers
vim.opt.relativenumber = true -- Show relative line numbers

-- Terminal settings
vim.o.shell = 'wezterm.exe'
vim.o.shellcmdflag = 'cli'
vim.o.shellxquote = ''
vim.o.shellquote = ''
