print -P "\e[1;32m Welcome to: \e[1;34m%m"
print -P "\e[1;32m Running: \e[1;34m`uname -srm`\e[1;32m on \e[1;34m%l"
print -P "\e[1;32m It is:\e[1;34m %D{%r} \e[1;32m on \e[1;34m%D{%A %b %f %G}"
[ -x /usr/bin/fortune ] && print -P `fortune -s`
