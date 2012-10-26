
#!/bin/zsh -f
# global aliases
alias -g SAD='&> /dev/null &|'
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g L="| less"
alias -g M="| most"
alias -g B="&|"
alias -g HL="--help"
alias -g LL="2>&1 | less"
alias -g CA="2>&1 | cat -A"
alias -g NE="2> /dev/null"
alias -g NUL="> /dev/null 2>&1"

# ls shortcuts
alias ls='ls --color=auto -F'
alias lsg="ls | ack"
alias lsa='ls -A' # only show dot-files
alias lsw='ls -d *(R,W,X.^ND/)' # world-{readable,writable,executable} files
alias lsd='ls -d *(/)' # only show directories
alias lse='ls -d *(/^F)' # only show empty directories
alias lss='ls *(s,S,t)' # only files with setgid/setuid/sticky flag
alias lsl='ls *(@)' # only symlinks
alias lsx='ls *(*)' # only executables
alias lsnew="ls -rl *(D.om[1,10])" # display the newest files
alias lsold="ls -rtlh *(D.om[1,10])" # display the oldest files
alias lsbig="ls -1hSs"
alias lssmall="ls -Srl *(.oL[1,10])" # display the smallest files
# `ll' series of listing aliases: More detailed, and more verbose.
alias ll='ls -lAh'
alias llw='ll -d *(R,W,X.^ND/)' # world-{readable,writable,executable} files
alias lld='ll -d *(/)' # only show directories
alias lle='ll -d *(/^F)' # only show empty directories
alias lls='ll *(s,S,t)' # only files with setgid/setuid/sticky flag
alias lll='ll *(@)' # only symlinks
alias llx='ll *(*)' # only executables

# nocorrect
alias cp='nocorrect cp'
alias mv='nocorrect mv'
alias ln='nocorrect ln'
alias mkdir='nocorrect mkdir -p'

# shortcuts
alias which="whence -a"
alias c="clear"
alias ej='eject -T'
alias k='killall'
alias e='vim'
alias m="mplayer"
alias ml="mplayer -loop 0"
alias mls="mplayer -loop 0 -shuffle"
alias mn="mplayer -nosound"
alias ms="mplayer -sound"
alias mf='mplayer -af scaletempo=scale=1.5:speed=1.5 -speed 1.5'
alias find='noglob find'
alias less="less -FiMRsX"
alias vn="vim -c 'NERDTree'"

# default options
alias tree='tree -F -A'
alias cpan="perl -MCPAN -e shell"
alias wget="wget --content-disposition -c"
alias ncmpc="ncmpc -c"
alias most="most +u"
alias ri="ri -Tf ansi"
alias poweroff="s poweroff"
alias reboot="s reboot"
alias shred='nocorrect ionice -c3 /usr/bin/shred -fuzv'
alias wipe='nocorrect ionice -c3 /usr/bin/wipe -l1 -v -r'
alias pwgen='pwgen -Bync 20'
alias wpakey='/usr/bin/pwgen -Bync 63 1'
alias calc='noglob calc'
alias ri='ri -f ansi'
alias wgetdir='wget -r -l1 -P035 -nd --no-parent'
alias gf='get_flash_videos'
alias ack="nocorrect ack"
alias bc='bc -l'
# newsbeuter can really thrash my disk when updating cache
alias newsbeuter='ionice -c3 newsbeuter'
alias filezilla='ionice -c3 filezilla'
alias locate='locate --existing --follow --basename --ignore-case'
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

#tmux
alias tmux="tmux -2 -u"
alias tml="tmux list-sessions"
alias tma="tmux attach-session -t"
alias tmr="tmux attach-session"
alias tmk="tmux kill-session -t"
alias tmks="tmux kill-server"

# git
# Aliases
alias gcl='git clone'
alias gis="git status | grep --color=always '^[^a-z]\+\(new file:\|modified:\)' | cut -d'#' -f2-"
alias gid='git diff --cached'
alias gic='git commit -m'
alias gia='git add'
alias gip='git add -p'
alias grb='git rebase'
alias goc='git checkout'
alias gme='git merge'
alias grh='git reset HEAD'
alias gp='git push'
alias gpr='git pull --rebase'
alias grm='git rm $(git ls-files --deleted)'
alias gaa='git ls-files -o --exclude-per-directory=.gitignore | xargs git add'
alias rlog='git log --pretty=format:"%h %Cblue%cr%Creset %cn %Cgreen%s%Creset"'
alias plog='git log --graph --pretty="tformat:%C(yellow)%h%Creset %Cgreen(%ar)%Creset %C(bold blue)<%an>%Creset %C(red)%d%Creset %s"'
alias mkpatch="git format-patch --stdout -M -C -C -1"
alias sendpatch="git format-patch --stdout -M -C -C -1 | wgetpaste -r"

# new commands
alias s="sudo"
alias vim="vim -p"
alias xlog="sudo grep --binary-files=without-match --color -nsie '(EE)' -e '(WW)' /var/log/Xorg.0.log"
alias sd='export DISPLAY=:0.0'
alias cup='cvs -z3 update -Pd'
alias wp="~/bin/wallpaper"
alias dosbox="dosbox -conf ~/.dosbox.conf"
alias lk='curl http://kernel.org/kdist/finger_banner'
alias images='feh -d -x -F -Z '
alias wgetlist="wget --content-disposition -c -i"
alias become="sudo -s -H -u $1"
alias runas="sudo -H -u $1 $@"
alias fixkey='ssh-keygen -i -f'
alias minicom='minicom -c on'
alias googlecl='/usr/bin/google'
alias ad='asciidoc -n -a data-uri -a toc'
alias wget-mirror="wget -e robots=off --timestamping --recursive --level=inf --no-parent --page-requisites --convert-links --backup-converted"
alias wget-fullpage="wget -e robots=off --page-requisites --span-hosts --convert-links"
alias checkssl="openssl s_client -connect"
alias bootwindows="sudo grub-reboot 'Windows' && sudo reboot"
alias cr2lf="perl -pi -e 's/\x0d/\x0a/gs'"
alias jk="jekyll --auto --server"
alias ranksmirrors="rankmirrors -n 5 /etc/pacman.d/mirrorlist.org > /etc/pacman.d/mirrorlist"
alias leech="wget -e robots=off -c -r --level=0 -nc -np --random-wait"
alias mitize="wget https://dl.dropbox.com/u/3356868/mit-license.txt -O COPYING"
alias virename="vim -c ':Renamer'"
alias weechat="weechat-curses"
alias history='fc -l 1'
alias gcalm='gcalcli calm 1'
alias gcalw='gcalcli calw 2'
alias gcala="gcalcli agenda | $PAGER"
alias flac2mp3="/usr/bin/flac2mp3.pl  --lameargs='--noreplaygain --vbr-new -V 0 -h --nohist --quiet' --processes=2"
alias open='mimi'
alias chive="wget -O - http://www.chive-project.com/Download/Redirect|tar -xzp"
alias myip="dig +short myip.opendns.com @resolver1.opendns.com"
alias sniff="s ngrep -d 'eth0' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="s tcpdump -i eth0 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""
alias yt="youtube-dl -c -t -f best --no-part"
alias tex="rubber --inplace --maxerr -1 --short --force --warn all --pdf"

# One of @janmoesen’s ProTip™s
for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
  alias "$method"="lwp-request -m '$method'"
done

# coloured output using grc
if [ -e /usr/bin/grc ]; then
    alias ping='grc ping'
    alias netstat='grc netstat'
    alias traceroute='grc traceroute'
    alias diff='grc diff'
    alias tail='grc tail'
    alias ps='grc ps'
    alias lsof='grc lsof'
fi

# vim: set et sw=4 sts=4 ts=4 ft=zsh :
