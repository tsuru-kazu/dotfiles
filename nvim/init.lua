require("base")
require("autocmds")
require("options")
require("keymaps")
require("colorschema")
require("plugins")

vim.g.coc_global_extensions = {
  'coc-solargraph',  -- Ruby
  'coc-tsserver',    -- TypeScript
  'coc-rust-analyzer',  -- Rust
}