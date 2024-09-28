local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

--local keymap = vim.keymap
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = 'n',
--   insert_mode = 'i',
--   visual_mode = 'v',
--   visual_block_mode = 'x',
--   term_mode = 't',
--   command_mode = 'c',

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- New tab
keymap("n", "te", ":tabedit", opts)
-- 新しいタブを一番右に作る
keymap("n", "gn", ":tabnew<Return>", opts)
-- move tab
keymap("n", "gh", "gT", opts)
keymap("n", "gl", "gt", opts)

keymap('n', '<C-s>', ':w<CR>', opts)  -- Ctrl+sで保存
keymap('n', '<C-q>', ':q<CR>', opts)  -- Ctrl+qで終了
keymap('n', '<leader>w', ':w<CR>', opts)  -- \wで保存
keymap('n', '<leader>q', ':q<CR>', opts)  -- \qで終了

-- Split window
keymap("n", "ss", ":split<Return><C-w>w", opts)
keymap("n", "sv", ":vsplit<Return><C-w>w", opts)

-- Select all
keymap("n", "<C-a>", "gg<S-v>G", opts)

-- Do not yank with x
keymap("n", "x", '"_x', opts)

-- Delete a word backwards
keymap("n", "dw", 'vb"_d', opts)

-- 行の端に行く
keymap("n", "<Space>h", "^", opts)
keymap("n", "<Space>l", "$", opts)

-- ;でコマンド入力( ;と:を入れ替)
keymap("n", ";", ":", opts)

-- 行末までのヤンクにする
keymap("n", "Y", "y$", opts)

-- <Space>q で強制終了
keymap("n", "<Space>q", ":<C-u>q!<Return>", opts)

-- ESC*2 でハイライトやめる
keymap("n", "<Esc><Esc>", ":<C-u>set nohlsearch<Return>", opts)

-- Insert --
-- Press jk fast to exit insert mode
keymap("i", "jk", "<ESC>", opts)

-- コンマの後に自動的にスペースを挿入
keymap("i", ",", ",<Space>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- ビジュアルモード時vで行末まで選択
keymap("v", "v", "$h", opts)

-- 0番レジスタを使いやすくした
keymap("v", "<C-p>", '"0p', opts)

-- 新規タブでターミナルモードを起動
keymap('n', 'tt', '<cmd>terminal<CR>', opts)

-- 下分割でターミナルモードを起動
keymap('n', 'tx', '<cmd>belowright new<CR><cmd>terminal<CR>', opts)

-- Neotreeの起動
keymap('n',  '<C-n>',  ':Neotree',  opts)

-- Telescope
local builtin = require('telescope.builtin')
-- ファイル検索
keymap('n', '<leader>ff', "<cmd>lua require('telescope.builtin').find_files()<CR>", opts)
-- Grepによる全文検索
keymap('n', '<leader>fg', "<cmd>lua require('telescope.builtin').live_grep()<CR>", { noremap = true, silent = true })
-- カーソル位置の単語でプロジェクト内検索
keymap('n', '<leader>fw', "<cmd>lua require('telescope.builtin').grep_string()<CR>", { noremap = true, silent = true })

-- noice nvimの設定
keymap('n', '<leader>nd', "<cmd>lua require('noice').cmd('dismiss')<CR>", { noremap = true, silent = true, desc = "Dismiss Noice Message" })

-- 以下だと動かない
-- Coc
-- local function check_back_space()
--     local col = vim.fn.col('.') - 1
--     return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
-- end
  
-- -- autocomplete
-- keymap('i', '<C-j>', 'coc#pum#visible() ? coc#pum#next(1) : "<C-j>"', opts)
-- keymap('i', '<C-k>', 'coc#pum#visible() ? coc#pum#prev(1) : "<C-k>"', opts)
-- keymap('i', '<Enter>', 'coc#pum#visible() ? coc#pum#confirm() : "<Enter>"', opts)
-- keymap('i', '<Esc>', 'coc#pum#visible() ? coc#pum#cancel() : "<Esc>"', opts)
-- keymap('i', '<C-h>', 'coc#pum#visible() ? coc#pum#cancel() : "<C-h>"', opts)

-- -- <Tab>で次、<S+Tab>で前
-- keymap('i', '<Tab>', [[coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<Tab>" : coc#refresh()]], opts)
-- keymap('i', '<S-Tab>', [[coc#pum#visible() ? coc#pum#prev(1) : "<S-Tab>"]], opts)
-- keymap('i', '<c-space>', 'coc#refresh()', opts)
