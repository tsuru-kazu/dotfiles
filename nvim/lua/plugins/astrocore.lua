-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics = { virtual_text = true, virtual_lines = false }, -- diagnostic settings on startup
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- passed to `vim.filetype.add`
    filetypes = {
      -- see `:h vim.filetype.add` for usage
      extension = {
        foo = "fooscript",
      },
      filename = {
        [".foorc"] = "fooscript",
      },
      pattern = {
        [".*/etc/foo/.*"] = "fooscript",
      },
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "yes", -- sets vim.opt.signcolumn to yes
        wrap = false, -- sets vim.opt.wrap
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map

        -- navigate buffer tabs
        ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        -- mappings seen under group name "Buffer"
        ["<Leader>bd"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Close buffer from tabline",
        },

        -- === バッファ操作（追加の便利なキーマップ） ===
        -- Telescopeでバッファを検索・選択
        ["<Leader>bb"] = {
          function()
            local ok, builtin = pcall(require, "telescope.builtin")
            if ok then builtin.buffers() end
          end,
          desc = "Find buffers",
        },
        -- 次のバッファに移動（より直感的）
        ["<Leader>bn"] = {
          function() require("astrocore.buffer").nav(vim.v.count1) end,
          desc = "Next buffer",
        },
        -- 前のバッファに移動（より直感的）
        ["<Leader>bp"] = {
          function() require("astrocore.buffer").nav(-vim.v.count1) end,
          desc = "Previous buffer",
        },
        -- 現在のバッファを閉じる
        ["<Leader>bc"] = {
          function() require("astrocore.buffer").close() end,
          desc = "Close current buffer",
        },
        -- 他のバッファを閉じる（現在のバッファ以外）
        ["<Leader>bo"] = {
          function() require("astrocore.buffer").close_all(true) end,
          desc = "Close other buffers",
        },

        -- === よく使うキーマップ ===

        -- ファイル操作
        ["<Leader>q"] = {
          function() require("astrocore.buffer").close() end,
          desc = "Close current buffer",
        },
        ["<Leader>wq"] = { "<cmd>wq<cr>", desc = "Save and quit" },
        ["<Leader>qq"] = { "<cmd>q<cr>", desc = "Quit neovim" },

        -- ウィンドウ操作（Ctrl+h/j/k/lでウィンドウ間を移動）
        ["<C-h>"] = { "<C-w>h", desc = "Move to left window" },
        ["<C-j>"] = { "<C-w>j", desc = "Move to bottom window" },
        ["<C-k>"] = { "<C-w>k", desc = "Move to top window" },
        ["<C-l>"] = { "<C-w>l", desc = "Move to right window" },

        -- ウィンドウサイズ調整
        ["<Leader>="] = { "<C-w>=", desc = "Equalize window sizes" },
        ["<Leader>+"] = { "<C-w>+", desc = "Increase window height" },
        ["<Leader>-"] = { "<C-w>-", desc = "Decrease window height" },
        ["<Leader>>"] = { "<C-w>>", desc = "Increase window width" },
        ["<Leader><"] = { "<C-w><", desc = "Decrease window width" },

        -- 行の先頭/末尾に移動（H/L）
        ["H"] = { "^", desc = "Move to beginning of line" },
        ["L"] = { "$", desc = "Move to end of line" },

        -- 行を上下に移動（Alt+j/k）
        ["<A-j>"] = { "<cmd>m .+1<cr>==", desc = "Move line down" },
        ["<A-k>"] = { "<cmd>m .-2<cr>==", desc = "Move line up" },

        -- ヤンク（Yで行末までヤンク）
        ["Y"] = { "y$", desc = "Yank to end of line" },

        -- 検索ハイライトをクリア
        ["<Esc>"] = { "<cmd>noh<cr><Esc>", desc = "Clear search highlight" },

        -- 検索結果を中央に表示
        ["n"] = { "nzzzv", desc = "Next search result (centered)" },
        ["N"] = { "Nzzzv", desc = "Previous search result (centered)" },

        -- 置換（Leader+rで現在の単語を置換）
        ["<Leader>r"] = { ":%s/\\<<C-r><C-w>\\>//g<Left><Left>", desc = "Replace current word" },

        -- 行番号の切り替え（<Leader>n はAstroNvimのデフォルトで設定済みの可能性あり）
        ["<Leader>rn"] = { "<cmd>set relativenumber!<cr>", desc = "Toggle relative line numbers" },

        -- タブ操作
        ["<Leader>tn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
        ["<Leader>tq"] = { "<cmd>tabclose<cr>", desc = "Close tab" },
        ["<Leader>to"] = { "<cmd>tabonly<cr>", desc = "Close other tabs" },

        -- 行の複製
        ["<Leader>d"] = { "yyp", desc = "Duplicate line" },

        -- 行の削除（ddで削除した後、レジスタを保持しない）
        ["<Leader>dd"] = { '"_dd', desc = "Delete line without yanking" },

        -- ビジュアルモードで選択した範囲を検索
        ["<Leader>/"] = { "<Esc><cmd>let @/='\\<'.expand('<cword>').'\\>'<cr>n", desc = "Search current word" },

        -- === コマンドパレット（モーダル） ===
        -- Telescopeでコマンドを検索・実行
        ["<Leader>fc"] = {
          function()
            local ok, builtin = pcall(require, "telescope.builtin")
            if ok then builtin.commands() end
          end,
          desc = "Find commands (command palette)",
        },
        -- コマンド履歴を検索
        ["<Leader>f:"] = {
          function()
            local ok, builtin = pcall(require, "telescope.builtin")
            if ok then builtin.command_history() end
          end,
          desc = "Command history",
        },

        -- === Vimmer必須マッピング ===

        -- 行を結合するときカーソル位置を保持
        ["J"] = { "mzJ`z", desc = "Join lines (keep cursor position)" },

        -- スクロール時に中央を保持
        ["<C-d>"] = { "<C-d>zz", desc = "Scroll down (centered)" },
        ["<C-u>"] = { "<C-u>zz", desc = "Scroll up (centered)" },

        -- xで削除してもレジスタに入れない
        ["x"] = { '"_x', desc = "Delete char without yanking" },

        -- Ex modeを無効化（誤って入ると困る）
        ["Q"] = { "<nop>", desc = "Disable Ex mode" },

        -- ペーストしたテキストを選択
        ["gp"] = { "`[v`]", desc = "Select pasted text" },
      },
      -- インサートモード
      i = {
        -- jjでノーマルモードに戻る
        ["jj"] = { "<Esc>", desc = "Exit insert mode" },
        -- jkでもノーマルモードに戻れる（jjの代替）
        ["jk"] = { "<Esc>", desc = "Exit insert mode (alt)" },

        -- Ctrl+sで保存
        ["<C-s>"] = { "<cmd>w<cr><Esc>", desc = "Save file" },

        -- Ctrl+hでバックスペース（削除）
        ["<C-h>"] = { "<BS>", desc = "Backspace" },

        -- Ctrl+dで単語を削除
        ["<C-d>"] = { "<C-o>dw", desc = "Delete word" },

        -- 行を上下に移動（Alt+j/k）
        ["<A-j>"] = { "<Esc><cmd>m .+1<cr>==gi", desc = "Move line down" },
        ["<A-k>"] = { "<Esc><cmd>m .-2<cr>==gi", desc = "Move line up" },
      },
      -- ビジュアルモード
      v = {
        -- ペーストしてもレジスタを上書きしない
        ["p"] = { '"_dP', desc = "Paste without overwriting register" },

        -- インデント調整（<, >でインデントを減らす/増やす）
        ["<"] = { "<gv", desc = "Decrease indent" },
        [">"] = { ">gv", desc = "Increase indent" },

        -- 行を上下に移動（Alt+j/k）
        ["<A-j>"] = { "<cmd>m '>+1<cr>gv=gv", desc = "Move selection down" },
        ["<A-k>"] = { "<cmd>m '<-2<cr>gv=gv", desc = "Move selection up" },

        -- システムクリップボードとの連携
        ["<Leader>y"] = { '"+y', desc = "Yank to system clipboard" },
        ["<Leader>p"] = { '"+p', desc = "Paste from system clipboard" },
        ["<Leader>P"] = { '"+P', desc = "Paste before cursor from system clipboard" },

        -- 検索ハイライトをクリア
        ["<Esc>"] = { "<cmd>noh<cr><Esc>", desc = "Clear search highlight" },

        -- 選択範囲を検索
        ["<Leader>/"] = { "y<Esc><cmd>let @/='\\<'.escape(@\", '/').'\\>'<cr>n", desc = "Search selected text" },
      },
      -- ターミナルモード
      t = {
        -- Escでターミナルモードから抜ける
        ["<Esc>"] = { "<C-\\><C-n>", desc = "Exit terminal mode" },
      },
      -- コマンドラインモード
      c = {
        -- Ctrl+hでバックスペース
        ["<C-h>"] = { "<BS>", desc = "Backspace" },
      },
    },
  },
}
