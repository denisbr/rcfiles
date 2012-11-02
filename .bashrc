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
alias vimp="vim +Project"

## Settings
PATH="$PATH:~/bin"
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

## RVM Setup
if [ -f ~/.rvm/bin/rvm-prompt ] ; then
   PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] $(_dir_chomp "$(pwd)" 20)\[\033[01;37m\]$(_parse_git_branch)\[\033[01;34m\] \[\033[01;37m\]$(~/.rvm/bin/rvm-prompt)\[\033[01;34m\] \$\[\033[00m\] '
   PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
   [[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # This loads RVM into a shell session.
else
   PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] $(_dir_chomp "$(pwd)" 20)\[\033[01;37m\]$(_parse_git_branch)\[\033[01;34m\] \$\[\033[00m\] '
fi 

### Host-specifics 
## ltrace
if [ "$(hostname)" == "ltrace.linpro.no" ] ; then
   source ~/.keychain/$(hostname)-sh
   source /etc/bash_completion
fi

# Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion

