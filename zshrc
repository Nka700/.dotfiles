# initialize completion
typeset -g  comppath="$HOME/.cache"
typeset -g  compfile="$comppath/.zcompdump"
[[ -w "$compfile" ]] || rm -rf "$compfile" >/dev/null 2>&1

# for rustup
fpath=(~/.zsh/completions $fpath)
fpath=( $fpath)

# set prompt colors
autoload -Uz colors ; colors
PROMPT="%{$fg_bold[yellow]%}%n%{$reset_color%}@%{$fg[cyan]%}%m %{$fg_no_bold[yellow]%}%1~ %{$reset_color%}%#"
RPROMPT="[%{$fg_no_bold[yellow]%}%?%{$reset_color%}]"

# This will set the default prompt to the walters theme
autoload -Uz promptinit
promptinit
prompt walters

# set prompt colors
autoload -Uz colors ; colors
PROMPT="%{$fg_bold[yellow]%}%n%{$reset_color%}@%{$fg[cyan]%}%m %{$fg_no_bold[yellow]%}%1~ %{$reset_color%}%#"
RPROMPT="[%{$fg_no_bold[yellow]%}%?%{$reset_color%}]"

# set EDITOR vim
export EDITOR=vim

# history
HISTTIMEFORMAT='%F %T '
HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=1000000

# alias
alias ll='ls -lha --color=auto'
alias grep='grep --color=always'
#alias scriptlog='script -a ./term_$(whoami)_$(date +%Y_%m%d_%H%M%S).log'
alias history='history -E 1'

# Git
function gt() {
  is_in_git_repo || return
  git tag --sort -version:refname |
  fzf-down --multi --preview-window right:70% \
    --preview 'git show --color=always {} | head -200'
}

function gr() {
  is_in_git_repo || return
  git remote -v | awk '{print $1 "\t" $2}' | uniq |
  fzf-down --tac \
    --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" {1} | head -200' |
  cut -d$'\t' -f1
}

function gs() {
  is_in_git_repo || return
  git stash list | fzf-down --reverse -d: --preview 'git show --color=always {1}' |
  cut -d: -f1
}
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[ %b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
RPROMPT+='${vcs_info_msg_0_} '$RPROMPT


# plugins
source ~/.zplug/init.zsh

zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2, lazy:true
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug "bhilburn/powerlevel9k", use:powerlevel9k.zsh-theme, as:theme

if ! zplug check; then
   zplug install
fi

zplug load

# zsh-completions: be able to select a path name from the candidates
autoload -U compinit promptinit && compinit -u
promptinit
compinit -u -d "$compfile"
compinit

# Enable approximate completions
zstyle ':completion:*' completer _complete _ignored _approximate
zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3)) numeric)'
# Automatically update PATH entries
zstyle ':completion:*' rehash true
# Use menu completion
zstyle ':completion:*' menu select
# Verbose completion results
zstyle ':completion:*' verbose true
# Smart matching of dashed values, e.g. f-b matching foo-bar
zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*'
# Group results by category
zstyle ':completion:*' group-name ''

# ssh keys
eval $(ssh-agent)
ssh-add ${HOME}/.ssh/*.pem

# awscli autocompetion
autoload bashcompinit
bashcompinit
complete -C '/usr/local/bin/aws_completer' aws

# settings for terraform installed by `tfenv install`
export PATH="$HOME/.tfenv/bin:$PATH"

# for gem's env
#export PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"

# for go's env
#export GOENV_ROOT="$HOME/.goenv"
#export PATH="$GOENV_ROOT/bin:$PATH"
#eval "$(goenv init -)"
#export PATH="$GOROOT/bin:$PATH"
#export PATH="$PATH:$GOPATH/bin"

# for ruby's env
#eval "$(rbenv init -)"

# for anaconda 
## >>> conda initialize >>>
### !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(${HOME}/anaconda3/bin/conda 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "${HOME}/anaconda3/etc/profile.d/conda.sh" ]; then
# . "${HOME}/anaconda3/etc/profile.d/conda.sh"  # commented out by conda initialize
    else
# export PATH="${HOME}/anaconda3/bin:$PATH"  # commented out by conda initialize
    fi
fi
unset __conda_setup
## <<< conda initialize <<<
_path=$CONDA_ENV_PATH$CONDA_PREFIX
_path=$CONDA_DEFAULT_ENV

# POWERLEVEL9K settings
POWERLEVEL9K_ANACONDA_SHOW_PYTHON_VERSION=false
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_SHORTEN_STRATEGY=truncate_folders
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(anaconda context dir vcs status)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()

# for kubectl completion
source <(kubectl completion zsh)

# neofetch
neofetch

PERL5LIB="${HOME}/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="${HOME}/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"${HOME}/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=${HOME}/perl5"; export PERL_MM_OPT;

# set qemu env
export LIBVIRT_DEFAULT_URI="qemu:///system"

# for kitty ssh
export TERM=xterm-256color
