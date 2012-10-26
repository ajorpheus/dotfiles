#
#/bin/zsh -f

case `uname` in
OpenBSD)
    # Enviroment Varibles
    export PKG_PATH=http://openbsd.mirrors.pair.com/`uname -r`/packages/`machine -a`/

    # which version of ls should we use?
    if [ -x /usr/local/bin/gls ]; then
        alias ls='/usr/local/bin/gls -F --color --human-readable'
        export LS_COLORS="no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;3:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:"
    else
        if [ -x /usr/local/bin/colorls ]; then
            alias ls='/usr/local/bin/colorls -G -F'
            export LSCOLORS="ExGxFxDxCxDxDxxbadacad"
            export CLICOLOR="1"
        fi
    fi
    # Aliases
    alias cvsup="cd /usr && cvs -qd anoncvs@anoncvs1.usa.openbsd.org:/cvs checkout -P -rOPENBSD_4_6 src"
    alias srcup="cd /usr/src && cvs -q up -rOPENBSD_4_6 -Pd"
    alias portsup="cd /usr &&  cvs -qd anoncvs@anoncvs1.usa.openbsd.org:/cvs get -rOPENBSD_4_6 -P ports"
    alias cvsrun="sudo cvsup -g -L 2 /etc/cvs-supfile"
    alias killall="pkill"
    alias shred="rm -P"
    alias packages="wget http://openbsd.mirrors.pair.com/`uname -r`/packages/`machine -a`/index.txt -O /tmp/packages.list && $PAGER /tmp/packages.list"
    alias rm='nocorrect rm -i'

;;
FreeBSD)
    SSH_ASKPASS="/usr/local/bin/ssh-askpass-gtk2"
    export LSCOLORS="ExCxFxFxBxGxGxababaeae"
    export CLICOLOR="1"

    alias ls='ls -GF'
    alias portu="sudo csup -L 2 /etc/ports-cvsup"
    alias srcu="sudo csup -L 2 /etc/src-cvsup"

;;
Linux)
    #aliases
    alias ls='ls -F --color --human-readable'
    alias rm='nocorrect /bin/rm -I --preserve-root'

    #############################################################################
    # colors for ls, etc.  Prefer ~/.dir_colors
    #############################################################################
    # activate ls colors, (private if possible)
    if [[ -a $HOME/.dir_colors ]]; then
        if [[ "$TERM" == *256* ]]; then
            which dircolors > /dev/null && eval "`dircolors -b $HOME/.dir_colors`"
        else
            # standard colors for non-256-color terms
            which dircolors > /dev/null && eval "`dircolors -b`"
        fi
    else
        which dircolors > /dev/null && eval "`dircolors -b`"
    fi

    if [[ -f /etc/gentoo-release ]]; then
        alias ms="mirrorselect -b10 -s5 -D"
        alias python-updater="python-updater -P paludis"
        alias module-rebuild="module-rebuild -P paludis $@"
    fi

 ;;
esac
