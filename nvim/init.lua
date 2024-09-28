require("base")
require("autocmds")
require("options")
require("keymaps")
require("colorschema")
require("plugins")
require("config.noice").setup()

vim.g.coc_global_extensions = {
  'coc-solargraph',  -- Ruby
  'coc-tsserver',    -- TypeScript
  'coc-rust-analyzer',  -- Rust
}

-- Coc
local function check_back_space()
  local col = vim.fn.col('.') - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- autocomplete
vim.api.nvim_set_keymap('i', '<C-j>', 'coc#pum#visible() ? coc#pum#next(1) : "<C-j>"', {expr = true, silent = true})
vim.api.nvim_set_keymap('i', '<C-k>', 'coc#pum#visible() ? coc#pum#prev(1) : "<C-k>"', {expr = true, silent = true})
vim.api.nvim_set_keymap('i', '<Enter>', 'coc#pum#visible() ? coc#pum#confirm() : "<Enter>"', {expr = true, silent = true})
vim.api.nvim_set_keymap('i', '<Esc>', 'coc#pum#visible() ? coc#pum#cancel() : "<Esc>"', {expr = true, silent = true})
vim.api.nvim_set_keymap('i', '<C-h>', 'coc#pum#visible() ? coc#pum#cancel() : "<C-h>"', {expr = true, silent = true})

-- <Tab>で次、<S+Tab>で前
vim.api.nvim_set_keymap('i', '<Tab>', [[coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<Tab>" : coc#refresh()]], {expr = true, silent = true})
vim.api.nvim_set_keymap('i', '<S-Tab>', [[coc#pum#visible() ? coc#pum#prev(1) : "<S-Tab>"]], {expr = true, silent = true})
vim.api.nvim_set_keymap('i', '<c-space>', 'coc#refresh()', {expr = true, silent = true})