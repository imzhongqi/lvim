M = {}

lvim.leader = "space"

local opts = { noremap = true, silent = true }

local keymap = vim.keymap.set

-- https://github.com/glepnir/nvim-lua-guide-zh#%E5%AE%9A%E4%B9%89%E6%98%A0%E5%B0%84
--
-- String value        Help page                Affected modes                                            Vimscript equivalent
-- ''                  (an empty string)        mapmode-nvoormal, Visual, Select, Operator-pending        :map
-- 'n'                 mapmode-n                Normal                                                    :nmap
-- 'v'                 mapmode-v                Visual and Select                                         :vmap
-- 's'                 mapmode-s                Select                                                    :smap
-- 'x'                 mapmode-x                Visual                                                    :xmap
-- 'o'                 mapmode-o                Operator-pending                                          :omap
-- '!'                 mapmode-ic               Insert and Command-line                                   :map!
-- 'i'                 mapmode-i                Insert                                                    :imap
-- 'l'                 mapmode-l                Insert, Command-line, Lang-Arg                            :lmap
-- 'c'                 mapmode-c                Command-line                                              :cmap
-- 't'                 mapmode-t                Terminal                                                  :tmap
local modes = {
	insert = "i",
	normal = "n",
	term = "t",
	visual = "v",
	visual_block = "x",
	command = "c",
}

local keymaps = {
	-- like map
	{
		["<C-s>"] = ":w<CR>",
		["<C-/>"] = "<cmd>normal gcc<CR>",
	},

	insert = {
		["<C-s>"] = "<cmd>:w<CR>",
	},

	normal = {
		Q = "<cmd>Bdelete!<CR>",
		["<C-M-q>"] = ":call QuickFixToggle()<cr>",
		["<C-z>"] = "<cmd>ZenMode<cr>",
		["<C-i>"] = "<C-i>",
		["<C-S-Space>"] = "<cmd>WhichKey \\<space><cr>",

		-- Better window navigation
		["<M-tab>"] = "<c-6>",
		["<C-M-h>"] = function()
			require("smart-splits").resize_left()
		end,
		["<C-M-l>"] = function()
			require("smart-splits").resize_right()
		end,
		["<C-M-j>"] = function()
			require("smart-splits").resize_down()
		end,
		["<C-M-k>"] = function()
			require("smart-splits").resize_up()
		end,
		["<C-h>"] = function()
			require("smart-splits").move_cursor_left()
		end,
		["<C-j>"] = function()
			require("smart-splits").move_cursor_down()
		end,
		["<C-k>"] = function()
			require("smart-splits").move_cursor_up()
		end,
		["<C-l>"] = function()
			require("smart-splits").move_cursor_right()
		end,

		["<s-tab>"] = "<plug>(CybuLastusedPrev)",
		["<tab>"] = "<plug>(CybuLastusedPrev)",
		["<c-p>"] = "<Plug>(CybuPrev)",
		["<c-n>"] = "<Plug>(CybuNext)",

		["K"] = ":lua require('user.keymaps').show_documentation()<CR>",

		["<C-S-r>"] = ":silent only | Jaq<CR>",
		["<C-v>"] = "<cmd>lua require('lsp_lines').toggle()<cr>",

		["-"] = ":lua require'lir.float'.toggle()<cr>",

		-- ["<tab>"] = "<cmd>lua require('telescope').extensions.harpoon.marks(require('telescope.themes').get_dropdown{previewer = false, initial_mode='normal', prompt_title='Harpoon'})<cr>",
		-- ["<s-tab>"] = "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false, initial_mode='normal'})<cr>",
	},

	visual = {
		["<C-s>"] = ":w<CR>",
		["<"] = "<gv",
		[">"] = ">gv",
		["p"] = "_dP",
	},

	visual_block = {
		["@"] = [[:<C-u>execute "'<,'>normal @".nr2char(getchar())<CR>]],
	},
}

for m, maps in pairs(keymaps) do
	for lhs, rhs in pairs(maps) do
		local mode = modes[m] or ""
		if type(rhs) == "table" then
			keymap(mode, lhs, rhs[1], rhs[2])
		else
			keymap(mode, lhs, rhs, opts)
		end
	end
end

keymap(
	"n",
	"<F6>",
	[[:echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">" . " FG:" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"fg#")<CR>]],
	opts
)

vim.cmd([[
  function! QuickFixToggle()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
      copen
    else
      cclose
    endif
  endfunction
]])

M.show_documentation = function()
	local filetype = vim.bo.filetype
	if vim.tbl_contains({ "vim", "help" }, filetype) then
		vim.cmd("h " .. vim.fn.expand("<cword>"))
	elseif vim.tbl_contains({ "man" }, filetype) then
		vim.cmd("Man " .. vim.fn.expand("<cword>"))
	elseif vim.fn.expand("%:t") == "Cargo.toml" then
		require("crates").show_popup()
	else
		vim.lsp.buf.hover()
	end
end

return M
