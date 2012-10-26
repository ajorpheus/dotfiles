#!/bin/zsh -f

function xclass {
   xprop |awk '
   /^WM_CLASS/{sub(/.* =/, "instance:"); sub(/,/, "\nclass:"); print}
   /^WM_NAME/{sub(/.* =/, "title:"); print}'
}

## find all suid files
function suidfind { ls -l /**/*(su0x) }

function pskill {
    kill -9 `pgrep $1`
    echo "slaughtered."
}

function kscreen { echo -ne "\017"; reset }

function spell { echo "$@" | aspell -a }

function calc { echo "$*" | bc -l }

# Query Wikipedia via console over DNS
# http://www.commandlinefu.com/commands/view/2829
function wip() {
    dig +short txt ${1}.wp.dg.cx
}

function date {
    if [ $# = 0 ]; then
        # format: saturday, december 21, 2002 06:46:38 pm est
        command date +"%a, %b %e %Y %I:%M:%S%P %Z"
    else
        # execute real `date`
        command date $@
    fi
}

function chroot {
    if [ $# = 0 ]; then
        command env -i TERM=$TERM SHELL=/bin/bash HOME=$HOME chroot
    else
        command chroot $@
    fi
}

function cal {
    if [ $# = 0 ]; then
        command cal -3
    else
        command cal $@
    fi
}

function mcdrom {
    local mounted
    local cpwd
    mounted=$(grep cdrom /etc/mtab)
    if [[ $mounted = "" ]];then
        mount /media/cdrom
        echo "-- mounted cdrom --"
        cd /media/cdrom ; ls
    else
        cpwd=$(pwd|grep cdrom)
        if [[ $cpwd = "" ]];then
            umount /media/cdrom
            echo "-- umounted cdrom --"
        else
            cd;umount /media/cdrom
            echo "-- umounted cdrom --"
            pwd
        fi
        eject
    fi
}

function extract {
   local lower full_path target_dir
    lower=${(L)1} # Used for matching
    full_path=$(readlink -f $1) # The real path, expanded & absolute
    file_name="${1}"
    target_dir=$(echo $1 | sed 's/(\.tar)?\.[^.]*$//') # new directory name
    #mkcd $target_dir # mkdir && cd combo
    case "$lower" in
        *.tar.gz) tar xzf "$full_path" ;;
        *.tgz) tar xzf "$full_path" ;;
        *.gz) gunzip -c "$full_path" ;;
        *.tar.bz2) tar xjf "$full_path" ;;
        *.tbz2) tar xjf "$full_path" ;;
        *.bz2) bunzip2 -c "$full_path" ;;
        *.tar) tar xf "$full_path" ;;
        *.rar) unrar x "$full_path" ;;
        *.zip) unzip "$full_path" ;;
        *.z) uncompress "$full_path" ;;
        *.7z) 7z x "$full_path" ;;
        *.xz) xz -d "$full_path" ;;
        *.lzma) unlzma -vk "$full_path" ;;
        *.lha) lha e "$full_path" ;;
        *.rpm) rpm2cpio "$full_path" | cpio -i --make-directories ;;
        *.deb) ar x "$full_path" ;;
        *.arj) arj -y e "$full_path" ;;
        *.ace) unace e "$full_path" ;;
        *.xpi) unzip "$full_path" ;;
        *) print "Unknown archive type: $1" ; return 1 ;;
    esac
    # Change in to the newly created directory, and
    # list the directory contents, if there is one.
    current_dirs=( *(N/) )
    if [[ ${#current_dirs} = 1 ]]; then
        cd $current_dirs[1]
        ls
        break
    fi
}

function mps { /bin/ps $@ -u $USER -o pid,ppid,%cpu,%mem,command ; }

function mpsu { /bin/ps -u $@ -o pid,ppid,%cpu,%mem,command ; }

function mvbackup { mv ${1%%/} ${1%%/}"-`date "+"%Y-%m-%d`" }

function cpbackup { cp -R ${1%%/} ${1%%/}"-`date "+"%Y-%m-%d`" }

# Backup config file then edit it.
function edc {
    cp ${1%%/} ${1%%/}"-`date "+"%Y-%m-%d`".bak
    $EDITOR ${1}
}

function cd2iso { dd if=/dev/cdrom of=$1 bs=2048 conv=sync,notrunc }

function iso2cd { cdrecord $1 }

function cd2cd {
    tmp=`tempfile -p iso`
    cd2iso "$tmp"
    echo "Insert empty disk"; read ans
    iso2cd "$tmp"
}

function files2cd {
    isofile=`tempfile -p iso`
    mkisofs -r -R -J -l -L -o "$isofile" "$*"
    cdrecord "$isofile"
    rm "$isofile"
}

function any2wav {
    # $1 - which file
    # $2 - where to
    echo "Converting file '$1'"
    case "${1##*.}" in
        mp3)
            mpg321 -q -w "$2" "$1"
            ;;
        flac)
            flac -d -o "$2" "$1"
            ;;
        ogg)
            oggdec -o "$2" "$1"
            ;;
        *)
            return 1
            ;;
    esac
    return 0
}

function any2audiocd {
    tmpdir=`mktemp -d`
    COUNTER_KNOWN=0
    COUNTER_UNKNOWN=0

    for file in *.*
    do
        new_name="$tmpdir/$file.wav"
        if any2wav "$file" "$new_name"
        then
            COUNTER_KNOWN=$((COUNTER_KNOWN + 1))
        else
            COUNTER_UNKNOWN=$((COUNTER_UNKNOWN + 1))
        fi
    done
    echo ""
    echo "============================="
    echo "Converted files: $COUNTER_KNOWN"
    echo "  Ignored files: $COUNTER_UNKNOWN"
    echo ""

    if [ $COUNTER_KNOWN = 0 ]
    then
        echo "No supported files were found, exiting."
        return 2
    else
        echo "Burn to CD?"; read ans
        case "$ans" in
            y*|Y*|j*|J*)
                cdrecord speed=4 -pad -audio $tmpdir/*.wav
                ;;
        esac
    fi

    rm $tmpdir/*.wav
}

# make folder and chdir into it:
function mkcd { mkdir -p "$@" && cd "$@" }

function remove_all_gems {
    gem uninstall -x --a --ignore-dependencies `gem list -q -l --no-details --no-versions `
}

function confcat { grep -vh '^[[:space:]]*#' "$@" | grep -v '^$' }

function http_headers { curl -I -L $@ }

function mkbz2 { tar cfav "${1%%/}.tar.bz2" "${1%%/}/" }

function mktar { tar cfzv "${1%%/}.tar.gz" "${1%%/}/" }

function mkxz { tar cfav "${1%%/}.tar.lzma" "${1%%/}/" }

function mkzip { zip -r "${1%%/}.zip" "${1%%/}/" }

function sanitize {
    chmod -R u=rwX,go=rX "$@"
    chown -R ${USER}:users "$@"
}

function keepempty {
    for i in $(find . -type d -regex ``./[^.].*'' -empty); do touch $i"/.gitignore"; done;
}

function xephyr {
    Xephyr -ac -br -noreset -screen 1024x768 :1 &
    sleep 2
    DISPLAY=:1.0 $@
}

function cpv { rsync -rPIhu -- ${@} }

function hgrep { history -Df 0 | ack $1 }

# http://pthree.org/2011/10/18/use-wget1-to-expand-shortened-urls/
function expandurl { wget -S $1 2>&1 | grep "^Location:" }

function ports {
    case `uname` in
    OpenBSD)
        sudo netstat -at | grep LISTEN
    ;;
    FreeBSD)
        sudo sockstat -4 -l
    ;;
    Linux)
        sudo netstat -a --inet --numeric-port
    ;;
    *)
        nmap -sT -O localhost
    ;;
    esac
}

function src {
  autoload -U zrecompile
  rm -f ~/.zsh/*.zwc
  rm -f ~/*.zwc
  rm -f ~/.zcoredump*
  [[ -f ~/.zshrc ]] && zrecompile -p ~/.zshrc
  [[ -f ~/.zshrc.zwc.old ]] && rm -f ~/.zshrc.zwc.old

  for f in ~/.zsh/**/*.zsh; do
    [[ -f $f ]] && zrecompile -p $f
    [[ -f $f.zwc.old ]] && rm -f $f.zwc.old
  done

  [[ -f ~/.zcompdump ]] && zrecompile -p ~/.zcompdump
  [[ -f ~/.zcompdump.zwc.old ]] && rm -f ~/.zcompdump.zwc.old

  source ~/.zshrc
}

function digall { dig +nocmd $1 any +multiline +noall +answer }

function gitize() {
    git init
    git add .
    git commit -m "initial commit"
}

function installed {
    case `uname` in
        Linux)
            if [[ -e /etc/gentoo-release ]]; then
                sudo qlist -I
            elif [[ -e /etc/exherbo-release ]]; then
                sudo cave show "*/*::/"
            elif [[ -e /etc/arch-release ]]; then
                pacman -Qq
            fi
            ;;
        *BSD)
            sudo pkg_info
            ;;
        *)
            echo "Not sure how to list installed packages for `uname`"
            ;;
    esac

}

function burniso {wodim -v dev=/dev/sr0 speed=12 $* }

function burndliso { growisofs -speed=4 -dvd-compat -Z /dev/sr0=$* }

function burndvdiso { growisofs -speed=8 -dvd-compat -Z /dev/sr0=$* }

function burndvddir { growisofs -Z /dev/sr0 -R -J -speed=4 $* }

function mkdvdiso { genisoimage -o dvd.iso -R -J -hfs $* }

function mkisofs { genisoimage -o cd.iso -R -J $* }

function serve { python -m SimpleHTTPServer 8080 }

function dict {
    if [ `command -v dictl` ]; then
        dictl $1 | $PAGER
    else
        curl dict://dict.org/d:${1}:web1913 | $PAGER
    fi
}

function fontlist { fc-list | sed 's,:.*,,' | sort -u }

[[ -d /etc/rc.d ]] && RCDIR="/etc/rc.d"
[[ -d /etc/init.d ]] && RCDIR="/etc/init.d"

function rcstart()      {sudo $RCDIR/$1 start}
function rcstop()       {sudo $RCDIR/$1 stop}
function rcrestart()    {sudo $RCDIR/$1 restart}
function rczap()        {sudo $RCDIR/$1 zap}
function rcdel()        {sudo rc-update del $1}
function rcadd()        {sudo rc-update add $1 default}
function service()      {sudo $RCDIR/$1 $2}

# Package management helper functions
# Root where packages are stored
PACKAGE_ROOT=/home/gregf/media/packages

# Download package from aur
function aurd {
    if wget http://aur.archlinux.org/packages/$1/$1.tar.gz \
             -O $PACKAGE_ROOT/aur/$1.tar.gz;
    then
        builtin cd $PACKAGE_ROOT/aur
        tar xvf $1.tar.gz || return 1
        rm $1.tar.gz
        cd $1
    fi
}

function new-scratch {
  cur_dir="$HOME/scratch"
  new_dir="$HOME/tmp/scratch-`date +'%s'`"
  mkdir -p $new_dir
  ln -nfs $new_dir $cur_dir
  cd $cur_dir
  echo "New scratch dir ready for grinding ;>"
}

# http://www.miek.nl/blog/archives/2008/07/10/f/index.html
function f {
    if [[ ! -f $1 ]]; then return 1; fi

    copy=$(mktemp ${TMPPREFIX:-/tmp/shell}.XXXXXXX)
    if cp $1 $copy; then
        if ${EDTIOR:-vim} $copy; then
        $SHELL $copy
        # add to hist
        fc -R ${copy}
        rm -f $copy
        fi
    else
        return 1
    fi
}

# vim: set et sw=4 sts=4 ts=4 ft=zsh :
