alias g "git"
alias lzd 'lazydocker'
alias gl "cd (ghq root)/(ghq list | peco)"

set -x BREW_HOME /home/linuxbrew/.linuxbrew/bin
set -x PATH $PATH $BREW_HOME

set -x PATH $HOME/.anyenv/bin $PATH
eval (anyenv init - | source)

# set -x GOPROXY direct
set -x GOPATH $HOME/go
set -x GOROOT $HOME/.anyenv/envs/goenv/versions/1.21.1
set -x PATH $PATH $GOROOT/bin
set -x PATH $PATH $GOPATH/bin

# グローバルnpm
set -x PATH $HOME/.anyenv/envs/nodenv/versions/18.18.0/bin $PATH

set -x OPENAI_API_KEY sk-xxxxxx

source ~/.asdf/asdf.fish
