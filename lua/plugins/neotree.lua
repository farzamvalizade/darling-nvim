require('neo-tree').setup({
  close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
  popup_border_style = "NC",   -- Border style for input/confirmation dialogs
  enable_git_status = true,    -- Show git status indicators
  enable_diagnostics = true,   -- Show diagnostic symbols
  window = {
    position = "left",         -- "left", "right", "top", "bottom", "float", "current"
    width = 30,                -- Width of the window (for left/right positions)
    height = 15,               -- Height of the window (for top/bottom positions)
    mapping_options = {
      noremap = true,
      nowait = true,
    },
    mappings = {
      -- Custom keymaps go here
      ["<space>"] = { "toggle_node", nowait = false },
      ["<cr>"] = "open",
      ["o"]    = "open",
      ["s"]    = "open_vsplit",
      ["t"]    = "open_tabnew",
      ["q"]    = "close_window",
    },
  },
})
