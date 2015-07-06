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

# iTerm2 Badges http://iterm2.com/badges.html
printf "\e]1337;SetBadgeFormat=%s\a" $(echo -n "\(user.myBadge)" | base64)
setbadge() { printf "\e]1337;SetUserVar=myBadge=%s\a" $(echo $1 | base64); }

## Settings
PATH="/usr/local/bin:$PATH:~/bin"
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
export GOPATH=~/git/gopath

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
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
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

