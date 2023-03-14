-----------------------------------------------------------
-- Define maps of Neovim
-----------------------------------------------------------

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Change leader to a comma
vim.g.mapleader = ','

-- Disable arrow keys
map('', '<up>', '<nop>')
map('', '<down>', '<nop>')
map('', '<left>', '<nop>')
map('', '<right>', '<nop>')

-- Map Esc to kk
map('i', 'kk', '<Esc>')

-- Toggle auto-indenting for code paste
map('n', '<F2>', ':set invpaste paste?<CR>')
vim.opt.pastetoggle = '<F2>'

-- Visual line wraps
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- Center search results
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "g,", "g,zvzz")
map("n", "g;", "g;zvzz")

-- Scrolling
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Move around plits using Ctrl + {h,j,k,l}
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

-- Insert blank line
map("n", "]<Space>", "o<Esc>")
map("n", "[<Space>", "O<Esc>")

-- Better indent
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Paste over currently selected text without yanking it
map("v", "p", '"_dP')

-- Move text up and down
map("x", "J", ":move '>+1<CR>gv-gv")
map("x", "K", ":move '<-2<CR>gv-gv")
map("x", "<A-j>", ":move '>+1<CR>gv-gv")
map("x", "<A-k>", ":move '<-2<CR>gv-gv")

-- Resizing panes
map("n", "<Left>", ":vertical resize +1<CR>")
map("n", "<Right>", ":vertical resize -1<CR>")
map("n", "<Up>", ":resize -1<CR>")
map("n", "<Down>", ":resize +1<CR>")

-- Terminal mappings
map('n', '<C-\\>', ':Term<CR>', { noremap = true })
map('t', '<Esc>', '<C-\\><C-n>')
map('t', 'kk', '<C-\\><C-n>')
map("t", "<C-h>", "<C-\\><C-n><C-w>h")
map("t", "<C-j>", "<C-\\><C-n><C-w>j")
map("t", "<C-k>", "<C-\\><C-n><C-w>k")
map("t", "<C-l>", "<C-\\><C-n><C-w>l")

-- File explorer
map('n', '<C-n>', ':NvimTreeToggle<CR>')
