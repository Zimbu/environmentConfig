#!/bin/bash

#################################
# Ensure PowerLine is Installed #
#################################
source ~/setupScripts/configurePowerline.sh

# Preseumes that .bashrc already exists and loads .bash_aliases if it exists
cat >~/.bash_aliases <<EOL
# Personal Command Aliases
alias vimrc='vim ~/.vimrc'
alias tmuxconfig='vim ~/.tmuxconfig'
alias basha='vim ~/.bash_aliases'
alias rebash='source ~/.bashrc'
alias tmux='tmux -2' # Use 256 colors for tmux terminal...

# Make directory and then change into it
mkcd() {
  mkdir \$1
  cd \$1
}

PATH=\$PATH:~/bin
PATH=\$PATH:~/.local/bin

# Powerline Settings
#export TERM="term-256color"

if [ -f ~/.local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh ]; then
  # PROMPT_COMMAND on one system contained 'dirty' contents with caused undesireable 
  # powerline prompt behavior (mainly \$PWD was stuck to the value at shell startup)
  #unset PROMPT_COMMAND

  powerline-daemon -q
  POWERLINE_BASH_CONTINUATION=1
  POWERLINE_BASH_SELECT=1

  source ~/.local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh
fi
EOL

echo "Execute 'source ~/.bashrc' to reload bash settings in the current shell"

