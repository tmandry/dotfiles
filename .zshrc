source ~/.zsh/zsh-snap/znap.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

znap source ohmyzsh/ohmyzsh lib/{git,theme-and-appearance}
znap prompt ohmyzsh/ohmyzsh robbyrussell

znap source zsh-users/zsh-autosuggestions

# Must go after anything that could modify shell behavior.
znap source zsh-users/zsh-syntax-highlighting

znap compdef _rustup  'rustup completions zsh'
znap compdef _cargo   'rustup completions zsh cargo'

alias gs='git status'
alias gd='git diff'
alias gl1='git log -1'
alias gl='git log'
alias gcam='git commit -am'
alias gcm='git commit -m'
alias gcaa='git commit -a --amend'
alias gca='git commit -a'
