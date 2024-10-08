export HOMEBREW_HOME=/opt/homebrew/
eval "$($HOMEBREW_HOME/bin/brew shellenv)"

# source $HOMEBREW_HOME/opt/powerlevel10k/powerlevel10k.zsh-theme

# OSX Locale fix
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

## Homebrew specifics
# Homebrew github token
[ -f ~/.brew_api_token ] && source ~/.brew_api_token

#
# User configuration sourced by interactive shells
#
export PATH=~/.local/bin:~/Library/Python/3.9/bin:~/.dotfiles/bin:~/git/gopath/bin:~/.npm-global/bin:/usr/local/sbin:$PATH

# Github 1P Plugin
[ -f ~/.config/op/plugins.sh ] && source ~/.config/op/plugins.sh

# Golang
export GOPATH=~/git/gopath

# Groovy
export GROOVY_HOME=/usr/local/opt/groovy/libexec

# Rust
export PATH=$PATH:~/.cargo/bin

# Java
export PATH="$HOME/.jenv/bin:$PATH"
# eval "$(jenv init -)"

# PYENV
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

export ZPLUG_HOME=$HOMEBREW_HOME/opt/zplug
source $ZPLUG_HOME/init.zsh

# 1Password plugins
[ -f ~/Users/denis/.config/op/plugins.sh ] && source /Users/denis/.config/op/plugins.sh

zplug bobsoppe/zsh-ssh-agent
zplug mafredri/zsh-async
# zplug "romkatv/powerlevel10k", use:powerlevel10k.zsh-theme
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "b4b4r07/zsh-vimode-visual", defer:3
zplug "rupa/z", use:z.sh
zplug load

# GitHub Token
[ -f ~/.gh_token ] && source ~/.gh_token

# Set to this to use case-sensitive completion
CASE_SENSITIVE="true"

# Gcloud K8S
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

DISABLE_UPDATE_PROMPT="true"

KEYTIMEOUT=1

setopt inc_append_history
setopt share_history
export HISTFILE=~/.zsh_history
export HISTSIZE=1000000
export SAVEHIST=1000000


# ssh agent config

bindkey -e
bindkey -M vicmd "/" history-incremental-search-backward
bindkey '^R' history-incremental-search-backward
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward
bindkey '^k' kill-line
bindkey -a u undo
bindkey -a '^R' redo
bindkey '^G' what-cursor-position

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey  "^[[A" up-line-or-beginning-search # Up
bindkey  "^[[B" down-line-or-beginning-search # Down

# Source all files in ~/.dotfiles/source/
#function src() {
#  local file
#  if (( $# == 0 )); then for file in ~/.dotfiles/source/*; do
#      source "$file"
#    done
#  else
#    source "$HOME/.dotfiles/source/$1.sh"
#  fi
#}

# Run dotfiles script, then source.
#function dotfiles() {
#  ~/.dotfiles/bin/dotfiles "$@" && src
#}

#src

if [ "$TERM_PROGRAM" = "iTerm" ]; then
  test -e ${HOME}/.iterm2_shell_integration.zsh && source ${HOME}/.iterm2_shell_integration.zsh
fi


# And kubectl command completion.
[[ -x /usr/local/bin/kubectl ]] && source <(kubectl completion zsh)

[[ -x /usr/bin/fortune && -x /usr/bin/cowsay ]] && fortune /usr/share/fortune/vimtips | cowsay -f moose

[[ -f /usr/share/autoenv/activate.sh ]] && source /usr/share/autoenv/activate.sh

# SmartThings Autocomplete
# eval $(smartthings autocomplete:script zsh)

export GITHUB_USERNAME=denisbr
# start in normal mode
#

autoload -U zmv
alias mmv="noglob zmv -W"
export TABLE_TERM_SIZE=150

#autoload -U +X bashcompinit && bashcompinit
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit
fi

# fzf
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
    --color=fg:#e5e9f0,bg:#3b4251,hl:#81a1c1
    --color=fg+:#e5e9f0,bg+:#3b4251,hl+:#81a1c1
    --color=info:#eacb8a,prompt:#bf6069,pointer:#b48dac
    --color=marker:#a3be8b,spinner:#b48dac,header:#a3be8b'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --hidden'


## Functions
# Remove offending ssh-keys
sshrmkey() { vim "+d$1|x" ~/.ssh/known_hosts; }

# Youtube dl wrapper for ios compat
ydl() { yt-dlp --merge-output-format mp4 -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best' $1; }

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

# mkcd
function mkcd () { mkdir -p "$@" && eval cd "\"\$$#\""; }

## Aliases
alias notstat='netstat -an | grep LISTEN'
alias dbash='docker exec -it $(docker ps -n 1 -q) bash || docker exec -it $(docker ps -n 1 -q) sh' 
alias vim=nvim
alias gitjk='history 10 | tail -r | gitjk_cmd'
alias sshtunnel='ssh -v -f ssh-tunnel-server -N'
alias sg='s -p google'
alias sd='s -p duckduckgo'
alias sy='s -p youtube'
alias playbook='ansible-playbook site.yml'
alias playchksyn='ansible-playbook --syntax-check'
alias playchk='ansible-playbook --check'
alias ls='lsd'
alias blakk='black --skip-string-normalization --line-length=120'
alias k=kubectl
alias kn='kubectl config set-context --current --namespace'
alias ghcrauth='security find-generic-password -a readonly_token -s github_pat -g -w | docker login ghcr.io -u USERNAME --password-stdin'
alias kubectl='kubecolor'
[[ ! -f ~/.aada-aliases.zsh ]] || source ~/.aada-aliases.zsh

export LESSOPEN="|/opt/homebrew/bin/lesspipe.sh %s"

# POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Homedir bin
export PATH="$PATH:/Users/denis/bin"

# Starship
eval "$(starship init zsh)"
