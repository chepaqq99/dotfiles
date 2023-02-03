-----------------------------------------------------------
-- Neovim init file
-----------------------------------------------------------

-- Impatient
local impatient_ok, impatient = pcall(require, "impatient")
if impatient_ok then impatient.enable_profile() end

-- Import Lua modules
require('plugins')
require('core/options')
require('core/autocmds')
require('core/keymaps')
require('core/colors')
require('core/statusline')
