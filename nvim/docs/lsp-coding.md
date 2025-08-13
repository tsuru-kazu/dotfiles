# LSP・コード編集

## LSP操作（Lspsaga使用）

### 基本操作

| キー | 動作 | 種類 |
|------|------|------|
| `gd` | 定義へ移動（プレビュー付き） | Lspsaga |
| `gr` | 参照・定義統合ファインダー | Lspsaga |
| `gD` | 宣言へ移動 | 標準LSP |
| `gI` | 実装へ移動 | Telescope |
| `gy` | 型定義へ移動 | Telescope |
| `K` | ホバー情報表示（美化UI） | Lspsaga |
| `gK` | シグネチャヘルプ | Lspsaga |
| `<Space>ca` | コードアクション（美化UI） | Lspsaga |
| `<Space>cr` | リネーム（プレビュー付き） | Lspsaga |

### 診断操作

| キー | 動作 | 種類 |
|------|------|------|
| `<Space>cd` | 行診断表示 | Lspsaga |
| `<Space>cD` | カーソル診断表示 | Lspsaga |
| `]d` | 次の診断へ移動 | Lspsaga |
| `[d` | 前の診断へ移動 | Lspsaga |

### 追加機能

| キー | 動作 | 種類 |
|------|------|------|
| `<Space>o` | アウトライン表示 | Lspsaga |
| `<Space>ci` | 着信呼び出し表示 | Lspsaga |
| `<Space>co` | 発信呼び出し表示 | Lspsaga |

> **注意**: Lspsagaがインストールされているため、多くのLSP機能が美化されたUIで提供されます。詳細は `docs/lspsaga.md` を参照してください。

## 補完 (nvim-cmp)

### 補完操作

| キー | 動作 |
|------|------|
| `Ctrl+n` | 次の候補 |
| `Ctrl+p` | 前の候補 |
| `Enter` | 補完確定 |
| `Ctrl+e` | 補完キャンセル |
| `Ctrl+Space` | 補完手動トリガー |
| `Tab` | スニペット次のフィールド |
| `Shift+Tab` | スニペット前のフィールド |

## Mason (LSPサーバー管理)

### コマンド一覧

| コマンド | 動作 |
|----------|------|
| `:Mason` | Mason UI表示 |
| `:MasonInstall <server>` | LSPサーバーインストール |
| `:MasonUninstall <server>` | LSPサーバーアンインストール |
| `:MasonUpdate` | 全サーバー更新 |

## TypeScript/JavaScript

### TypeScript Tools操作

TypeScript専用の機能が利用可能です：

- 自動インポート
- 未使用変数の検出
- 型チェック
- リファクタリング機能

## トラブルシューティング

### よくある問題

1. **LSPが動かない**: `:Mason` でLSPサーバーがインストールされているか確認
2. **補完が出ない**: `:LspInfo` でLSPが起動しているか確認
3. **診断が表示されない**: `:checkhealth` で設定状態を確認

### ログ確認

```vim
:LspInfo        " LSP状態確認
:messages       " Neovimのメッセージ確認
:checkhealth    " 設定状態確認
```

## 使い方のコツ

### コード編集効率化（Lspsaga活用）
- `gd` で定義ジャンプ（プレビュー確認後に移動）
- `gr` で参照と定義を統合検索
- `<Space>ca` で美化されたコードアクション
- `K` で美しいホバードキュメント
- `<Space>o` でファイル構造を把握
- 診断ナビゲーション（`[d`, `]d`）で効率的なデバッグ

### Lspsaga vs 標準LSP
- **Lspsaga**: より美しく機能的なUI
- **標準LSP**: シンプルで軽量
- **Telescope**: 高機能な検索・絞り込み

詳細な使用方法は `docs/lspsaga.md` を参照してください。