## Functions
_dir_chomp () {
    local p=${1/#$HOME/\~} b s
    s=${#p}
    while [[ $p != ${p//\/} ]]&&(($s>$2))
    do
        p=${p#/}
        [[ $p =~ \.?. ]]
        b=$b/${BASH_REMATCH[0]}
        p=${p#*/}
        ((s=${#b}+${#p}))
    done
    echo ${b/\/~/\~}${b+/}$p
}

_parse_git_branch () {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ [git:\1]/'
}

## Aliases
alias dcommit='git svn dcommit'
alias pparse='puppet parser validate'
alias vimp="vim +NERDTree"
alias gitjk="history 10 | tail -r | gitjk_cmd"
alias sshtunnel='ssh -v -f ssh-tunnel-server -N'
alias sg='s -p google'
alias sd='s -p duckduckgo'
alias sy='s -p youtube'

# iTerm2 Badges http://iterm2.com/badges.html
printf "\e]1337;SetBadgeFormat=%s\a" $(echo -n "\(user.myBadge)" | base64)
setbadge() { printf "\e]1337;SetUserVar=myBadge=%s\a" $(echo $1 | base64); }

## Settings
export GOPATH=~/git/gopath
PATH="/usr/local/bin:$PATH:~/bin:$GOPATH/bin"
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
if [ -f ~/.brew_api_token ];then
  source ~/.brew_api_token
fi

# Liquid prompt
if [ -f $(brew --prefix)/bin/liquidprompt ]; then
  . $(brew --prefix)/bin/liquidprompt
fi

# Homebrew based bash-completion
# OSX-bash (3.x)
#if [ -f $(brew --prefix)/etc/bash_completion ]; then
#  . $(brew --prefix)/etc/bash_completion
#fi
# New bash (4.x)
if [ -f $(brew --prefix)/share/bash-completion/bash_completion ]; then
  . $(brew --prefix)/share/bash-completion/bash_completion
fi

# Linux based bash-completion
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion

## RVM Setup & Prompt
if [ -f ~/.rvm/bin/rvm-prompt ] ; then
   PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] $(_dir_chomp "$(pwd)" 20)\[\033[01;37m\]$(_parse_git_branch)\[\033[01;34m\] \[\033[01;37m\]$(~/.rvm/bin/rvm-prompt)\[\033[01;34m\] \$\[\033[00m\] '
   PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
   [[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # This loads RVM into a shell session.
else
   PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] $(_dir_chomp "$(pwd)" 20)\[\033[01;37m\]$(_parse_git_branch)\[\033[01;34m\] \$\[\033[00m\] '
fi 

### Host-specifics 
## ltrace
#if [ "$(hostname)" == "ltrace.linpro.no" ] ; then
#   source ~/.keychain/$(hostname)-sh
#   source /etc/bash_completion
#fi


if [ -f ~/.aliases ] ; then
    . ~/.aliases
fi

if [ -f ~/.iterm2_shell_integration.bash ] ; then
    . ~/.iterm2_shell_integration.bash
fi

[ -s "/Users/denis/.scm_breeze/scm_breeze.sh" ] && source "/Users/denis/.scm_breeze/scm_breeze.sh"
