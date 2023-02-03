----------------------------------------------------------
-- Statusline configuration file
-----------------------------------------------------------

-- Plugin: lualine.nvim
-- url: https://github.com/nvim-lualine/lualine.nvim

local lualine_ok, lualine = pcall(require, 'lualine')
if not lualine_ok then
  return
end

lualine.setup{
  options = {
    theme = 'gruvbox-material',
  },
  extensions = { 'nvim-tree', 'toggleterm', 'fugitive'},
}

winbar_filetype_exclude = {
  "help",
  "startify",
  "dashboard",
  "packer",
  "neogitstatus",
  "NvimTree",
  "Trouble",
  "alpha",
  "lir",
  "Outline",
  "spectre_panel",
  "toggleterm",
}

