alias g "git"
alias lzd 'lazydocker'
alias gl "cd (ghq root)/(ghq list | peco)"
alias gh "hub browse (ghq list | peco | cut -d "/" -f 2,3)"

set -x BREW_HOME /home/linuxbrew/.linuxbrew/bin
set -x PATH $PATH $BREW_HOME

set -x PATH $HOME/.anyenv/bin $PATH
eval (anyenv init - | source)

set -x GOPRIVATE "gitlab.chamo-chat.com/*"

# set -x GOPROXY direct
set -x GOPATH $HOME/go
set -x GOROOT $HOME/.anyenv/envs/goenv/versions/1.21.1
set -x PATH $PATH $GOROOT/bin
set -x PATH $PATH $GOPATH/bin

# グローバルnpm
set -x PATH $HOME/.anyenv/envs/nodenv/versions/18.18.0/bin $PATH

set -x DATABASE_URL postgresql://kazukitsuruse:hoge@localhost:5432/japan-ai-local

set -x OPENAI_API_KEY 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

source ~/.asdf/asdf.fish
set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /home/nuoun/.ghcup/bin $PATH # ghcup-env