#! /bin/zsh -f

zmodload -i zsh/complist
zmodload -i zsh/compctl
zmodload -i zsh/computil
zmodload -i zsh/zle

autoload -U compinit
compinit -u

# Magically quote urls
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

autoload -Uz zrecompile colors vcs_info

colors
