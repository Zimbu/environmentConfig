#!/bin/bash

PYTHON_SETUP_TOOLS_INSTALLED=$(dpkg-query -W --showformat='${Status}\n' python-setuptools 2> /dev/null | grep "install ok installed")
if [ "" == "$PYTHON_SETUP_TOOLS_INSTALLED" ]; then
  echo "Installing Python Setup Tools: sudo apt-get --force-yes --yes install python-setuptools"
  sudo apt-get update
  sudo apt-get --force-yes --yes install python-setuptools
fi

PIP_INSTALLED=$(which pip)
if [ "" == "$PIP_INSTALLED" ]; then
  echo "Installing PIP: sudo easy_install pip"
  sudo easy_install pip
fi

POWERLINE_STATUS_INSTALLED=$(pip show powerline-status 2> /dev/null | grep "Name")
if [ "" == "$POWERLINE_STATUS_INSTALLED" ]; then
  echo "Installing powerline-status: pip install --user powerline-status"
  pip install --user powerline-status
  wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
  wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
  if [ ! -d ~/.local/share/fonts/ ]; then
    mkdir -p ~/.local/share/fonts/
  fi
  mv PowerlineSymbols.otf ~/.local/share/fonts/
  fc-cache -vf ~/.local/share/fonts/

  if [ ! -d ~/.config/fontconfig/conf.d/ ]; then
    mkdir -p ~/.config/fontconfig/conf.d/
  fi
  mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/
fi

