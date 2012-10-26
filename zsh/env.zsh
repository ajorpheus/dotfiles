#!/bin/zsh -f

watch=(notme)  ## watch for everybody but me
LOGCHECK=60  ## check every ... seconds for login/logout activity
WATCHFMT='%n %a %l from %m at %t.'

if [[ -d /etc/init.d ]]; then
    export RCDIR="/etc/init.d/"
elif [[ -d /etc/rc.d ]]; then
    export RCDIR="/etc/rc.d/"
else
    export RCDIR=""
fi

# Set some enviroment varibles
export TMP="/tmp"
export TMDIR=${TMP}
export PAGER='most'
export TERMCMD="/usr/bin/urxvtc"
export BROWSER="/usr/bin/firefox -new-tab"
export TERMINAL=$TERMCMD
# Antialising
export QT_XFT=1
export GDK_USE_XFT=1
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
# Java needs this to behave on e.g. [dwm](http://dwm.suckless.org).
export AWT_TOOLKIT=MToolkit
export _JAVA_AWT_WM_NONREPARENTING=1
# Use tabs when opening urls
export MOZILLA_NEWTYPE=tab
# Speed up firefox.
# Pango renderer just permits to support some exotic languages.
export MOZ_DISABLE_PANGO=1
# Run OpenOffice in GTK2 mode.
export OOO_FORCE_DESKTOP=gnome
# Fixes some gaming issues with evdev
export SDL_VIDEO_X11_DGAMOUSE=0
# SDL Head fix
export SDL_VIDEO_FULLSCREEN_HEAD=1
# Set path to ssh askpass program if needed
#export SSH_ASKPASS="/usr/lib/ssh/ssh-askpass"
export GPODDER_HOME=/home/gregf/media/videos/gPodder
# GLIB
export G_BROKEN_FILENAMES=1
export G_FILENAME_ENCODING="UTF-8"

# We Want utf8
export LANG="en_US.UTF-8"
export LC_COLLATE="C"

# XDG Base Directory Specification
# http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
export XDG_DESKTOP_DIR=$HOME
export XDG_DOWNLOAD_DIR="$HOME/media/downloads"
export XDG_TEMPLATES_DIR=$HOME
export XDG_PUBLICSHARE_DIR=$HOME
export XDG_DOCUMENTS_DIR="$HOME/docs"
export XDG_MUSIC_DIR="$HOME/media/music"
export XDG_PICTURES_DIR="$HOME/media/images"
export XDG_VIDEOS_DIR="$HOME/media/videos"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export ZSH_CONFIG="$XDG_CONFIG_HOME/zsh"
export ZSH_CACHE="$XDG_CACHE_HOME/zsh"
mkdir -p $ZSH_CACHE

export ERRORLOG="${HOME}/.xsession-errors"
export RXVT_SOCKET="$TMP/rxvt-unicode"

# To many stupid scripts don't unset this so I'm using an alias for now
[ ${+TZ} ] || export TZ="EST5EDT"
export MPD_HOST="localhost"
export MPD_PORT="6600"
export GIT_AUTHOR_EMAIL="greg@gregf.org"
export GIT_AUTHOR_NAME="Greg Fitzgerald"
export GIT_COMMITTER_EMAIL=$GIT_AUTHOR_EMAIL
export GIT_COMMITTER_NAME=$GIT_AUTHOR_NAME

export GITHUB_USER=`git config --global --get github.user`

export GIT_SSL_NO_VERIFY=true

# Some settings for autotest
export AUTOFEATURE="true"
export RSPEC="true"

#Fix for growisofs
export MKISOFS='/usr/bin/genisoimage'

export GRC_HOME=~/.grc

# ----------------------------------------
# Ruby Related
# ----------------------------------------
# Set variables for Rails to use more memory but run more quickly
export RUBY_HEAP_MIN_SLOTS=1000000
export RUBY_HEAP_SLOTS_INCREMENT=1000000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=1000000000
export RUBY_HEAP_FREE_MIN=500000


# Some things we want set regardless
export MANPAGER="most"
export PAGER="most"
export EDITOR="vim"
export VISUAL="vim"
export NNTPSERVER="news.gwi.net"
export GPG_TTY=$(tty)
export WINEARCH=win32
export ACK_PAGER=$PAGER
export READNULLCMD=$PAGER
export LESS="-RSM~gIsw"
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'

#custom exports for coloured less
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
# }}}

export CLICOLOR=1
export ACK_OPTIONS="--color"

# {{{ Resource Limits
limit stack 8192
#limit core unlimited
limit core 0
limit -s
# }}}

# {{{ Setup History Options
HISTFILE=$HOME/.zsh_history
HISTSIZE=20000
SAVEHIST=20000
DIRSTACKSIZE=16

setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups # ignore duplication command history list
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history # share command history data
# }}}

# {{{ Term Settings

if [[ -n $SSH_TTY ]]; then
  export TERM="linux"
fi

#auto logout after timeout in seconds

if [[ $TERM == "linux" ]]; then
    TMOUT=1800
fi

## if we are in X then disable TMOUT
case $TERM in
    xterm*|rxvt|(dt|k|E)term|rxvt*|screen*)
    unset TMOUT
    ;;
esac

if [ "`id -gn`" = "`id -un`" -a `id -u` -gt 99 ]; then
    umask 002
else
    umask 022
fi
# }}}

# {{{ Create some default files/directories if they don't exist.
if ! [ -d ~/.ssh ]; then
    mkdir -p ~/.ssh
fi

if ! [ -f ~/.ssh/known_hosts ]; then
    touch ~/.ssh/known_hosts
fi

if ! [ -f ~/.viminfo ]; then
    touch ~/.viminfo
fi

# Kill flow control
if tty -s ; then
    #stty -ixon
    stty -ixoff
fi
