-----------------------------------------------------------
-- nvim-autopairs configuration file
-----------------------------------------------------------

-- Plugin: vim-gutentag
-- url: https://github.com/windwp/nvim-autopairs

local status_ok, npairs = pcall(require, "nvim-autopairs")
if not status_ok then
  return
end

npairs.setup {
  check_ts = true,
  disable_filetype = { "TelescopePrompt" },
  map_cr = true,
  break_line_filetype = nil, -- enable this rule for all filetypes
}
