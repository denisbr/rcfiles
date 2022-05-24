My personal rcfiles, vim config etc.

# Usage

    cd ~/git/
    git clone git://github.com/denisbr/rcfiles.git
    cd rcfiles
    git submodule init
    git submodule update

symlink the rcfiles to ~

## Submodules

### Add 

    cd ~/git/rcfiles/.vim/bundle
    git submodule add https://github.com/hacker/some-module
    git commit

### Update

    git submodule update --remote

### Remove

    git config -f .git/config --remove-section submodule..vim/bundle/some-module
    git config -f .gitmodules --remove-section submodule..vim/bundle/some-module
    git add .gitmodules
    git rm --cached ./vim/bundle/some-module
    git commit -m "Remove some-module"
    rm -rf .vim/bundle/some-module
    rm -rf .git/modules/.vim/bundle/some-module

# TODO

* Use Taskfile for automation
