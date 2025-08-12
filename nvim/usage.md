# Neovim モダン設定 使い方ガイド

このドキュメントでは、設定されたNeovimの使い方を分野別に整理して説明しています。

## 📋 ドキュメント一覧

### 🚀 はじめに
- **[基本操作・設定](docs/basic-operations.md)** - Neovimの基本的な操作方法とキーマップ
- **[設定・カスタマイズガイド](docs/configuration.md)** - 設定ファイルの編集方法と高度なカスタマイズ

### 📁 機能別ガイド
- **[ファイル管理・ナビゲーション](docs/file-management.md)** - nvim-tree、Telescopeによるファイル操作
- **[LSP・コード編集](docs/lsp-coding.md)** - LSP、補完、Mason設定とコーディング支援機能
- **[Git統合](docs/git-integration.md)** - Gitsigns、DiffViewによるGit操作とバージョン管理
- **[UI・ナビゲーション](docs/ui-navigation.md)** - バッファ、ウィンドウ、ステータスライン操作
- **[便利機能・ツール](docs/useful-features.md)** - コメント、囲み文字、診断ツールなどの補助機能

## 🎯 クイックリファレンス

### 最重要キーマップ

| キー | 動作 | 詳細 |
|------|------|------|
| `<Space>` | リーダーキー | 多くのコマンドの起点 |
| `<Space><Space>` | ファイル検索 | [ファイル管理](docs/file-management.md#telescope-ファジーファインダー) |
| `<Space>e` | ファイルツリー表示 | [ファイル管理](docs/file-management.md#nvim-tree-ファイルエクスプローラー) |
| `gd` | 定義へ移動 | [LSP・コード編集](docs/lsp-coding.md#lsp操作) |
| `<Space>ca` | コードアクション | [LSP・コード編集](docs/lsp-coding.md#lsp操作) |
| `gcc` | コメント切り替え | [便利機能](docs/useful-features.md#コメント-commentnvim) |
| `Ctrl+s` | ファイル保存 | [基本操作](docs/basic-operations.md#ファイル操作) |

### 基本情報

- **リーダーキー**: `<Space>` (スペースキー)
- **設定場所**: `~/.config/nvim/`
- **プラグインマネージャー**: lazy.nvim

## 🔍 カテゴリ別主要機能

### ファイル操作
- **検索**: Telescopeによる高速ファイル検索
- **管理**: nvim-treeによるファイルエクスプローラー
- **ナビゲーション**: バッファ間の素早い移動

### コーディング支援
- **LSP**: 言語サーバーによる補完・診断
- **Git統合**: Gitsignsによるバージョン管理
- **自動化**: 自動ペア、コメント、囲み文字操作

### UI・表示
- **ステータスライン**: Git状態の色分け表示
- **テーマ**: GitHub Dark High Contrast
- **通知**: 改善されたメッセージシステム

## 🆘 困った時は

### トラブルシューティング
1. **[基本操作ガイド](docs/basic-operations.md#トラブルシューティング)** - よくある問題の解決法
2. **[設定ガイド](docs/configuration.md#トラブルシューティング)** - 設定関連の問題診断

### ヘルプコマンド
```vim
:checkhealth    " 全体的な状態チェック
:help <topic>   " 特定トピックのヘルプ
:Lazy          " プラグイン管理UI
:Mason         " LSPサーバー管理UI
```

## 📚 学習の進め方

### 1. 基本をマスター
まずは **[基本操作・設定](docs/basic-operations.md)** を読んで、Neovimの基本的な操作を覚えましょう。

### 2. ファイル操作を効率化
**[ファイル管理・ナビゲーション](docs/file-management.md)** でファイルの検索・移動を素早く行えるようになりましょう。

### 3. コーディング機能を活用
**[LSP・コード編集](docs/lsp-coding.md)** でコード補完や定義ジャンプなどの開発支援機能を使いこなしましょう。

### 4. Git統合を活用
**[Git統合](docs/git-integration.md)** でバージョン管理を効率化しましょう。

### 5. カスタマイズに挑戦
慣れてきたら **[設定・カスタマイズガイド](docs/configuration.md)** で自分好みにカスタマイズしてみましょう。

## 🚀 効率的な使い方のコツ

- **Telescope**: `<Space><Space>` でファイル検索を多用
- **LSP**: `gd` で定義ジャンプ、`<Space>ca` でコードアクション
- **Git**: `]h`/`[h` でハンク移動、ステータスラインで状態確認
- **Which-key**: `<Space>` を押して利用可能なコマンドを確認

このガイドを参考に、効率的なNeovim環境を活用してください！

---

> 💡 **ヒント**: 各ドキュメントは独立しているので、必要な部分だけを読むことも可能です。まずは興味のある機能から始めてみてください。