#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# perl gnu stow
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# aliases
alias vim="nvim"
alias py="python3"
alias ls="exa --icons"
alias l="ls -lah"
alias tree="ls -Ta"
alias lt="ls -Ta"
alias s="systemctl"

# starship
eval "$(starship init bash)"
