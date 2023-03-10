-- import nvim-treesitter plugin safely
local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
  return
end

-- configure treesitter
treesitter.setup({
  -- enable syntax highlighting
  highlight = {
    enable = true,
  },
  -- enable indentation
  indent = { enable = true },
  -- enable autotagging (w/ nvim-ts-autotag plugin)
  autotag = { enable = true },
  -- ensure these language parsers are installed
  ensure_installed = {
    "json",
    "javascript",
    "typescript",
    "tsx",
    "yaml",
    "html",
    "css",
    "markdown",
    "svelte",
    "graphql",
    "bash",
    "lua",
    "vim",
    "dockerfile",
    "gitignore",
    "markdown_inline",
  },
  -- auto install above language parsers
  auto_install = true,
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<A-a>", -- set to `false` to disable one of the mappings
      node_incremental = "<A-a>",
      node_decremental = "<A-z>",
      -- scope_incremental = "grc", -- don't use that
    },
  },
})
