# 設定・カスタマイズガイド

## ディレクトリ構造

```
~/.config/nvim/
├── init.lua                 # メイン設定ファイル
├── lua/
│   ├── config/
│   │   ├── autocmds.lua     # オートコマンド
│   │   ├── keymaps.lua      # キーマップ
│   │   ├── lazy.lua         # プラグインマネージャー設定
│   │   └── options.lua      # Neovim基本設定
│   └── plugins/
│       ├── ui.lua           # UI関連プラグイン
│       ├── editor.lua       # エディタ機能プラグイン
│       ├── coding.lua       # コーディング支援プラグイン
│       ├── lsp.lua          # LSP設定
│       ├── git.lua          # Git統合プラグイン
│       └── markdown.lua     # Markdown関連プラグイン
├── docs/                    # ドキュメント
└── lazy-lock.json          # プラグインバージョン管理
```

## 基本設定のカスタマイズ

### options.lua の主要設定

```lua
-- 行番号表示
vim.opt.number = true
vim.opt.relativenumber = true

-- インデント設定
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- 検索設定
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- 表示設定
vim.opt.wrap = false
vim.opt.cursorline = true
```

### keymaps.lua のカスタマイズ

```lua
-- カスタムキーマップの追加例
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save file" })
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })
```

## プラグイン設定のカスタマイズ

### 新しいプラグインの追加

1. `lua/plugins/` ディレクトリに適切なファイルを選択
2. プラグイン設定を追加：

```lua
return {
  {
    "author/plugin-name",
    lazy = false,          -- 遅延読み込みの設定
    dependencies = {},     # 依存関係
    opts = {},            # プラグインのオプション
    config = function()   # カスタム設定
      -- 設定内容
    end,
  },
}
```

### 既存プラグインの設定変更

例：Telescopeの設定をカスタマイズ

```lua
-- lua/plugins/editor.lua 内
{
  "nvim-telescope/telescope.nvim",
  opts = {
    defaults = {
      layout_strategy = "horizontal",
      layout_config = {
        horizontal = {
          prompt_position = "top",
          preview_width = 0.55,
        },
      },
    },
  },
}
```

## テーマ・色設定

### カラーテーマの変更

`lua/plugins/ui.lua` でテーマを変更：

```lua
{
  "projekt0n/github-nvim-theme",
  config = function()
    vim.cmd.colorscheme("github_dark_high_contrast")
  end,
}
```

### ステータスライン設定

Lualineの色設定をカスタマイズ：

```lua
-- 現在の設定でGit状態に応じて色が変更される
-- 緑：変更なし、赤：変更あり
```

## LSP設定

### 新しい言語サーバーの追加

1. `:Mason` でサーバーをインストール
2. `lua/plugins/lsp.lua` で設定：

```lua
-- Mason設定に言語サーバーを追加
ensure_installed = {
  "lua_ls",
  "tsserver",
  "pyright",
  -- 新しいサーバーを追加
}
```

### LSP設定のカスタマイズ

```lua
-- 特定の言語サーバーの設定
lspconfig.tsserver.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    -- TypeScript固有の設定
  }
})
```

## キーマップのカスタマイズ

### Which-key設定

グループとキーマップを追加：

```lua
-- lua/plugins/ui.lua の which-key設定
spec = {
  { "<leader>c", group = "+code" },
  { "<leader>f", group = "+file/find" },
  { "<leader>g", group = "+git" },
  -- 新しいグループを追加
  { "<leader>t", group = "+terminal" },
}
```

### カスタムキーマップの追加

```lua
-- lua/config/keymaps.lua
local map = vim.keymap.set

-- ターミナル関連のキーマップ例
map("n", "<leader>tt", ":terminal<CR>", { desc = "Open terminal" })
map("n", "<leader>th", ":split | terminal<CR>", { desc = "Open terminal in horizontal split" })
```

## オートコマンドの設定

### カスタムオートコマンド

`lua/config/autocmds.lua` に追加：

```lua
-- ファイルタイプごとの設定
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
})

-- 保存時の自動フォーマット
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.lua",
  callback = function()
    vim.lsp.buf.format()
  end,
})
```

## パフォーマンス最適化

### プラグインの遅延読み込み

```lua
{
  "plugin-name",
  lazy = true,              -- 必要時まで読み込まない
  event = "VeryLazy",       # イベントトリガー
  cmd = { "CommandName" },  # コマンドトリガー
  ft = { "filetype" },      # ファイルタイプトリガー
  keys = { "keymap" },      # キーマップトリガー
}
```

### 設定の最適化

```lua
-- 起動時間の改善
vim.opt.lazyredraw = true
vim.opt.ttyfast = true

-- ファイル検索の高速化
vim.opt.wildignore = "*.o,*.obj,*.pyc,*.so,*.swp,*.zip"
```

## バックアップとリストア

### 設定のバックアップ

```bash
# 設定ディレクトリ全体をバックアップ
cp -r ~/.config/nvim ~/nvim-backup

# 特定のファイルのみバックアップ
cp ~/.config/nvim/lazy-lock.json ~/lazy-lock.json.backup
```

### 設定のリストア

```bash
# プラグインの復元
:Lazy restore

# または手動で
rm ~/.config/nvim/lazy-lock.json
cp ~/lazy-lock.json.backup ~/.config/nvim/lazy-lock.json
:Lazy sync
```

## トラブルシューティング

### 設定の問題診断

```vim
:checkhealth          " 全体的な健康状態チェック
:checkhealth lazy     " Lazyプラグインマネージャーのチェック
:checkhealth lsp      " LSPの状態チェック
```

### ログの確認

```vim
:messages             " Neovimのメッセージ
:Lazy log            " プラグインのログ
:LspLog              " LSPのログ
```

### よくある問題と解決法

1. **プラグインが読み込まれない**
   - `:Lazy sync` を実行
   - `lazy-lock.json` を確認

2. **LSPが動作しない**
   - `:Mason` でサーバーがインストールされているか確認
   - `:LspInfo` で状態確認

3. **キーマップが効かない**
   - `:map <keymap>` で現在のマップを確認
   - 競合がないかチェック

## 推奨カスタマイズ

### 初心者向け

1. テーマの変更
2. 基本的なキーマップの追加
3. ファイルタイプ固有の設定

### 上級者向け

1. カスタムプラグインの作成
2. LSP設定の詳細カスタマイズ
3. パフォーマンス最適化
4. 複雑なオートコマンドの設定