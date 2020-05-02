## Functions
# Remove offending ssh-keys
sshrmkey() { vim "+d$1|x" ~/.ssh/known_hosts; }

# Youtube dl wrapper for ios compat
ydl() { youtube-dl --merge-output-format mp4 -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best' $1; }

# iTerm2 Badges http://iterm2.com/badges.html
#function iterm2_print_user_vars() {
#  iterm2_set_user_var myBadge "foo";
#}
# Status cats
httpcat() { curl -s --output - https://http.cat/$1 | imgcat; }

printf "\e]1337;SetBadgeFormat=%s\a" $(echo -n "\(user.myBadge)" | base64)
setbadge() { printf "\e]1337;SetUserVar=myBadge=%s\a" $(echo $1 | base64); }
settitle() { printf "\033];%s\007" $(echo $1); }
setname() { setbadge $1; settitle $1; }

# SSHDO
sshdo() { host=$1; shift 1; echo Doing: ssh $host -C sudo "$*"; read ; ssh $host -C sudo "$*"; }

## Aliases
alias notstat='lsof -i -P | grep -i "listen"'
alias ctags='/usr/local/bin/ctags'
alias dcommit='git svn dcommit'
alias dbash='docker exec -it $(docker ps -n 1 -q) bash' 
alias pparse='puppet parser validate'
alias vim='/usr/local/bin/vim'
alias vimp='vim +NERDTree'
alias gitjk='history 10 | tail -r | gitjk_cmd'
alias sshtunnel='ssh -v -f ssh-tunnel-server -N'
alias sg='s -p google'
alias sd='s -p duckduckgo'
alias sy='s -p youtube'
alias playbook='ansible-playbook site.yml'
alias playchksyn='ansible-playbook --syntax-check'
alias playchk='ansible-playbook --check'
#alias gproxy='ssh -f -nNT gitproxy'
alias gproxy='sudo -E ssh -o ConnectTimeout=60 -F $HOME/.ssh/config -f -nNT gitproxy'
alias gproxy-status='sudo ssh -O check gitproxy'
alias gproxy-off='sudo ssh -O exit gitproxy'
alias ls='lsd'

## Settings
export GOPATH=~/git/gopath
PATH="/usr/local/opt/curl/bin:/usr/local/sbin:$PATH:/usr/local/bin:~/bin:$GOPATH/bin:~/.npm-global/bin:~/bin:/usr/local/lib/ruby/gems/2.5.0/bin/:/Users/denis/.cargo/bin"
# Bash history tweaks
# http://blog.sanctum.geek.nz/better-bash-history/
shopt -s histappend
unset HISTFILESIZE
HISTSIZE=1000000
HISTCONTROL=ignoreboth
HISTIGNORE='bg:fg:history'
HISTTIMEFORMAT='%F %T '
shopt -s cmdhist
PROMPT_COMMAND='history -a; history -n'

# OSX Locale fix
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

## Homebrew specifics
# Homebrew github token
[ -f ~/.brew_api_token ] && source ~/.brew_api_token

# Homebrew based bash-completion
# OSX-bash (3.x)
[ -f $(brew --prefix)/etc/bash_completion ] && source $(brew --prefix)/etc/bash_completion || true

# New bash (4.x)
[ -f $(brew --prefix)/share/bash-completion/bash_completion ] && source $(brew --prefix)/share/bash-completion/bash_completion || true

# Linux based bash-completion
[ -f /usr/share/bash-completion/bash_completion ] && source /usr/share/bash-completion/bash_completion || true

# Local aliases
[ -f ~/.aliases ] && source ~/.aliases

# Powerline startup
powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
[ -f ~/git/rcfiles/powerline/powerline/bindings/bash/powerline.sh ] && source ~/git/rcfiles/powerline/powerline/bindings/bash/powerline.sh

# FuZzy Finder (FZF) setup
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Jenv setup
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

# Pyenv setup
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# iTerm2 Integration startup
[ -f ~/.iterm2_shell_integration.bash ] && source ~/.iterm2_shell_integration.bash

# GPG Setup
export GPG_TTY=$(tty)
export PINENTRY_USER_DATA="USE_CURSES=1"

# Timing integration
PROMPT_TITLE='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\007"'
export PROMPT_COMMAND="${PROMPT_TITLE}; ${PROMPT_COMMAND}"

# SAM Telemetry disable
export SAM_CLI_TELEMETRY=0

# Case insensitive auto-completion
bind "set completion-ignore-case on"
bind "set show-all-if-ambiguous on"

# I like bash
export BASH_SILENCE_DEPRECATION_WARNING=1
