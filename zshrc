#zmodload zsh/zprof

# {{{ source system zprofile first
if [[ -e /etc/zsh/zprofile ]]; then
  source /etc/zsh/zprofile
fi
# }}}

# {{{ Return if non-interactive
[[ "$-" == *i* ]] || return # Shell is non-interactive.  Be done now!
# }}}

# {{{ Keychain
if type keychain &>/dev/null ; then
  eval $(keychain --quiet --nogui --eval \
    id_rsa.work \
    id_rsa.github \
    id_rsa.nlfg \
    id_rsa.gitcrate \
    id_rsa.wbox \
    | sed -e 's,;,\n,g' )
fi
# }}}

ZSH_CONF_DIR=~/.zsh/
ZSH_CONF_FILES=(
  path
  modules
  functions
  aliases
  os
  env
  completion
  git
  debian
  zkbd
  prompt
  options
  fortune
  vagrant
  heruko
  task
  open
  termsupport
  knife
  bundler
  tarsnap
  berks
  tmux
)

for conf_file in $ZSH_CONF_FILES
do
  if [[ -e $ZSH_CONF_DIR/$conf_file.zsh ]]
  then
    source $ZSH_CONF_DIR/$conf_file.zsh;
  fi
done

# {{{ syntax highlighting
source ~/.zsh/vendor/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# }}}

# {{{ zsh history substring search
source ~/.zsh/vendor/zsh-history-substring-search/*.zsh
# }}}

source ~/.zsh/vendor/z/z.sh

eval "$(rbenv init -)"

