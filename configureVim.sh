#!/bin/bash

# TODO - Build and install VIM



##############################
# Backup the original .vimrc #
##############################
if [ ! -f ~/.vimrc.bak ] && [ -f ~/.vimrc ]; then
  cp ~/.vimrc ~/.vimrc.bak
elif [ ! -f ~/.vimrc.bak ] && [ ! -f ~/.vimrc ]; then
  touch ~/.vimrc.bak
fi

###############
# Install GIT #
###############
GIT_INSTALLED=$(dpkg-query -W --showformat='${Status}\n' git 2> /dev/null | grep "install ok installed" )
if [ "" == "$GIT_INSTALLED" ]; then
  echo "Installing git: sudo apt-get --force-yes --yes install git"
  sudo apt-get update
  sudo apt-get --force-yes --yes install git
fi

##################
# Install Vundle #
##################
if [ ! -d ~/.vim/bundle/vundle ]; then
  echo "Installing Vundle: git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle"
  git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
fi

################
# Write .vimrc #
################
cat >~/.vimrc <<EOL
" Vundle Plugins (Run ':PluginInstall' every time Vundle plugins change and ':PluginUpdate' to update plugins)
filetype off
set rtp+=~/.vim/bundle/vundle
call vundle#rc()
  Plugin 'VundleVim/Vundle.vim'

  " Google-Color Themed Code Highlighting
  Plugin 'google/vim-colorscheme-primary'

  " TODO Vimux Plugin
" End Vundle Plugins (resetting filetype)
filetype plugin indent on

" Google Color Scheme
syntax enable
set t_Co=256
set background=light
colorscheme primary

" Leader key is the spacebar, local-leader key is the '\' key
let mapleader = "\<space>"
let maplocalleader = "\\\\"

" Line number: Displays current line number and other lines display the relative distance from the crrent line number
set relativenumber
set number

" Exit Insert Mode by hitting jk
inoremap jk <esc>

" Remaps H to beginning of line, L to end of line
nnoremap H ^
nnoremap L $

" Split Window / Multi-File Modifications
nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>

" Use system clipboard
set clipboard=unnamedplus

""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Learn VimScript the Hard way customizations    ""
"" http://learnvimscriptthehardway.stevelosh.com/ ""
""""""""""""""""""""""""""""""""""""""""""""""""""""

" Open .vimrc in split view 'Edit my .vimrc'
nnoremap <leader>ev :vsplit \$MYVIMRC<cr>
" Reload .vimrc 'Source my .vimrc'
nnoremap <leader>sv :source \$MYVIMRC<cr>

" Open .tmux.conf in split view 'Edit my .tmux.conf'
nnoremap <leader>et :vsplit ~/.tmux.conf<cr>

" Open .bashrc in split view 'Edit my .bashrc'
nnoremap <leader>eb :vsplit ~/.bash_aliases<cr>

" Move the current line up/down
nnoremap <leader>mk ddkP
nnoremap <leader>mj ddp

" Capitalize the current word
inoremap <c-u> <esc>gUiwei

" Surround word with single/double-quotes
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
vnoremap <leader>' <esc>\`>a'<esc>\`<i'<esc>\`>l
vnoremap <leader>" <esc>\`>a"<esc>\`<i"<esc>\`>l

EOL
echo ".vimrc configuration written"
