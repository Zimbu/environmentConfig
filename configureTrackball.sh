#!/bin/bash

if [ ! -d /usr/share/X11/xorg.conf.d ]; then
  echo "Directory '/usr/share/X11/xorg.conf.d' does not exist.  Aborting mouse configuration.";
fi

if [ -f /usr/share/X11/xorg.conf.d/50-marblemouse.conf ]; then
  echo "File '/usr/share/X11/xorg.conf.d/50-marblemouse.conf' already exists. No configuration required."
  exit 0
fi

cat >./50-marblemouse.conf <<EOL
# Large button left	: normal click
# Both large buttons	: middle click
# Large button right	: right-click
# Small button left	: browser back
# Small button left+ball: scroll (vertically or horizontally)
# Small button right	: browser forward
Section "InputClass"
  Identifier "Marble Mouse"
  MatchProduct "Logitech USB Trackball"
  Driver "libinput"

  Option "ScrollMethod" "button"
  Option "ScrollButton" "8"
  Option "MiddleEmulation" "on"
EndSection
EOL

sudo mv ./50-marblemouse.conf /usr/share/X11/xorg.conf.d/50-marblemouse.conf
echo "Logout of current Xsession for trackball changes to work."

