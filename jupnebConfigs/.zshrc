# JupNeb zsh configuration

POWERLEVEL9K_MODE='awesome-fontconfig'
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_RPROMPT_ON_NEWLINE=true
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir vcs)
#POWERLEVEL9K_SHORTEN_STRATEGY="truncate_middle"
POWERLEVEL9K_SHORTEN_DIR_LENGTH=3

source /usr/share/zsh-theme-powerlevel9k/powerlevel9k.zsh-theme

# LS_COLORS. This sets dircolors to the contents of the ~/.dircolors file.
# This can be found at the following URL. Comment out the eval to disable this.
# https://raw.githubusercontent.com/trapd00r/LS_COLORS/master/LS_COLORS
eval $( dircolors -b $HOME/.dircolors )
alias ls='ls --color --human-readable --group-directories-first --classify'
alias grep='grep --color'
alias pacman='pacman --color auto'
alias sudo='sudo '

# Make sure we're in vim mode; change to -e if you prefer Emacs input
bindkey -v

