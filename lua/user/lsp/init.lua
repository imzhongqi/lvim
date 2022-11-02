require("user.lsp.languages.rust")
require("user.lsp.languages.go")

lvim.format_on_save = false
lvim.lsp.diagnostics.virtual_text = false

---@usage disable automatic installation of servers
lvim.lsp.installer.setup.automatic_installation = false

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "go",
  "rust",
  "lua",
  "python",
  "bash",
  "json",
  "yaml",
}

lvim.builtin.treesitter.highlight.enable = true
lvim.builtin.treesitter.rainbow = {
  enable = true,
  -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
  extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
  max_file_lines = nil, -- Do not enable for files with more than n lines, int
  -- colors = {}, -- table of hex strings
  -- termcolors = {} -- table of colour name strings
}

vim.diagnostic.config({ virtual_lines = false })

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "stylua", filetypes = { "lua" } },
}
