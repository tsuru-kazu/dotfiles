alias g "git"
alias lzd 'lazydocker'
alias gl "cd (ghq root)/(ghq list | peco)"
alias lg "lazygit"

set -x BREW_HOME /home/linuxbrew/.linuxbrew/bin
set -x PATH $PATH $BREW_HOME

set -x PATH $HOME/.anyenv/bin $PATH
eval (anyenv init - | source)

alias t='tmux new-session \; split-window -v \; split-window -h \; select-pane -t 0 \; split-window -h \; select-pane -t 0'
