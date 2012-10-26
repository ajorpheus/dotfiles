#!/bin/bash
# ----------------------------------------------------------------------------
# File:     ~/.xinitrc
# Author:   Greg Fitzgerald <greg@gregf.org>
# Modified: Sat 21 Aug 2010 08:15:32 PM EDT
# ----------------------------------------------------------------------------


# Argument is fine
WM="${1-i3}"

# {{{ Resource and keymap settings
usermodmap="${HOME}/.Xmodmap"
userresources="${HOME}/.Xresources"

# Merge system and user resources and keymaps
xrdb -load ${userresources} &
xmodmap ${usermodmap} &
# }}}

# Always start X11 with a clean log file
if (cp /dev/null ${ERRORLOG}); then
  chmod 600 ${ERRORLOG}
  exec >${ERRORLOG} 2>&1
  break
fi

# dbus
#[ -z "$DBUS_SESSION_BUS_ADDRESS" ] && eval `dbus-launch --sh-syntax --exit-with-session`

[ -x /usr/bin/unclutter ] && unclutter -display $DISPLAY -jitter 0 -idle 5 &

# Special Effects
#xcompmgr -cCfFD 5 &

#Get back ctrl+alt+backspace in new versions of xorg
setxkbmap -option "terminate:ctrl_alt_bksp" &

#{{{ xset
if [ -x /usr/bin/xset ]; then
  #Disable repeat for multimediakeys
  #xset -r 129 -r 231 -r 198 -r 236 -r 160 &

  # Disable Bell
  xset -b
  # Enable energy star features
  xset +dpms
  # Keyboard Repeat Rate
  xset r rate 250 50 &
  # Mouse Acceleration & Threshold
  xset m 5 1

  #Load additional fonts
  xset fp+ /home/gregf/.fonts/ &
  xset fp rehash
fi
# }}}


if [ -x /usr/bin/xsetroot ]; then
  xsetroot -solid black &
  xsetroot -cursor_name left_ptr &
fi

#Turn on numlock
[ -x /usr/bin/numlockx ] && numlockx on &

#sync PRIMARY with clipboard
# if [ -x /usr/bin/autocutsel ]; then
#   autocutsel -fork &
# fi

# Fix crappy java applications
[ -x /usr/bin/wmname ] && wmname LG3D &

#Pointer appearance
#  - xcb does not support Xcursor yet
[ -x /usr/bin/urxvtd ] && /usr/bin/urxvtd -q -o -f &

# # http://wiki.archlinux.org/index.php/Touchpad_Synaptics
# syndaemon -t -k -i 2 -d &
# synclient HorizTwoFingerScroll=1 TapButton2=3 TapButton3=2

# restore nvidia settings
#nvidia-settings -l

## Run these after the window manager has been started
#Setup Tunnels
if [ -x /usr/bin/ssh ]; then
  [ -x ~/bin/securedeluge ] && ~/bin/securedeluge &
fi

#[ -x /usr/bin/ssh ] && /usr/bin/ssh -L 3306:192.168.144.46:3306 sql

[ -x /usr/bin/dunst ] && dunst &
[ -x /usr/bin/xautolock ] && /usr/bin/xautolock -time 30 -locker ~/bin/lock -secure -notify 20 &
[ -x /usr/bin/xcape ] && /usr/bin/xcape &
[ -x ~/bin/wallpaper ] && ~/bin/wallpaper &
[ -x /usr/bin/mpd ] && mpd &
[ -x /usr/bin/mpdscribble ] && /usr/bin/mpdscribble --conf ~/.mpd/mpdscribble.conf &
[ -x /usr/bin/weatherboy ] && /usr/bin/weatherboy -l 12759591 -u f -a &
[ -x ${TERMCMD} ] && ${TERMCMD} &
[ -x /usr/bin/firefox ] && firefox &
[ -x /usr/bin/dropboxd ] && /usr/bin/dropboxd start &

while true; do "${WM}"
  gxmessage 'Do you really want to quit?' \
            -buttons 'Yes:0,No:1' -center \
            -default 'No' -timeout 30 \
  && break
done
