# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

# alias
#alias scriptlog='script -a ./term_$(whoami)_$(date +%Y_%m%d_%H%M%S).log'
alias ls='ls --color=auto'
alias ll='ls --color=auto -lha'

# ssh keys
eval $(ssh-agent)
ssh-add ${HOME}/.ssh/*.pem
ssh-add ${HOME}/.ssh/*.rsa

# history initiazation
HISTTIMEFORMAT='%F %T '

# for rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# for rustup
. "$HOME/.cargo/env"

# screenfetch
neofetch
