# Neovim Configuration

A modular Neovim configuration with LSP support, autocompletion, git integration, file navigation, syntax highlighting, and debugging.

## 📁 Folder Structure

```
~/.config/nvim/ (or ~/AppData/Local/nvim on Windows)
├── init.lua                    # Main entry point - bootstraps Lazy.nvim and loads config
├── lua/
│   ├── settings.lua           # Editor settings, leader keys, and options
│   └── plugins/
│       ├── colorscheme.lua    # Rose Pine colorscheme with transparency
│       ├── completion.lua     # nvim-cmp autocompletion setup
│       ├── dap.lua            # Debug Adapter Protocol for debugging
│       ├── gitsigns.lua       # Git diff signs and hunk operations
│       ├── lazygit.lua        # LazyGit terminal UI integration
│       ├── lsp.lua            # LSP configuration, Mason, and Python support
│       ├── lualine.lua        # Statusline with icons and git integration
│       ├── neo-img.lua        # Image viewer with sixel support
│       ├── nvim-tree.lua      # File explorer
│       ├── render-markdown.lua # Beautiful markdown rendering in terminal
│       ├── telescope.lua      # Fuzzy finder for files and text
│       └── treesitter.lua     # Treesitter for better syntax highlighting
└── README.md                  # This file
```

## 🚀 Features

- **Plugin Manager**: [Lazy.nvim](https://github.com/folke/lazy.nvim) for fast plugin management
- **LSP Support**: Language Server Protocol with Mason for easy server installation
- **Autocompletion**: nvim-cmp with LSP, buffer, path, and snippet sources
- **Syntax Highlighting**: Treesitter for accurate, context-aware syntax highlighting
- **Debugging**: nvim-dap with UI for full debugging support (breakpoints, stepping, variable inspection)
- **Git Integration**: Gitsigns for diff indicators and LazyGit for interactive git operations
- **File Navigation**: nvim-tree for file browsing and Telescope for fuzzy finding
- **Python Support**: Pyright LSP with automatic virtual environment detection and debugpy integration
- **Colorscheme**: Rose Pine with transparency support
- **Statusline**: Lualine with icons, git status, and diagnostics
- **Markdown Rendering**: render-markdown.nvim for beautiful in-terminal markdown display
- **Image Viewer**: neo-img for viewing images inline with sixel protocol (works on Windows!)

## ⚙️ Settings

**Leader Key**: `\` (backslash)

**Editor Options**:
- `scrolloff = 8` - Keep 8 lines above/below cursor
- `sidescrolloff = 8` - Keep 8 columns left/right of cursor

## 🔌 Plugins

### Git Plugins

#### Gitsigns
Visual git diff indicators in the sign column.

**Keybindings**:
- `]c` / `[c` - Next/previous git hunk
- `\hs` - Stage hunk
- `\hr` - Reset hunk
- `\hS` - Stage buffer
- `\hu` - Undo stage hunk
- `\hR` - Reset buffer
- `\hp` - Preview hunk
- `\hb` - Blame line
- `\tb` - Toggle line blame
- `\hd` - Diff this

#### LazyGit
Terminal UI for git operations (requires `lazygit` CLI installed).

**Keybindings**:
- `\gg` - Open LazyGit

**Installation**:
- Windows: `winget install lazygit`
- Mac: `brew install lazygit`
- Linux: Check your package manager

### File Navigation

#### nvim-tree
File tree explorer with icons.

**Keybindings**:
- `\e` - Toggle file explorer
- `\ef` - Find current file in explorer

**Inside nvim-tree**:
- `a` - Create file/folder
- `d` - Delete
- `r` - Rename
- `x` - Cut
- `c` - Copy
- `p` - Paste
- `Enter` - Open file
- `?` - Show help

**Note**: Requires a [Nerd Font](https://www.nerdfonts.com/) for icons to display properly.

#### Telescope
Fuzzy finder for files, text, and more with image preview support.

**Keybindings**:
- `\ff` - Find files
- `\fg` - Live grep (search text in files) - requires `ripgrep`
- `\fb` - Find buffers (open files in current session)
- `\fh` - Help tags
- `\fr` - Recent files
- `\fw` - Find word under cursor

**Inside Telescope**:
- `Ctrl-j` / `Ctrl-k` - Navigate results
- `Enter` - Open file in current window
- `Ctrl-x` - Open in horizontal split (keeps Telescope open)
- `Ctrl-v` - Open in vertical split (keeps Telescope open)
- `Ctrl-t` - Open in new tab (keeps Telescope open)
- `Tab` - Mark file for multi-select
- `Esc` or `Ctrl-c` - Close without opening

**Image Preview**:
- When browsing image files, shows file info instead of binary data
- Press Enter to open and view with sixel rendering

**Workflow Tips**:
- Use `\fb` to switch between already-open files (buffers) - faster than `\ff`
- Use preview window to check file contents before opening
- Use `Ctrl-v` or `Ctrl-x` to compare multiple files side-by-side

**Requirements**:
- `ripgrep` for live grep: `winget install BurntSushi.ripgrep.MSVC`

### LSP & Completion

#### LSP Configuration
Language Server Protocol support with Mason for managing servers.

**Features**:
- Automatic LSP server installation via Mason
- Python support with Pyright
- Automatic virtual environment detection (`.venv`, `venv`)

**LSP Keybindings**:
- `gd` - Go to definition
- `gD` - Go to declaration
- `gr` - Find references
- `gi` - Go to implementation
- `K` - Hover documentation
- `gp` - Peek definition (floating window)
- `gs` - Go to definition (split below)
- `gv` - Go to definition (split right)
- `\rn` - Rename symbol
- `\ca` - Code actions
- `\d` - Show diagnostics
- `[d` / `]d` - Previous/next diagnostic

**Commands**:
- `:Mason` - Open Mason UI to manage LSP servers
- `:LspInfo` - Show LSP client info
- `:PythonSetPath <path>` - Manually set Python interpreter path

#### Completion (nvim-cmp)
Autocompletion with multiple sources.

**Keybindings**:
- `Tab` - Next completion item
- `Shift-Tab` - Previous completion item
- `Enter` - Confirm selection
- `Ctrl-Space` - Manually trigger completion
- `Ctrl-e` - Close completion menu
- `Ctrl-b` / `Ctrl-f` - Scroll documentation

**Sources**:
- LSP completions
- Buffer words
- File paths
- Command-line
- Snippets

### Syntax Highlighting

#### Treesitter
Advanced syntax highlighting using AST (Abstract Syntax Tree) parsing.

**Features**:
- Context-aware syntax highlighting (more accurate than regex)
- Smart code folding
- Incremental selection of code blocks
- Better indentation

**Keybindings**:
- `gnn` - Start incremental selection (selects current word/node)
- `grn` - Expand selection to parent node (function, class, etc.)
- `grc` - Expand selection to scope
- `grm` - Shrink selection

**Commands**:
- `:TSInstall <language>` - Install parser for a language
- `:TSUpdate` - Update all parsers
- `:TSInstallInfo` - Show installed parsers

**Supported Languages** (pre-configured):
- Python, Lua, Vim, Markdown

### Colorscheme

#### Rose Pine
A beautiful, low-contrast colorscheme with transparency support.

**Features**:
- Three variants: main (default), moon, and dawn
- Transparency support for terminal backgrounds
- Carefully crafted color groups for git, diagnostics, and UI elements

**Configuration**:
- Edit `lua/plugins/colorscheme.lua` to change variants or disable transparency
- Current setting: `transparency = true` (allows terminal background to show through)

**Variants**:
```lua
-- In colorscheme.lua, change the colorscheme command to:
vim.cmd("colorscheme rose-pine")       -- Auto (main for dark, dawn for light)
vim.cmd("colorscheme rose-pine-main")  -- Main variant (default dark)
vim.cmd("colorscheme rose-pine-moon")  -- Moon variant (darker)
vim.cmd("colorscheme rose-pine-dawn")  -- Dawn variant (light)
```

### Statusline

#### Lualine
A blazing fast and easy to configure statusline plugin.

**Features**:
- Auto-detects colorscheme and matches theme
- Git branch, diff, and status indicators
- LSP diagnostics (errors, warnings, info)
- File encoding, format, and type
- Current mode indicator
- Cursor position and progress
- Icon support with nvim-web-devicons

**Display Sections**:
- **Left**: Mode, git branch, diff, diagnostics
- **Center**: Filename
- **Right**: Encoding, file format, filetype, progress, location

**Customization**:
- Edit `lua/plugins/lualine.lua` to change theme or separators
- Available themes: 'auto', 'gruvbox', 'tokyonight', 'catppuccin', 'nord', and more
- Customize sections to show/hide information

**Note**: Requires a [Nerd Font](https://www.nerdfonts.com/) for icons to display properly.

### Markdown Rendering

#### render-markdown.nvim
Beautiful markdown rendering directly in the terminal using WezTerm's capabilities.

**Features**:
- **Styled headers** - Different icons for each heading level (# through ######)
- **Code blocks** - Bordered backgrounds with syntax highlighting
- **Checkboxes** - Visual checkboxes (☐ unchecked, ☑ checked)
- **Bullet points** - Different symbols for nested lists (●, ○, ◆, ◇)
- **Block quotes** - Clean vertical lines for quotes
- **Tables** - Beautiful box-drawn table borders
- **Links** - Icons for images and hyperlinks
- **Horizontal rules** - Clean separator lines
- **Anti-conceal** - Hides markdown syntax when not editing that line
- **Auto-updates** - Renders as you type with minimal delay

**Keybindings**:
- `\mt` - Toggle markdown rendering on/off
- `\me` - Enable markdown rendering
- `\md` - Disable markdown rendering

**Usage**:
- Open any markdown file (`.md`)
- Rendering happens automatically
- Move cursor to a line to see raw markdown syntax
- Move away to see rendered view
- Great for editing READMEs and documentation!

**Commands**:
- `:RenderMarkdown toggle` - Toggle rendering
- `:RenderMarkdown enable` - Enable rendering
- `:RenderMarkdown disable` - Disable rendering

**Performance**:
- Only loads for markdown files (lazy loading)
- Maximum file size: 1.5 MB
- 100ms debounce for smooth editing

**Note**: Requires a [Nerd Font](https://www.nerdfonts.com/) for icons and proper rendering. Works best in WezTerm with sixel support.

### Image Viewer

#### neo-img
View images directly in Neovim using the sixel graphics protocol.

**Features**:
- Automatically displays images when opening image files
- Works on Windows with WezTerm (and other sixel-compatible terminals)
- Supports PNG, JPG, JPEG, TIFF, SVG, WebP, BMP, GIF (static)
- Auto-installs ttyimg backend on first run
- Centered display at 80% window size
- Gracefully handles Telescope preview windows

**Commands**:
- `:NeoImg DisplayImage` - Manually display image in current buffer
- `:NeoImg Install` - Install/reinstall ttyimg backend

**Usage**:
- Simply open an image file: `:e path/to/image.png`
- Images automatically render in the buffer after a brief delay
- Use Telescope (`\ff`) to browse images - shows file info in preview
- Press Enter in Telescope to open and view the image with sixel
- Works with nvim-tree when browsing image files

**Technical Details**:
- Uses patched window validation to prevent errors during window transitions
- Auto-display disabled during Telescope operations to avoid conflicts
- 100ms delay ensures window is fully loaded before rendering

**Requirements**:
- Terminal with sixel support (WezTerm, iTerm2, foot, XTerm, Alacritty)
- WezTerm users: Already supported out of the box!

**Note**: Videos are not supported (terminal graphics protocols don't support video playback)

### Debugging

#### nvim-dap
Full debugging support with Debug Adapter Protocol.

**Features**:
- Set breakpoints and conditional breakpoints
- Step through code (step over, into, out)
- Inspect variables in real-time
- View call stack
- Debug REPL for evaluating expressions
- Virtual text showing variable values inline
- Automatic UI that opens when debugging starts

**Keybindings**:
- `\db` - Toggle breakpoint
- `\dc` - Start/Continue debugging
- `\di` - Step into function
- `\do` - Step over line
- `\dO` - Step out of function
- `\dx` - Stop/Terminate debugging
- `\dt` - Toggle debug UI
- `\dB` - Set conditional breakpoint
- `\dr` - Open debug REPL
- `\dl` - Run last debug configuration

**Python-specific**:
- `\dpm` - Debug Python test method
- `\dpc` - Debug Python test class

**Requirements**:
- Python: `pip install debugpy`

**Breakpoint Symbols**:
- `●` - Active breakpoint
- `◆` - Conditional breakpoint
- `→` - Current execution line

## 📝 Common Workflows

### Opening Files
1. Use `\ff` to fuzzy find files by name
2. Use `\e` to browse the file tree
3. Use `\fg` to search for text across files
4. Use `\fb` to switch between already-open files (buffers)

### Working with Buffers
**What are buffers?** Buffers are files loaded into memory. You can have multiple files open (buffers) but only see some of them in windows.

**Best Practices**:
- Let Neovim manage buffers automatically - don't worry about closing them
- Use `\fb` to see and switch between all open buffers
- Use `:ls` to list all buffers if needed
- Restart Neovim when switching projects to get a clean slate

**Buffer vs Window vs Tab**:
- **Buffer** = File in memory (hidden or visible)
- **Window** = Viewport showing a buffer (like panes/splits)
- **Tab** = Collection of window layouts (like workspaces)

**Window Management**:
- `:split` or `:sp` - Horizontal split
- `:vsplit` or `:vs` - Vertical split
- `Ctrl-w w` - Move between windows
- `Ctrl-w c` - Close current window
- In Telescope: `Ctrl-v` / `Ctrl-x` to open in splits

### Viewing Images
1. Use `\ff` to browse images - preview shows file info
2. Press Enter to open and view with sixel rendering
3. Image automatically displays after a brief moment
4. Use `\fb` to switch between multiple open images
5. Manually trigger display with `:NeoImg DisplayImage` if needed

### Working with Git
1. See diff indicators in the gutter automatically
2. Use `\gg` to open LazyGit for commits, pushes, etc.
3. Use `\hp` to preview changes in a hunk

### Code Navigation
1. Press `K` on a symbol to see documentation
2. Use `gd` to jump to definition
3. Use `gp` to peek at definition without leaving current location
4. Use `gr` to find all references
5. Use `\rn` to rename a symbol across the project

### Python Development
1. Open Neovim in a Python project with a `.venv` folder
2. LSP automatically detects and uses the virtual environment
3. Get autocompletion, go to definition, and error checking
4. Use `:Mason` to install additional language servers

### Debugging Python Code
1. Install debugpy: `pip install debugpy`
2. Open a Python file
3. Set a breakpoint with `\db` on the line you want to pause at
4. Press `\dc` to start debugging
5. Use `\do` to step over lines, `\di` to step into functions
6. Inspect variables in the left panel (Scopes)
7. See variable values shown inline as virtual text
8. Press `\dx` to stop debugging

### Smart Code Selection
1. Put cursor on a word or symbol
2. Press `gnn` to select it
3. Press `grn` repeatedly to expand selection (to expression → statement → function → class)
4. Press `grm` to shrink selection back down

### Writing and Editing Markdown
1. Open a markdown file: `:e README.md`
2. Markdown automatically renders with styled headers, code blocks, and formatting
3. When you edit a line, raw markdown syntax appears
4. When you move away, the line renders beautifully
5. Use `\mt` to toggle rendering on/off if you want to see raw markdown
6. Works great for documentation, notes, and README files!

## 🎨 Customization

### Adding a New Plugin
1. Create a new file in `lua/plugins/` (e.g., `lua/plugins/my-plugin.lua`)
2. Add the plugin specification:
```lua
return {
  "author/plugin-name",
  config = function()
    -- Plugin configuration here
  end,
}
```
3. Restart Neovim - Lazy.nvim will automatically install it

### Modifying Settings
Edit `lua/settings.lua` to change vim options or leader keys.

### Changing Keybindings
Edit the specific plugin file in `lua/plugins/` to modify keybindings.

### Disabling a Plugin
Rename the plugin file with a `.disabled` extension:
```
mv lua/plugins/telescope.lua lua/plugins/telescope.lua.disabled
```

## 🛠️ Requirements

**Required**:
- Neovim 0.11+ (for latest LSP features)
- Git (for Lazy.nvim and plugin installation)

**Optional but Recommended**:
- [Nerd Font](https://www.nerdfonts.com/) - For file icons in nvim-tree
- [ripgrep](https://github.com/BurntSushi/ripgrep) - For Telescope live grep
- [lazygit](https://github.com/jesseduffield/lazygit) - For LazyGit integration
- [fd](https://github.com/sharkdp/fd) - For faster Telescope file finding
- [debugpy](https://github.com/microsoft/debugpy) - For Python debugging (`pip install debugpy`)

## 📚 Useful Commands

### Lazy.nvim
- `:Lazy` - Open Lazy.nvim UI
- `:Lazy update` - Update all plugins
- `:Lazy clean` - Remove unused plugins
- `:Lazy sync` - Install missing plugins and clean unused ones

### LSP
- `:LspInfo` - Show attached LSP clients
- `:LspRestart` - Restart LSP clients
- `:Mason` - Manage LSP servers, formatters, linters

### Treesitter
- `:TSInstall <language>` - Install parser for a language
- `:TSUpdate` - Update all parsers
- `:TSInstallInfo` - Show installed parsers
- `:checkhealth nvim-treesitter` - Check Treesitter health

### Debugging (DAP)
- `:DapToggleBreakpoint` - Toggle breakpoint (or use `\db`)
- `:DapContinue` - Start/continue debugging (or use `\dc`)
- `:DapTerminate` - Stop debugging (or use `\dx`)

### Buffer Management
- `:ls` or `:buffers` - List all buffers
- `:bnext` or `:bn` - Next buffer
- `:bprevious` or `:bp` - Previous buffer
- `:bdelete` or `:bd` - Close current buffer
- `\fb` - Telescope buffer finder (recommended!)

### General Neovim
- `:checkhealth` - Check Neovim installation and plugin health
- `:e <file>` - Edit a file
- `:help <topic>` - Get help on any topic
- `:split` or `:sp` - Horizontal split
- `:vsplit` or `:vs` - Vertical split

## 🔧 Troubleshooting

### Icons not showing in nvim-tree or lualine
Install a Nerd Font and configure your terminal to use it.

### LSP not working for Python
1. Check LSP status with `:LspInfo`
2. Ensure pyright is installed: `:Mason`
3. Check Python path detection or set manually: `:PythonSetPath /path/to/python`

### Live grep not working in Telescope
Install ripgrep: `winget install BurntSushi.ripgrep.MSVC`

### Swap file warnings
These are normal and can be ignored. Neovim handles them automatically.

### Treesitter not highlighting properly
1. Check if parsers are installed: `:TSInstallInfo`
2. Install missing parser: `:TSInstall <language>`
3. Update parsers: `:TSUpdate`

### Debugger not working
1. Ensure debugpy is installed: `pip install debugpy`
2. Check if it's in your virtual environment
3. Verify Python path is correct: `:LspInfo`
4. Try setting manually: `:PythonSetPath /path/to/venv/python`

### Telescope preview showing binary data for images
This has been fixed. Telescope now shows image file info in preview instead of binary data. Press Enter to view the image with sixel rendering.

### Image not displaying after opening
1. Ensure your terminal supports sixel (WezTerm recommended on Windows)
2. Wait 100ms for auto-display to trigger
3. Manually trigger: `:NeoImg DisplayImage`
4. Check neo-img installation: `:NeoImg Install`

### Markdown rendering not working or showing boxes
1. Ensure you have a Nerd Font installed and configured in WezTerm
2. Toggle rendering: `\mt`
3. Check if file is too large (> 1.5 MB limit)
4. Verify Treesitter markdown parser is installed: `:TSInstall markdown`

### Markdown syntax symbols not showing when editing
This is intentional! render-markdown uses "anti-conceal" - the raw syntax appears when your cursor is on that line, and hides when you move away. Use `\mt` to toggle this behavior.

## 📖 Learning Resources

- [Neovim Documentation](https://neovim.io/doc/)
- [Lazy.nvim](https://github.com/folke/lazy.nvim)
- [Learn Vim](https://www.openvim.com/)
- Neovim built-in tutorial: Run `nvim` then type `:Tutor`

## 🎯 Next Steps

Consider adding:
- **Colorscheme**: Try `tokyonight.nvim`, `catppuccin`, or `gruvbox`
- **More LSP servers**: Use `:Mason` to install servers for other languages (JavaScript, TypeScript, Go, Rust, etc.)
- **Testing**: `neotest` for running tests inside Neovim
- **Git blame**: `git-blame.nvim` for inline git blame
- **Auto-pairs**: `nvim-autopairs` for automatic bracket/quote pairing
- **Comments**: `Comment.nvim` for easy code commenting
- **Markdown preview**: `markdown-preview.nvim` for browser-based preview (if you prefer web rendering over terminal)

---

*Configuration built with ❤️ for vanilla Neovim*
