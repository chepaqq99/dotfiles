-----------------------------------------------------------

-- Plugin manager configuration file
-----------------------------------------------------------

-- Plugin manager: lazy.nvim
-- URL: https://github.com/folke/lazy.nvim

-- Automatically install lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Use a protected call so we don't error out on first use
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
	return
end

local plugins = {
	-- Colorscheme
	{
		"ellisonleao/gruvbox.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.o.background = "dark"
			vim.cmd([[colorscheme gruvbox]])
		end,
	},

	"nvim-lua/plenary.nvim",

	-- Completion
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				dependencies = "rafamadriz/friendly-snippets",
				config = function()
					require("luasnip.loaders.from_vscode").lazy_load()
				end,
			},
			{
				"windwp/nvim-autopairs",
				opts = {
					fast_wrap = {},
					disable_filetype = { "TelescopePrompt", "vim" },
					map_cr = true,
					break_line_filetype = nil,
					check_ts = true,
				},
				config = function(_, opts)
					require("nvim-autopairs").setup(opts)
					local cmp_autopairs = require("nvim-autopairs.completion.cmp")
					require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
				end,
			},
			{
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-cmdline",
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-calc",
				"hrsh7th/cmp-nvim-lua",
				"onsails/lspkind.nvim",
				"saadparwaiz1/cmp_luasnip",
			},
		},
		config = function()
			require("plugins.nvim-cmp")
		end,
	},

	-- Syntax highlighting
	{
		"nvim-treesitter/nvim-treesitter",
		cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
		build = ":TSUpdate",
		config = function()
			require("plugins.nvim-treesitter")
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"https://gitlab.com/HiPhish/nvim-ts-rainbow2",
		},
	},

	-- File managing
	{
		"kyazdani42/nvim-tree.lua",
		config = function()
			require("plugins.nvim-tree")
		end,
		cmd = { "NvimTreeToggle", "NvimTreeFocus" },
	},

	{
		"nvim-telescope/telescope.nvim",
		version = "0.1.1",
		cmd = "Telescope",
		dependencies = {
			{
				"nvim-telescope/telescope-file-browser.nvim",
				"nvim-telescope/telescope-dap.nvim",
				"jvgrootveld/telescope-zoxide",
			},
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
		},
		config = function()
			require("telescope").setup({
				defaults = {
					mappings = {
						i = {
							["<C-j>"] = require("telescope.actions").move_selection_next,
							["<C-k>"] = require("telescope.actions").move_selection_previous,
							["<C-n>"] = require("telescope.actions").cycle_history_next,
							["<C-p>"] = require("telescope.actions").cycle_history_prev,
						},
					},
				},
			})
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("file_browser")
			require("telescope").load_extension("dap")
			require("telescope").load_extension("zoxide")
		end,
	},

	-- Indent guides
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("plugins.indent-blankline")
		end,
	},

	-- Icons
	{ "kyazdani42/nvim-web-devicons", lazy = true },

	-- Statusline
	{
		"nvim-lualine/lualine.nvim",
		required = {
			"ellisonleao/nvim-web-devicons",
		},
	},

	-- Colorizer
	{
		"NvChad/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
			require("colorizer").attach_to_buffer(0)
		end,
	},

	-- Commenting plugin
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup({
				ignore = "^$",
			})
		end,
	},

	-- Markdown
	{
		"iamcco/markdown-preview.nvim",
		ft = "markdown",
		build = "cd app && npm install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
	},

	-- CSV
	{ "chrisbra/csv.vim", ft = "csv" },

	-- Rust
	{ "simrat39/rust-tools.nvim", ft = "rust" },

	-- Go
	{
		"ray-x/go.nvim",
		ft = "go",
		dependencies = { "ray-x/guihua.lua" },
	},

	-- Git
	{
		"TimUntersberger/neogit",
		config = function()
			require("neogit").setup()
		end,
		lazy = true,
		cmd = "Neogit",
	},

	{
		"tpope/vim-fugitive",
		init = function()
			vim.api.nvim_create_autocmd({ "BufRead" }, {
				group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
				callback = function()
					vim.fn.system("git -C " .. vim.fn.expand("%:p:h") .. " rev-parse")
					if vim.v.shell_error == 0 then
						vim.api.nvim_del_augroup_by_name("GitSignsLazyLoad")
						vim.schedule(function()
							require("lazy").load({ plugins = { "gitsigns.nvim" } })
						end)
					end
				end,
			})
		end,
	},

	{
		"lewis6991/gitsigns.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("plugins.gitsigns")
		end,
		init = function()
			-- load gitsigns only when a git file is opened
			vim.api.nvim_create_autocmd({ "BufRead" }, {
				group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
				callback = function()
					vim.fn.system("git -C " .. vim.fn.expand("%:p:h") .. " rev-parse")
					if vim.v.shell_error == 0 then
						vim.api.nvim_del_augroup_by_name("GitSignsLazyLoad")
						vim.schedule(function()
							require("lazy").load({ plugins = { "gitsigns.nvim" } })
						end)
					end
				end,
			})
		end,
	},

	-- Buffer line
	{
		"akinsho/bufferline.nvim",
		config = function()
			require("bufferline").setup({
				options = {
					always_show_bufferline = false,
					diagnostics = "nvim_lsp",
					diagnostics_indicator = function(count, level, diagnostics_dict, context)
						local icon = level:match("error") and " " or " "
						return " " .. icon .. count
					end,
				},
			})
		end,
		event = "BufAdd",
	},

	-- Add/change/delete surrounding delimiter pairs
	{
		"kylechui/nvim-surround",
		config = function()
			require("nvim-surround").setup()
		end,
	},

	-- Dashboard (start screen)
	{
		"goolord/alpha-nvim",
		config = function()
			require("plugins.alpha-nvim")
		end,
	},

	-- Peeking the buffer while entering commands
	{
		"nacro90/numb.nvim",
		config = function()
			require("numb").setup()
		end,
	},

	-- Improve neovim performance
	{ "lewis6991/impatient.nvim" },

	-- Tag viewer
	{ "liuchengxu/vista.vim", lazy = true, cmd = "Vista" },

	-- Manage tags
	{
		"ludovicchabant/vim-gutentags",
		config = function()
			require("plugins.gutentags")
		end,
	},

	-- Highlighting other uses of the word under the cursor
	{ "RRethy/vim-illuminate", event = "CursorMoved" },

	-- which-key
	{
		"folke/which-key.nvim",
		config = function()
			require("plugins.which-key")
		end,
	},

	-- LSP
	{ "neovim/nvim-lspconfig" },

	{
		"lvimuser/lsp-inlayhints.nvim",
		config = function()
			require("lsp-inlayhints").setup()
			vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
			vim.api.nvim_create_autocmd("LspAttach", {
				group = "LspAttach_inlayhints",
				callback = function(args)
					if not (args.data and args.data.client_id) then
						return
					end

					local bufnr = args.buf
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					require("lsp-inlayhints").on_attach(client, bufnr)
				end,
			})
		end,
		dependencies = {
			"neovim/nvim-lspconfig",
		},
	},

	{
		"SmiteshP/nvim-navic",
		dependencies = {
			"neovim/nvim-lspconfig",
		},
	},

	{
		"j-hui/fidget.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("fidget").setup({})
		end,
	},

	{
		"williamboman/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
		opts = {
			ensure_installed = { "clangd", "bashls", "cssls", "html", "jsonls", "pyright" },
		},
		config = function(_, opts)
			require("mason").setup(opts)
			vim.api.nvim_create_user_command("MasonInstallAll", function()
				vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
			end, {})
		end,
		dependencies = {
			"neovim/nvim-lspconfig",
		},
	},

	-- CodeAction
	{
		"weilbith/nvim-code-action-menu",
		cmd = "CodeActionMenu",
		dependencies = {
			"neovim/nvim-lspconfig",
		},
		lazy = true,
	},

	-- Diagnostics
	{
		"folke/trouble.nvim",
		cmd = { "TroubleToggle", "TroubleClose", "Trouble", "TroubleRefresh" },
		config = function()
			require("trouble").setup()
		end,
		dependencies = {
			"neovim/nvim-lspconfig",
		},
	},

	-- Debugging
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			{
				"theHamsta/nvim-dap-virtual-text",
				config = function()
					require("nvim-dap-virtual-text").setup()
				end,
			},
		},
		config = function()
			require("plugins.nvim-dap")
		end,
		dependencies = {
			"neovim/nvim-lspconfig",
		},
	},

	-- Formatting
	{
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			require("plugins.null-ls")
		end,
		dependencies = {
			"neovim/nvim-lspconfig",
		},
	},
}

local opts = {
	performance = {
		rtp = {
			disabled_plugins = {
				"2html_plugin",
				"tohtml",
				"getscript",
				"getscriptPlugin",
				"gzip",
				"logipat",
				"netrw",
				"netrwPlugin",
				"netrwSettings",
				"netrwFileHandlers",
				"matchit",
				"tar",
				"tarPlugin",
				"rrhelper",
				"spellfile_plugin",
				"vimball",
				"vimballPlugin",
				"zip",
				"zipPlugin",
				"tutor",
				"rplugin",
				"syntax",
				"synmenu",
				"optwin",
				"compiler",
				"bugreport",
				"ftplugin",
			},
		},
	},
}

-- Setup lazy.nvim
lazy.setup(plugins, opts)
