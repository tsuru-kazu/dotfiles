# dotfiles

[tsuru-kazu](https://github.com/tsuru-kazu) dotfiles

## One-line Installation (New Mac Setup)

新しいMacが届いた時は、ターミナルで以下の1コマンドを実行するだけでセットアップが完了します。

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/tsuru-kazu/dotfiles/main/install.sh)"
```

このスクリプトは以下の処理を自動で行います：

1. macOS環境のチェック
2. Xcode Command Line Tools のインストール（未インストールの場合）
3. Homebrew のインストール・PATH設定（未インストールの場合）
4. リポジトリのクローン（`~/dotfiles`）
5. Task (go-task) のインストール
6. `task build` の実行（Brewfileのパッケージインストール、各設定ファイルのシンボリックリンク作成）

## Structure

```text
dotfiles/
├── .config/        # XDG_CONFIG_HOME compliant configs
│   ├── aerospace/  # AeroSpace tiling window manager config
│   ├── borders/    # JankyBorders config
│   ├── fish/       # Fish shell configuration
│   ├── herdr/      # Herdr config
│   ├── nvim/       # Neovim configuration
│   └── tmux/       # Tmux configuration
├── home/          # Home directory dotfiles
│   ├── .gitconfig
│   └── .ideavimrc
├── Brewfile       # Homebrew packages
├── Taskfile.yaml  # Build automation
└── install.sh     # One-command installer for macOS
```

## Manual Installation

手動でインストールまたは更新を行う場合の手順です。

### Requirements

- [Homebrew](https://brew.sh/)
- [Taskfile](https://taskfile.dev/)
- git

### Steps

```bash
git clone https://github.com/tsuru-kazu/dotfiles.git ~/dotfiles
cd ~/dotfiles
task build
```
