# Mohammadreza Amini
# https://github.com/Mohammadreza99A
# my fish config file

# Dependencies:
#   - exa --> https://github.com/ogham/exa
#   - dotacat --> https://git.scd31.com/stephen/dotacat
#   - neofetch --> https://github.com/dylanaraps/neofetch
#   - colorscript --> https://gitlab.com/dwt1/shell-color-scripts
#   - starship --> https://github.com/starship/starship
#

# Inorder to have sparks everytime we clear the terminal, you must have spark.fish file in .config/fish/functions 

set fish_greeting

# Man pages colors
set -xU LESS_TERMCAP_md (printf "\e[01;31m")
set -xU LESS_TERMCAP_me (printf "\e[0m")
set -xU LESS_TERMCAP_so (printf "\e[01;44;33m")
set -xU LESS_TERMCAP_se (printf "\e[0m")
set -xU LESS_TERMCAP_us (printf "\e[01;32m")
set -xU LESS_TERMCAP_ue (printf "\e[0m")

# My aliases
alias ll='exa -al --color=always --group-directories-first' # my preferred listing
alias ls='exa -l --color=always --group-directories-first' # my preferred listing
alias update='paru -Syyu' 
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias clear='/bin/clear; echo; seq 1 (tput cols) | sort -R | spark | dotacat' # Spark alias

# My startup scripts
#neofetch
colorscript random

# My prompt
starship init fish | source
