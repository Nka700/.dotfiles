# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

# alias
#alias scriptlog='script -a ./term_$(whoami)_$(date +%Y_%m%d_%H%M%S).log'
alias ls='ls --color=auto'
alias ll='ls --color=auto -lha'

# ssh keys
eval $(ssh-agent)
#ssh-add ${HOME}/.ssh/*.pem
#ssh-add ${HOME}/.ssh/*.rsa

# history initiazation
HISTTIMEFORMAT='%F %T '

# for rbenv
#export PATH="$HOME/.rbenv/bin:$PATH"
#eval "$(rbenv init -)"

# for rustup
#. "$HOME/.cargo/env"

# screenfetch
#neofetch

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
#__conda_setup="$('/home/nka700/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
#if [ $? -eq 0 ]; then
#    eval "$__conda_setup"
#else
#    if [ -f "/home/nka700/anaconda3/etc/profile.d/conda.sh" ]; then
#        . "/home/nka700/anaconda3/etc/profile.d/conda.sh"
#    else
#        export PATH="/home/nka700/anaconda3/bin:$PATH"
#    fi
#fi
#unset __conda_setup
# <<< conda initialize <<<

