return {
  "jake-stewart/multicursor.nvim",
  branch = "1.0",
  config = function()
    local mc = require("multicursor-nvim")

    mc.setup()

    local set = vim.keymap.set

    -- Add or skip cursor above/below the main cursor.
    set({ "n", "x" }, "<up>", function()
      mc.lineAddCursor(-1)
    end, { desc = "Add cursor above" })
    set({ "n", "x" }, "<down>", function()
      mc.lineAddCursor(1)
    end, { desc = "Add cursor below" })
    set({ "n", "x" }, "<leader><up>", function()
      mc.lineSkipCursor(-1)
    end, { desc = "Skip cursor above" })
    set({ "n", "x" }, "<leader><down>", function()
      mc.lineSkipCursor(1)
    end, { desc = "Skip cursor below" })

    -- Add or skip adding a new cursor by matching word/selection
    set({ "n", "x" }, "<leader>n", function()
      mc.matchAddCursor(1)
    end, { desc = "Add cursor to next match" })
    set({ "n", "x" }, "<leader>s", function()
      mc.matchSkipCursor(1)
    end, { desc = "Skip next match" })
    set({ "n", "x" }, "<leader>N", function()
      mc.matchAddCursor(-1)
    end, { desc = "Add cursor to previous match" })
    set({ "n", "x" }, "<leader>S", function()
      mc.matchSkipCursor(-1)
    end, { desc = "Skip previous match" })

    -- Add all matches in the document
    set({ "n", "x" }, "<leader>A", mc.matchAllAddCursors, { desc = "Add cursors to all matches" })

    -- Add a cursor and jump to the next word under cursor.
    set({ "n", "x" }, "<c-n>", function()
      mc.matchAddCursor(1)
    end, { desc = "Add cursor and jump to next match" })

    -- Jump to the next word under cursor but do not add a cursor.
    set({ "n", "x" }, "<c-s>", function()
      mc.matchSkipCursor(1)
    end, { desc = "Jump to next match" })

    -- Rotate the main cursor.
    set({ "n", "x" }, "<left>", mc.nextCursor, { desc = "Next cursor" })
    set({ "n", "x" }, "<right>", mc.prevCursor, { desc = "Previous cursor" })

    -- Delete the main cursor.
    set({ "n", "x" }, "<leader>x", mc.deleteCursor, { desc = "Delete cursor" })

    -- Add and remove cursors with control + left click.
    set("n", "<c-leftmouse>", mc.handleMouse, { desc = "Add/remove cursor with click" })

    -- Easy way to add and remove cursors using the main cursor.
    set({ "n", "x" }, "<c-q>", mc.toggleCursor, { desc = "Toggle cursor" })

    -- Clone every cursor and disable the originals.
    set({ "n", "x" }, "<leader><c-q>", mc.duplicateCursors, { desc = "Duplicate cursors" })

    set("n", "<esc>", function()
      if not mc.cursorsEnabled() then
        mc.enableCursors()
      elseif mc.hasCursors() then
        mc.clearCursors()
      else
        -- Default <esc> handler.
      end
    end, { desc = "Clear cursors" })

    -- bring cursors back
    set("n", "<leader>gv", mc.restoreCursors, { desc = "Restore cursors" })

    -- Align cursor columns.
    set("n", "<leader>a", mc.alignCursors, { desc = "Align cursors" })

    -- Split visual selections by regex.
    set("x", "S", mc.splitCursors, { desc = "Split cursors by regex" })

    -- Append/insert for each line of visual selections.
    set("x", "I", mc.insertVisual, { desc = "Insert at start of visual" })
    set("x", "A", mc.appendVisual, { desc = "Append at end of visual" })

    -- match new cursors within visual selections by regex.
    set("x", "M", mc.matchCursors, { desc = "Match cursors by regex" })

    -- Rotate visual selection contents.
    set("x", "<leader>t", function()
      mc.transposeCursors(1)
    end, { desc = "Transpose cursors forward" })
    set("x", "<leader>T", function()
      mc.transposeCursors(-1)
    end, { desc = "Transpose cursors backward" })

    -- Jumplist support
    set({ "v", "n" }, "<c-i>", mc.jumpForward, { desc = "Jump forward" })
    set({ "v", "n" }, "<c-o>", mc.jumpBackward, { desc = "Jump backward" })

    -- Customize how cursors look.
    local hl = vim.api.nvim_set_hl
    hl(0, "MultiCursorCursor", { link = "Cursor" })
    hl(0, "MultiCursorVisual", { link = "Visual" })
    hl(0, "MultiCursorSign", { link = "SignColumn" })
    hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
    hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
    hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
  end,
}
