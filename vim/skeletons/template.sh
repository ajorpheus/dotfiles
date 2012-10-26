#!/usr/bin/env bash
# Distributed under the terms of the MIT License
# Copyright (C) <+DATE+> <+AUTHOR+>
# vim: set sw=4 sts=4 et tw=80 :

scrpt=${0##*/}  # script name

# Display usage if no parameters given
if [[ -z "$@" ]]; then
  echo " $scrpt <input> - description"
  exit
fi

# Text color variables
txtred='\e[0;31m'       # red
txtgrn='\e[0;32m'       # green
txtylw='\e[0;33m'       # yellow
txtblu='\e[0;34m'       # blue
txtpur='\e[0;35m'       # purple
txtcyn='\e[0;36m'       # cyan
txtwht='\e[0;37m'       # white
bldred='\e[1;31m'       # red    - Bold
bldgrn='\e[1;32m'       # green
bldylw='\e[1;33m'       # yellow
bldblu='\e[1;34m'       # blue
bldpur='\e[1;35m'       # purple
bldcyn='\e[1;36m'       # cyan
bldwht='\e[1;37m'       # white
txtund=$(tput sgr 0 1)  # Underline
txtbld=$(tput bold)     # Bold
txtrst='\e[0m'          # Text reset

# Feedback indicators
info=${bldwht}*${txtrst}
pass=${bldblu}*${txtrst}
warn=${bldred}!${txtrst}

# Indicator usage
echo -e "${info} "
echo -e "${pass} "
echo -e "${warn} "

<+CURSOR+>

