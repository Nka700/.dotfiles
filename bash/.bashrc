#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls -lha --color=auto'
alias grep='grep --color=auto'

# set EDITOR vim
export EDITOR=vim

# define git prompt functions
git_branch() {
    local branch

    branch=$(git symbolic-ref --short HEAD 2>/dev/null) ||
        branch=$(git rev-parse --short HEAD 2>/dev/null) ||
        return

    printf ' (%s)' "$branch"
}

#PS1='[\u@\h \W]\$ '
PS1='[\u@\h \W$(git_branch)]\$ '

[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path bash)"
