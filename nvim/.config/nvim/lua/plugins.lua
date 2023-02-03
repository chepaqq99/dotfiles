-----------------------------------------------------------
-- Plugin manager configuration file
-----------------------------------------------------------

-- Plugin manager: packer.nvim
-- url: https://github.com/wbthomason/packer.nvim

-- For information about installed plugins see the README:
-- neovim-lua/README.md
-- https://github.com/brainfucksec/neovim-lua#readme


-- Automatically install packer
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path
  })
  vim.o.runtimepath = vim.fn.stdpath('data') .. '/site/pack/*/start/*,' .. vim.o.runtimepath
end

-- Autocommand that reloads neovim whenever you save the packer_init.lua file
vim.cmd [[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerSync
augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

-- Install plugins
return packer.startup(function(use)
  -- Load lua path
  local lua_path = function(name)
    return string.format("require'plugins.%s'", name)
  end

  -- Add you plugins here:
  use 'wbthomason/packer.nvim' -- packer can manage itself

  -- File explorer
  use {
    'kyazdani42/nvim-tree.lua',
    config = lua_path'nvim-tree'
  }

  -- Indent line
  use {
    'lukas-reineke/indent-blankline.nvim',
    config = lua_path'indent-blankline'
  }

  -- Autopair
  use { 'windwp/nvim-autopairs', config = lua_path'nvim-autopairs' }

  -- Tag viewer
  use 'liuchengxu/vista.vim'

  -- Manage tags
  use { 'ludovicchabant/vim-gutentags', config = lua_path'gutentags' }

  -- Treesitter interface
  use {
    'nvim-treesitter/nvim-treesitter',
    config = lua_path'nvim-treesitter',
    run = function()
      require('nvim-treesitter.install').update({ with_sync = true })
    end,
  }

  -- Color schemes
  use 'ellisonleao/gruvbox.nvim'

  -- Color highlighter
  use {
    'NvChad/nvim-colorizer.lua',
    require = function() require'colorizer'.setup() end
  }

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = {
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    }
  }

  -- Statusline
  use {
    'nvim-lualine/lualine.nvim',
    requires = {
      'kyazdani42/nvim-web-devicons',
    }
  }

  -- Git integration for buffers
  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = lua_path'gitsigns'
  }

  -- Buffer line
  use {
    'akinsho/bufferline.nvim', tag = 'v3.*',
    config = function()
      require('bufferline').setup {
        options = {
          always_show_bufferline = false,
          diagnostics = "nvim_lsp",
          diagnostics_indicator = function(count, level, diagnostics_dict, context)
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
          end,
        },
      }
    end
  }

  -- Commenting plugin
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup{
        ignore = '^$',
      }
    end
  }

  -- Add/change/delete surrounding delimiter pairs
  use {
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
      require("nvim-surround").setup()
    end
  }
  -- FZF integration
  use 'junegunn/fzf.vim'

  -- Dashboard (start screen)
  use {
    'goolord/alpha-nvim',
    config = lua_path'alpha-nvim'
  }

  -- Russian keyboard layout
  use 'powerman/vim-plugin-ruscmd'

  -- Peeking the buffer while entering commands
  use { 'nacro90/numb.nvim', config = function() require('numb').setup()  end}

  -- Improve neovim performance
  use 'lewis6991/impatient.nvim'

  -- Highlighting other uses of the word under the cursor
  use 'RRethy/vim-illuminate'

  -- Markdown
  use {'iamcco/markdown-preview.nvim'}

  -- Lazygit
  use 'kdheepak/lazygit.nvim'

  -- Git support
  use 'tpope/vim-fugitive'

  -- CSV
  use 'chrisbra/csv.vim'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
