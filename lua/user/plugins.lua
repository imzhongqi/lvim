-- Additional Plugins
lvim.plugins = {
	"nvim-treesitter/nvim-treesitter-textobjects",
	"p00f/nvim-ts-rainbow",
	"moll/vim-bbye",
	"folke/todo-comments.nvim",
	"kylechui/nvim-surround",
	"windwp/nvim-spectre",

	"mrjones2014/smart-splits.nvim",
	"karb94/neoscroll.nvim",
	"hrsh7th/cmp-cmdline",
	"christianchiarulli/harpoon",
	"TimUntersberger/neogit",
	"ghillb/cybu.nvim", -- Neovim plugin that offers context when cycling buffers in the form of a customizable notification window.

	"nacro90/numb.nvim",
	"lvimuser/lsp-inlayhints.nvim", -- Partial implementation of LSP inlay hint.
	"folke/zen-mode.nvim",
	"is0n/jaq-nvim", -- Just Another Quickrun Plugin for Neovim in Lua
	"monaqa/dial.nvim", -- enhanced increment/decrement plugin for Neovim.

	-- "kevinhwang91/nvim-bqf",

	"sindrets/diffview.nvim",

	"MattesGroeger/vim-bookmarks",
	"NvChad/nvim-colorizer.lua",

	-- Rust
	"simrat39/rust-tools.nvim",
	{
		"saecki/crates.nvim",
		tag = "v0.3.0",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("crates").setup({
				null_ls = {
					enabled = true,
					name = "crates.nvim",
				},
			})
		end,
	},

	-- Go
	"olexsmir/gopher.nvim",
	"leoluz/nvim-dap-go",

	-- kitty.conf highlight support
	"fladson/vim-kitty",

	"folke/trouble.nvim",

  "tpope/vim-repeat",

	{
		"ggandor/flit.nvim",
		requires = { "ggandor/leap.nvim" },
		config = function()
			require("flit").setup({
				keys = { f = "f", F = "F", t = "t", T = "T" },
				-- A string like "nv", "nvo", "o", etc.
				labeled_modes = "v",
				multiline = true,
				-- Like `leap`s similar argument (call-specific overrides).
				-- E.g.: opts = { equivalence_classes = {} }
				opts = {},
			})
		end,
	},

	{
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		config = function()
			require("lsp_lines").setup()
			vim.diagnostic.config({ virtual_lines = false })
		end,
	},

	{ "christianchiarulli/telescope-tabs", branch = "chris" },

	-- {
	--   "jinh0/eyeliner.nvim",
	--   config = function()
	--     require("eyeliner").setup({
	--       highlight_on_key = true,
	--     })
	--   end,
	-- },

	{

		"folke/noice.nvim",
		event = "VimEnter",
		config = function()
			require("user.noice")
		end,
		requires = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
		},
	},

	-- {
	-- 	"folke/persistence.nvim",
	-- 	event = "BufReadPre", -- this will only start session saving when an actual file was opened
	-- 	module = "persistence",
	-- 	config = function()
	-- 		require("persistence").setup()
	-- 	end,
	-- },
}
