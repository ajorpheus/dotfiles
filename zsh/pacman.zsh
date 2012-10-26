if [ -e /etc/arch-release ]; then
    alias p="packer --noedit"
    alias pc="s pacman-color"
    alias install="p -S"
    alias remove="pc -Rns "
    alias fremove="pc -Rdd "
    alias search="p -Ss"
    alias pacsearch="p -Sl | cut -d' ' -f2 | grep -i"
    alias upgrade="p -Syu && sudo pacman-optimize"
    alias pfiles="pc -Ql"
    alias pinfo="p -Si"
    alias belongs="pc -Qo"
    alias mirror="s reflector -c %own% -f 5 > /etc/pacman.d/mirrorlist"


    # https://bbs.archlinux.org/viewtopic.php?id=93683
    paclist() {
      sudo pacman -Qei $(pacman -Qu|cut -d" " -f 1)|awk ' BEGIN {FS=":"}/^Name/{printf("\033[1;36m%s\033[1;37m", $2)}/^Description/{print $2}'
    }

    alias paclsorphans="pc -Qdt"
    alias pacrmorphans="pc -Rs $(pacman -Qtdq)"
fi
