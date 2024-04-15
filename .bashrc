#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# aliases
alias vim="nvim"
alias py="python3"
alias ls="exa --icons"
alias l="ls -lah"

# starship
eval "$(starship init bash)"


