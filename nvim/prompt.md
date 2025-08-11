# Neovimをモダンな設定にするためのプロンプト

## やりたいこと

- VSCodeっぽいエディタにしたい
- プラグインマネージャーはlazy.nvimを用いる
- LSP（Language Server Protocol）を使って高機能な補完・診断機能を実現
- ファイルエクスプローラー、ファジーファインダー、ターミナル統合
- 美しいテーマとUI要素の統合
- Git統合機能
- デバッグ機能
- 自動フォーマット・リンティング

## 必要な機能・プラグイン

### コア機能
- **lazy.nvim**: プラグインマネージャー
- **nvim-lspconfig**: LSP設定の簡素化
- **mason.nvim**: LSPサーバー、DAP、リンター、フォーマッターの管理
- **mason-lspconfig.nvim**: masonとlspconfigの統合

### 補完・スニペット
- **nvim-cmp**: 補完エンジン
- **cmp-nvim-lsp**: LSP補完ソース
- **cmp-buffer**: バッファ補完
- **cmp-path**: パス補完
- **cmp-cmdline**: コマンドライン補完
- **LuaSnip**: スニペットエンジン
- **cmp_luasnip**: スニペット補完統合

### ファイル管理・検索
- **nvim-tree.lua**: ファイルエクスプローラー
- **telescope.nvim**: ファジーファインダー
- **telescope-fzf-native.nvim**: telescopeの高速化
- **plenary.nvim**: telescope依存ライブラリ

### UI・テーマ
- **lualine.nvim**: ステータスライン
- **bufferline.nvim**: タブライン
- **indent-blankline.nvim**: インデントガイド
- **nvim-web-devicons**: アイコン
- **catppuccin/nvim** または **folke/tokyonight.nvim**: モダンテーマ

### Git統合
- **gitsigns.nvim**: Git差分表示、ハンク操作
- **vim-fugitive**: Git操作コマンド

### シンタックスハイライト・パーサー
- **nvim-treesitter**: シンタックスハイライト、テキストオブジェクト
- **nvim-treesitter-textobjects**: 高度なテキストオブジェクト

### ターミナル・デバッグ
- **toggleterm.nvim**: ターミナル統合
- **nvim-dap**: デバッグアダプタープロトコル
- **nvim-dap-ui**: デバッグUI

### フォーマット・リンティング
- **conform.nvim**: フォーマッター統合
- **nvim-lint**: リンター統合

### その他便利機能
- **which-key.nvim**: キーバインドヘルプ
- **comment.nvim**: コメントアウト機能
- **nvim-autopairs**: 括弧自動補完
- **vim-surround**: 囲み文字操作
- **trouble.nvim**: 診断・クイックフィックスリスト

## 設定構成

```
~/.config/nvim/
├── init.lua                 # エントリーポイント
├── lua/
│   ├── config/
│   │   ├── options.lua      # 基本設定
│   │   ├── keymaps.lua      # キーマッピング
│   │   └── autocmds.lua     # オートコマンド
│   └── plugins/
│       ├── init.lua         # プラグイン設定のロード
│       ├── lsp.lua          # LSP設定
│       ├── completion.lua   # 補完設定
│       ├── telescope.lua    # ファジーファインダー設定
│       ├── treesitter.lua   # シンタックスハイライト設定
│       ├── ui.lua           # UI関連設定
│       └── git.lua          # Git統合設定
```

## 実現したい機能

### VSCode風の機能
1. **ファイルエクスプローラー**: サイドバーにファイルツリー表示
2. **ファジーファインダー**: Ctrl+Pでファイル検索、Ctrl+Shift+Pでコマンドパレット
3. **統合ターミナル**: エディタ内でターミナル実行
4. **Git統合**: 変更差分の表示、ステージング、コミット操作
5. **インテリセンス**: 自動補完、エラー診断、定義ジャンプ
6. **デバッグ機能**: ブレークポイント、ステップ実行
7. **美しいUI**: モダンなテーマ、アイコン、ステータスライン

### パフォーマンス
- lazy.nvimによる遅延ロード
- Treesitterによる高速シンタックスハイライト
- LSPによる効率的な言語機能

### カスタマイズ性
- Lua設定による柔軟性
- モジュール化された設定構造
- 簡単なプラグイン追加・削除