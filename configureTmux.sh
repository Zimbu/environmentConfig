#!/bin/bash

source ~/setupScripts/configurePowerline.sh

TMUX_INSTALLED=$(dpkg-query -W --showformat='${Status}\n' tmux 2> /dev/null | grep "install ok installed")
if [ "" == "$TMUX_INSTALLED" ]; then
  echo "Installing TMUX: sudo apt-get --force-yes --yes install tmux"
  sudo apt-get update
  sudo apt-get --force-yes --yes install tmux
fi

cat >~/.tmux.conf <<EOL
#-----------------------------#
# Prefix / Bind-Key Remapping #
#-----------------------------#

# Powerline
source ~/.local/lib/python2.7/site-packages/powerline/bindings/tmux/powerline.conf

# TMUX causes ESCAPE Key delays when working within VIM modes
# Reduce that delay to zero and turn off the stick-key behavior of escape
set -sg escape-time 0

# Remap bind-key from Ctrl-b to Ctrl-a
unbind C-b
set-option -g prefix C-a
bind-key C-a send-prefix

# Use send-prefix to pass Ctrl-a through to application
# i.e. 'Ctrl-a application command outside tmux, is Ctrl-a, Ctrl-a inside tmux'
bind C-a send-prefix

#---------------#
# Configuration #
#---------------#
bind r source-file ~/.tmux.conf

#-------------#
# Split Panes #
#-------------#

# Use | and - to split vertically and horizontally
bind | split-window -h
bind - split-window -v
unbind '"'
unbind %

# Switch windows using Alt-arrow without prefix key
bind -n M-Left select-pane -L
bind -n M-Right select-pane -R
bind -n M-Up select-pane -U
bind -n M-Down select-pane -D

# Use vi bindings
set-window-option -g mode-keys vi
unbind h
unbind M-h
unbind C-h
bind h select-pane -L
bind -n M-h resize-pane -L
bind C-h resize-pane -L
unbind j
unbind M-j
unbind C-j
bind j select-pane -D
bind -n M-j resize-pane -D
bind C-j resize-pane -D
unbind k
unbind M-k
unbind C-k
bind k select-pane -U
bind -n M-k resize-pane -U
bind C-k resize-pane -U
unbind l
unbind M-l
unbind C-l
bind l select-pane -R
bind -n M-l resize-pane -R
bind C-l resize-pane -R

#------------#
# Status Bar #
#------------#
set-option -g status-position top
#set-option -g status on
#set -g status-utf8 on
#set -g status-interval 5

EOL

echo "tmux configuration written"
