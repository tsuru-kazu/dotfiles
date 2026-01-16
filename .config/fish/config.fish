alias g "git"
alias lzd 'lazydocker'
alias gl "cd (ghq root)/(ghq list | peco)"
alias lg "lazygit"
alias vv "nvim ."
alias cs "cursor ."
alias zl "zellij"

# Homebrew
eval (/opt/homebrew/bin/brew shellenv)

# windows
set -x BREW_HOME /home/linuxbrew/.linuxbrew/bin                                                                                               │
set -x PATH $PATH $BREW_HOM

# anyenv
# anyenv init - fish | source

status --is-interactive; and source (anyenv init -|psub)
