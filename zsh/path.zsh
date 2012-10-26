#!/bin/zsh -f

fpath=(~/.zsh/vendor/zsh-completions/src/ $fpath)
cdpath=(/storage ~/code ~/code/active ~/code/vendor ~/media ~/docs)
MANPATH="/usr/local/man:$MANPATH"

export PATH=~/.rbenv/bin:~/bin:/usr/local/sbin:/usr/local/bin:/usr/local/share/npm/bin:/opt/vagrant/bin:~/android-sdk-linux/tools:$PATH

# remove duplicate entries from path,cdpath,manpath & fpath
typeset -gU SCRIPTPATH MANPATH GEMPATH ROOTPATH cdpath fpath
