-- load in vimrc
vim.cmd("set runtimepath^=~/.vim runtimepath+=~/.vim/after")
vim.cmd("let &packpath = &runtimepath")
vim.cmd("source ~/.vimrc")

-- basic settings
vim.opt.mouse = ""

-- lazy bootstrapping code
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
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

-- define plugins
plugins = {
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.6',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},
	{
		"nvim-treesitter/nvim-treesitter",
	},
	{
		"ggandor/lightspeed.nvim",
	},
	{
		"FabijanZulj/blame.nvim",
	},
    {
      "ray-x/go.nvim",
      dependencies = {  -- optional packages
        "ray-x/guihua.lua",
        "neovim/nvim-lspconfig",
        "nvim-treesitter/nvim-treesitter",
      },
      config = function()
        require("go").setup()
      end,
      event = {"CmdlineEnter"},
      ft = {"go", 'gomod'},
      build = ':lua require("go.install").update_all_sync()'
    },
	{
		"rcarriga/nvim-notify",
	}
}
opts = {}


-- set up plugins
require("lazy").setup(plugins, opts)
require("blame").setup({
    date_format="%Y-%m-%d",
})

-- set up key mappings
local builtin = require('telescope.builtin')
vim.keymap.set('n', 'tg', builtin.git_files, {})
vim.keymap.set('n', 'tl', builtin.live_grep, {})
vim.keymap.set('n', 'gb', ":BlameToggle<CR>");

-- set up telescope mappings:
--   open files in a new tab on enter in my favorite pickers
local actions = require('telescope.actions')
require('telescope').setup {
	pickers = {
		git_files = {
			mappings = {
				i = {
				      ["<CR>"] = actions.select_tab,
				},
				n = {
				      ["<CR>"] = actions.select_tab,
				},
			},
		},
		live_grep = {
			mappings = {
				i = {
				      ["<CR>"] = actions.select_tab,
				},
				n = {
				      ["<CR>"] = actions.select_tab,
				},
			},
		},
	},
}

vim.notify = require("notify")
vim.notify.setup({
    stages = "slide"
})

-- my own stuff
