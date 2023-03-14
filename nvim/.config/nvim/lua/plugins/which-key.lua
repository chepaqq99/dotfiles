-----------------------------------------------------------
-- which-key configuration file
-----------------------------------------------------------

-- Plugin: alpha-nvim
-- url: https://github.com/folke/which-key.nvim

local status_ok, whichkey = pcall(require, "which-key")
if not status_ok then
	return
end

vim.o.timeout = true
vim.o.timeoutlen = 300

local conf = {
	window = {
		border = "single", -- none, single, double, shadow
		position = "bottom", -- bottom, top
	},
}

local opts = {
	mode = "n", -- Normal mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = false, -- use `nowait` when creating keymaps
}

local mappings = {
	["w"] = { "<cmd>w<CR>", "Save" },
	["q"] = { "<cmd>qa!<CR>", "Quit" },
	["c"] = { "<cmd>nohl<CR>", "Clear highlighting" },
	["r"] = { "<cmd>so %<CR>", "Reload config" },
	["r"] = { "<cmd>so %<CR>", "Reload config" },
	["tk"] = { "<C-w>t<C-w>K", "Vertical to horizontal" },
	["th"] = { "<C-w>t<C-w>h", "Horizontal to vertical" },

	b = {
		name = "Buffer",
		d = { "<Cmd>bd!<Cr>", "Close current buffer" },
		D = { "<Cmd>%bd|e#|bd#<Cr>", "Delete all buffers" },
		n = { "<Cmd>bnext<CR>", "Next buffer" },
		N = { "<Cmd>bprevious<CR>", "Previous buffer" },
	},

	g = {
		name = "Git",
		s = { "<cmd>Neogit<CR>", "Status" },
	},

	f = {
		name = "Find",
		f = { "<cmd>lua require('telescope.builtin').find_files()<cr>", "Files" },
		b = { "<cmd>lua require('telescope.builtin').buffers()<cr>", "Buffers" },
		h = { "<cmd>lua require('telescope.builtin').help_tags()<cr>", "Help" },
		m = { "<cmd>lua require('telescope.builtin').marks()<cr>", "Marks" },
		o = { "<cmd>lua require('telescope.builtin').oldfiles()<cr>", "Old Files" },
		g = { "<cmd>lua require('telescope.builtin').live_grep()<cr>", "Live Grep" },
		c = { "<cmd>lua require('telescope.builtin').commands()<cr>", "Commands" },
		r = { "<cmd>lua require'telescope'.extensions.file_browser.file_browser()<cr>", "File Browser" },
		z = { "<cmd>lua require'telescope'.extensions.zoxide.list()<cr>", "Zoxide" },
		w = { "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>", "Current Buffer" },
		e = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
	},

	z = {
		name = "Packer",
		c = { "<cmd>PackerCompile<cr>", "Compile" },
		i = { "<cmd>PackerInstall<cr>", "Install" },
		s = { "<cmd>PackerSync<cr>", "Sync" },
		S = { "<cmd>PackerStatus<cr>", "Status" },
		u = { "<cmd>PackerUpdate<cr>", "Update" },
	},
}

whichkey.setup(conf)
whichkey.register(mappings, opts)
