#!/bin/bash


##############################
# Backup the original .vimrc #
##############################
if [ ! -f ~/.vimrc.bak ] && [ -f ~/.vimrc ]; then
  cp ~/.vimrc ~/.vimrc.bak
elif [ ! -f ~/.vimrc.bak ] && [ ! -f ~/.vimrc ]; then
  touch ~/.vimrc.bak
fi

################
# Write .vimrc #
################
cat >~/.vimrc <<EOL

" Leader key is the spacebar, local-leader key is the '\' key
let mapleader = "\<space>"
let maplocalleader = "\\\\"

" Exit Insert Mode by hitting jk
inoremap jk <esc>

" Remaps H to beginning of line, L to end of line
nnoremap H ^
nnoremap L $

EOL
echo ".vimrc configuration written"
