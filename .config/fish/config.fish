alias g "git"
alias lzd 'lazydocker'
alias ghr "gh api --paginate /user/repos --jq '.[].full_name' | fzf"
alias gl "cd \$(ghq root)/\$(ghq list | fzf)"
alias lg "lazygit"
alias vv "nvim ."
alias zz "zed ."
alias zl "zellij"

# Homebrew
eval (/opt/homebrew/bin/brew shellenv)

# anyenv
# anyenv init - fish | source

set -x CLAUDE_CODE_EFFORT_LEVEL max

status --is-interactive; and source (anyenv init -|psub)

function y
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	command yazi $argv --cwd-file="$tmp"
	if read -z cwd < "$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
		builtin cd -- "$cwd"
	end
	rm -f -- "$tmp"
end

# 各種ツールのバイナリを読み込む
export PATH="$HOME/.local/bin:$PATH"

# zoxide
zoxide init fish | source

# ezaの設定
alias ls='eza --icons --group-directories-first'
alias ll='eza -la --icons --group-directories-first --git'
alias lt='eza --tree --level=2 --icons'
