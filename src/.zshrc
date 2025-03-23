autoload -Uz compinit && compinit

alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
export PATH=/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin:/Users/jon/bin
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk@11/bin:$PATH"

. "$HOME/.cargo/env"

alias vim=nvim
alias vi=nvim
alias v=nvim
export EDITOR=nvim

eval "$(starship init zsh)"

source <(fzf --zsh)

. /opt/homebrew/etc/profile.d/z.sh
unalias z 2> /dev/null
z() {
  local dir=$(
    _z 2>&1 |
    fzf --height 40% --layout reverse --info inline \
        --nth 2.. --tac --no-sort --query "$*" \
        --bind 'enter:become:echo {2..}'
  ) && cd "$dir"
}

alias grep="grep --color=auto"

alias ls="ls --color=auto"
alias ll="ls -alh --color=auto"
alias lt="tree --gitignore"

if command -v most > /dev/null 2>&1; then
  export PAGER="most"
fi

alias duh='du -h -d=1'

