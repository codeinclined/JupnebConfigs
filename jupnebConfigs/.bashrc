#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

VISUAL='termite -e kak'

(wal -r &)

alias ki='kak -c kak-i3'
alias kt='kak -c kak-tty'
