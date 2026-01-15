# dotfiles

[tsuru-kazu](https://github.com/tsuru-kazu) dotfiles

## Structure

```
dotfiles/
├── .config/        # XDG_CONFIG_HOME compliant configs
│   ├── nvim/      # Neovim configuration
│   ├── fish/      # Fish shell configuration
│   └── tmux/      # Tmux configuration
├── home/          # Home directory dotfiles
│   ├── .gitconfig
│   └── .ideavimrc
├── Brewfile       # Homebrew packages
└── Taskfile.yaml  # Build automation
```

## Requirements

- [Taskfile](https://taskfile.dev/)
- git

## Install

```bash
git clone https://github.com/tsuru-kazu/dotfiles.git ~/dotfiles
cd ~/dotfiles
task build
```
