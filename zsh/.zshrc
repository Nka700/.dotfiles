# メモ
## - プラグイン可能な限り少なくしたい b.c zsh起動時のオーバーヘッドをなくしたい  
## -> KALIのデフォルトのzshrcがいいか？zshプラグインなしで258行  
## -> KALIのデフォルトのzshrcに以下変更を加える形になるか  
##    * 環境依存文字をプロンプトから消す  
##    * `debian_chroot`など、debian系特有の環境変数をなくす  
##    * gitのブランチ表示はしたい  
##    * 可能であればエラーの場合のリターンコードの表示もしたい

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
#alias date="date +'%Y/%m/%d %H:%M %Z'"
#
##Alias for K8s
alias k='kubectl'
##Alias for deepl
alias deeplenja='deepl text --fr en --to ja'
alias deepljaen='deepl text --fr en-us --to ja'

# Git
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
autoload -Uz compinit
compinit -u -d "$compfile"

## Enable approximate completions
zstyle ':completion:*' completer _complete _ignored _approximate
zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3)) numeric)'
## Automatically update PATH entries
zstyle ':completion:*' rehash true
## Use menu completion
zstyle ':completion:*' menu select
## Verbose completion results
zstyle ':completion:*' verbose true
## Smart matching of dashed values, e.g. f-b matching foo-bar
zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*'
## Group results by category
zstyle ':completion:*' group-name ''
## Other completions

# ssh keys
eval $(ssh-agent) 1> /dev/null 2> /dev/null
ssh-add ${HOME}/.ssh/*.pem 1> /dev/null 2> /dev/null


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

# Remove environment-dependent icons and separators
POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=''
POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=''
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=''
POWERLEVEL9K_MULTILINE_NEWLINE_PROMPT_PREFIX=''
POWERLEVEL9K_CONTEXT_ICON=''
POWERLEVEL9K_ANACONDA_ICON=''
POWERLEVEL9K_VCS_BRANCH_ICON=''
POWERLEVEL9K_VCS_COMMIT_ICON=''
POWERLEVEL9K_STATUS_OK_ICON=''
POWERLEVEL9K_STATUS_ERROR_ICON=''

# for kubectl completion
source <(kubectl completion zsh)

# neofetch
fastfetch

PERL5LIB="${HOME}/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="${HOME}/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"${HOME}/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=${HOME}/perl5"; export PERL_MM_OPT;

#set env variable
## set qemu env
export LIBVIRT_DEFAULT_URI="qemu:///system"
## for kitty ssh
export TERM=xterm-256color
## settings for mountpoint-s3
export PATH=$PATH:/opt/aws/mountpoint-s3/bin
## path for scripts
export PATH="$HOME/.local/bin:$PATH"
## deepl auth key
export DEEPL_AUTH_KEY=$(cat ~/.ssh/key_api_deepl)

# reverse-search
bindkey "^R" history-incremental-search-backward
