# Dotfiles

このリポジトリには、私の個人的な dotfiles が含まれています。これらの設定ファイルを使用して、新しいマシンを素早くセットアップしたり、複数のマシン間で一貫した環境を維持したりすることができます。

## 含まれるもの

このdotfilesリポジトリには以下が含まれています：

- Neovim設定 (`nvim/`)
- Fish shell設定 (`fish/`)
- Homebrew パッケージリスト (`Brewfile`)
- その他のツール設定（必要に応じて追加）

## セットアップ

### 前提条件

- Git
- Homebrew（macOSの場合）

### インストール

1. このリポジトリをクローンします：

   ```bash
   git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
   ```

2. インストールスクリプトを実行します：

   ```bash
   cd ~/dotfiles
   ./install.sh
   ```

   このスクリプトは以下を行います：
   - 必要なシンボリックリンクの作成
   - Homebrewのインストール（必要な場合）
   - Brewfileからのパッケージのインストール

### 手動セットアップ

シンボリックリンクを手動で作成する場合：

```bash
ln -s ~/dotfiles/nvim ~/.config/nvim
ln -s ~/dotfiles/fish ~/.config/fish
```

Homebrewパッケージを手動でインストールする場合：

```bash
brew bundle --file=~/dotfiles/Brewfile
```

## 更新

新しい変更をコミットした後、他のマシンで以下を実行してdotfilesを更新します：

```bash
cd ~/dotfiles
git pull
./install.sh
```

## カスタマイズ

これらの dotfiles をフォークして、自分の好みに合わせてカスタマイズすることをお勧めします。

## 貢献

提案や改善がある場合は、イシューを開くかプルリクエストを送信してください。

## ライセンス

このプロジェクトはMITライセンスの下で公開されています。詳細は[LICENSE](LICENSE)ファイルを参照してください。