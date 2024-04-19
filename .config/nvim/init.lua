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
}
opts = {}


-- set up plugins
require("lazy").setup(plugins, opts)

-- set up key mappings
local builtin = require('telescope.builtin')
vim.keymap.set('n', 'tg', builtin.git_files, {})
vim.keymap.set('n', 'tl', builtin.live_grep, {})

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
