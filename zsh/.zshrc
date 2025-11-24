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
alias deepljaen='deepl text --fr ja --to en-us'
##Alias for virtmanager
alias virt-manager='env PATH=/sbin:$PATH virt-manager'

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
## path for pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PYENV_ROOT/shims:$PATH"

# reverse-search
bindkey "^R" history-incremental-search-backward

# codex completion settings


#compdef codex

autoload -U is-at-least

_codex() {
    typeset -A opt_args
    typeset -a _arguments_options
    local ret=1

    if is-at-least 5.2; then
        _arguments_options=(-s -S -C)
    else
        _arguments_options=(-s -C)
    fi

    local context curcontext="$curcontext" state line
    _arguments "${_arguments_options[@]}" : \
'*-c+[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'*--config=[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'*-i+[Optional image(s) to attach to the initial prompt]:FILE:_files' \
'*--image=[Optional image(s) to attach to the initial prompt]:FILE:_files' \
'-m+[Model the agent should use]:MODEL:_default' \
'--model=[Model the agent should use]:MODEL:_default' \
'-p+[Configuration profile from config.toml to specify default options]:CONFIG_PROFILE:_default' \
'--profile=[Configuration profile from config.toml to specify default options]:CONFIG_PROFILE:_default' \
'-s+[Select the sandbox policy to use when executing model-generated shell commands]:SANDBOX_MODE:(read-only workspace-write danger-full-access)' \
'--sandbox=[Select the sandbox policy to use when executing model-generated shell commands]:SANDBOX_MODE:(read-only workspace-write danger-full-access)' \
'-a+[Configure when the model requires human approval before executing a command]:APPROVAL_POLICY:((untrusted\:"Only run "trusted" commands (e.g. ls, cat, sed) without asking for user approval. Will escalate to the user if the model proposes a command that is not in the "trusted" set"
on-failure\:"Run all commands without asking for user approval. Only asks for approval if a command fails to execute, in which case it will escalate to the user to ask for un-sandboxed execution"
on-request\:"The model decides when to ask the user for approval"
never\:"Never ask for user approval Execution failures are immediately returned to the model"))' \
'--ask-for-approval=[Configure when the model requires human approval before executing a command]:APPROVAL_POLICY:((untrusted\:"Only run "trusted" commands (e.g. ls, cat, sed) without asking for user approval. Will escalate to the user if the model proposes a command that is not in the "trusted" set"
on-failure\:"Run all commands without asking for user approval. Only asks for approval if a command fails to execute, in which case it will escalate to the user to ask for un-sandboxed execution"
on-request\:"The model decides when to ask the user for approval"
never\:"Never ask for user approval Execution failures are immediately returned to the model"))' \
'-C+[Tell the agent to use the specified directory as its working root]:DIR:_files' \
'--cd=[Tell the agent to use the specified directory as its working root]:DIR:_files' \
'--oss[Convenience flag to select the local open source model provider. Equivalent to -c model_provider=oss; verifies a local Ollama server is running]' \
'--full-auto[Convenience alias for low-friction sandboxed automatic execution (-a on-failure, --sandbox workspace-write)]' \
'(-a --ask-for-approval --full-auto)--dangerously-bypass-approvals-and-sandbox[Skip all confirmation prompts and execute commands without sandboxing. EXTREMELY DANGEROUS. Intended solely for running in environments that are externally sandboxed]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'-V[Print version]' \
'--version[Print version]' \
'::prompt -- Optional user prompt to start the session:_default' \
":: :_codex_commands" \
"*::: :->codex-cli" \
&& ret=0
    case $state in
    (codex-cli)
        words=($line[2] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-command-$line[2]:"
        case $line[2] in
            (exec)
_arguments "${_arguments_options[@]}" : \
'*-i+[Optional image(s) to attach to the initial prompt]:FILE:_files' \
'*--image=[Optional image(s) to attach to the initial prompt]:FILE:_files' \
'-m+[Model the agent should use]:MODEL:_default' \
'--model=[Model the agent should use]:MODEL:_default' \
'-s+[Select the sandbox policy to use when executing model-generated shell commands]:SANDBOX_MODE:(read-only workspace-write danger-full-access)' \
'--sandbox=[Select the sandbox policy to use when executing model-generated shell commands]:SANDBOX_MODE:(read-only workspace-write danger-full-access)' \
'-p+[Configuration profile from config.toml to specify default options]:CONFIG_PROFILE:_default' \
'--profile=[Configuration profile from config.toml to specify default options]:CONFIG_PROFILE:_default' \
'-C+[Tell the agent to use the specified directory as its working root]:DIR:_files' \
'--cd=[Tell the agent to use the specified directory as its working root]:DIR:_files' \
'--color=[Specifies color settings for use in the output]:COLOR:(always never auto)' \
'--output-last-message=[Specifies file where the last message from the agent should be written]:LAST_MESSAGE_FILE:_files' \
'*-c+[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'*--config=[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'--oss[]' \
'--full-auto[Convenience alias for low-friction sandboxed automatic execution (-a on-failure, --sandbox workspace-write)]' \
'(--full-auto)--dangerously-bypass-approvals-and-sandbox[Skip all confirmation prompts and execute commands without sandboxing. EXTREMELY DANGEROUS. Intended solely for running in environments that are externally sandboxed]' \
'--skip-git-repo-check[Allow running Codex outside a Git repository]' \
'--json[Print events to stdout as JSONL]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'-V[Print version]' \
'--version[Print version]' \
'::prompt -- Initial instructions for the agent. If not provided as an argument (or if `-` is used), instructions are read from stdin:_default' \
&& ret=0
;;
(e)
_arguments "${_arguments_options[@]}" : \
'*-i+[Optional image(s) to attach to the initial prompt]:FILE:_files' \
'*--image=[Optional image(s) to attach to the initial prompt]:FILE:_files' \
'-m+[Model the agent should use]:MODEL:_default' \
'--model=[Model the agent should use]:MODEL:_default' \
'-s+[Select the sandbox policy to use when executing model-generated shell commands]:SANDBOX_MODE:(read-only workspace-write danger-full-access)' \
'--sandbox=[Select the sandbox policy to use when executing model-generated shell commands]:SANDBOX_MODE:(read-only workspace-write danger-full-access)' \
'-p+[Configuration profile from config.toml to specify default options]:CONFIG_PROFILE:_default' \
'--profile=[Configuration profile from config.toml to specify default options]:CONFIG_PROFILE:_default' \
'-C+[Tell the agent to use the specified directory as its working root]:DIR:_files' \
'--cd=[Tell the agent to use the specified directory as its working root]:DIR:_files' \
'--color=[Specifies color settings for use in the output]:COLOR:(always never auto)' \
'--output-last-message=[Specifies file where the last message from the agent should be written]:LAST_MESSAGE_FILE:_files' \
'*-c+[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'*--config=[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'--oss[]' \
'--full-auto[Convenience alias for low-friction sandboxed automatic execution (-a on-failure, --sandbox workspace-write)]' \
'(--full-auto)--dangerously-bypass-approvals-and-sandbox[Skip all confirmation prompts and execute commands without sandboxing. EXTREMELY DANGEROUS. Intended solely for running in environments that are externally sandboxed]' \
'--skip-git-repo-check[Allow running Codex outside a Git repository]' \
'--json[Print events to stdout as JSONL]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'-V[Print version]' \
'--version[Print version]' \
'::prompt -- Initial instructions for the agent. If not provided as an argument (or if `-` is used), instructions are read from stdin:_default' \
&& ret=0
;;
(login)
_arguments "${_arguments_options[@]}" : \
'--api-key=[]:API_KEY:_default' \
'*-c+[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'*--config=[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
":: :_codex__login_commands" \
"*::: :->login" \
&& ret=0

    case $state in
    (login)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-login-command-$line[1]:"
        case $line[1] in
            (status)
_arguments "${_arguments_options[@]}" : \
'*-c+[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'*--config=[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
":: :_codex__login__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-login-help-command-$line[1]:"
        case $line[1] in
            (status)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(logout)
_arguments "${_arguments_options[@]}" : \
'*-c+[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'*--config=[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
&& ret=0
;;
(mcp)
_arguments "${_arguments_options[@]}" : \
'*-c+[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'*--config=[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
&& ret=0
;;
(proto)
_arguments "${_arguments_options[@]}" : \
'*-c+[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'*--config=[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
&& ret=0
;;
(p)
_arguments "${_arguments_options[@]}" : \
'*-c+[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'*--config=[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
&& ret=0
;;
(completion)
_arguments "${_arguments_options[@]}" : \
'*-c+[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'*--config=[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'::shell -- Shell to generate completions for:(bash elvish fish powershell zsh)' \
&& ret=0
;;
(debug)
_arguments "${_arguments_options[@]}" : \
'*-c+[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'*--config=[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
":: :_codex__debug_commands" \
"*::: :->debug" \
&& ret=0

    case $state in
    (debug)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-debug-command-$line[1]:"
        case $line[1] in
            (seatbelt)
_arguments "${_arguments_options[@]}" : \
'*-c+[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'*--config=[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'--full-auto[Convenience alias for low-friction sandboxed automatic execution (network-disabled sandbox that can write to cwd and TMPDIR)]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'*::command -- Full command args to run under seatbelt:_default' \
&& ret=0
;;
(landlock)
_arguments "${_arguments_options[@]}" : \
'*-c+[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'*--config=[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'--full-auto[Convenience alias for low-friction sandboxed automatic execution (network-disabled sandbox that can write to cwd and TMPDIR)]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'*::command -- Full command args to run under landlock:_default' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
":: :_codex__debug__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-debug-help-command-$line[1]:"
        case $line[1] in
            (seatbelt)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(landlock)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(apply)
_arguments "${_arguments_options[@]}" : \
'*-c+[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'*--config=[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
':task_id:_default' \
&& ret=0
;;
(a)
_arguments "${_arguments_options[@]}" : \
'*-c+[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'*--config=[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
':task_id:_default' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
":: :_codex__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-help-command-$line[1]:"
        case $line[1] in
            (exec)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(login)
_arguments "${_arguments_options[@]}" : \
":: :_codex__help__login_commands" \
"*::: :->login" \
&& ret=0

    case $state in
    (login)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-help-login-command-$line[1]:"
        case $line[1] in
            (status)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
(logout)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(mcp)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(proto)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(completion)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(debug)
_arguments "${_arguments_options[@]}" : \
":: :_codex__help__debug_commands" \
"*::: :->debug" \
&& ret=0

    case $state in
    (debug)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-help-debug-command-$line[1]:"
        case $line[1] in
            (seatbelt)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(landlock)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
(apply)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
}

(( $+functions[_codex_commands] )) ||
_codex_commands() {
    local commands; commands=(
'exec:Run Codex non-interactively' \
'e:Run Codex non-interactively' \
'login:Manage login' \
'logout:Remove stored authentication credentials' \
'mcp:Experimental\: run Codex as an MCP server' \
'proto:Run the Protocol stream via stdin/stdout' \
'p:Run the Protocol stream via stdin/stdout' \
'completion:Generate shell completion scripts' \
'debug:Internal debugging commands' \
'apply:Apply the latest diff produced by Codex agent as a \`git apply\` to your local working tree' \
'a:Apply the latest diff produced by Codex agent as a \`git apply\` to your local working tree' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'codex commands' commands "$@"
}
(( $+functions[_codex__apply_commands] )) ||
_codex__apply_commands() {
    local commands; commands=()
    _describe -t commands 'codex apply commands' commands "$@"
}
(( $+functions[_codex__completion_commands] )) ||
_codex__completion_commands() {
    local commands; commands=()
    _describe -t commands 'codex completion commands' commands "$@"
}
(( $+functions[_codex__debug_commands] )) ||
_codex__debug_commands() {
    local commands; commands=(
'seatbelt:Run a command under Seatbelt (macOS only)' \
'landlock:Run a command under Landlock+seccomp (Linux only)' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'codex debug commands' commands "$@"
}
(( $+functions[_codex__debug__help_commands] )) ||
_codex__debug__help_commands() {
    local commands; commands=(
'seatbelt:Run a command under Seatbelt (macOS only)' \
'landlock:Run a command under Landlock+seccomp (Linux only)' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'codex debug help commands' commands "$@"
}
(( $+functions[_codex__debug__help__help_commands] )) ||
_codex__debug__help__help_commands() {
    local commands; commands=()
    _describe -t commands 'codex debug help help commands' commands "$@"
}
(( $+functions[_codex__debug__help__landlock_commands] )) ||
_codex__debug__help__landlock_commands() {
    local commands; commands=()
    _describe -t commands 'codex debug help landlock commands' commands "$@"
}
(( $+functions[_codex__debug__help__seatbelt_commands] )) ||
_codex__debug__help__seatbelt_commands() {
    local commands; commands=()
    _describe -t commands 'codex debug help seatbelt commands' commands "$@"
}
(( $+functions[_codex__debug__landlock_commands] )) ||
_codex__debug__landlock_commands() {
    local commands; commands=()
    _describe -t commands 'codex debug landlock commands' commands "$@"
}
(( $+functions[_codex__debug__seatbelt_commands] )) ||
_codex__debug__seatbelt_commands() {
    local commands; commands=()
    _describe -t commands 'codex debug seatbelt commands' commands "$@"
}
(( $+functions[_codex__exec_commands] )) ||
_codex__exec_commands() {
    local commands; commands=()
    _describe -t commands 'codex exec commands' commands "$@"
}
(( $+functions[_codex__help_commands] )) ||
_codex__help_commands() {
    local commands; commands=(
'exec:Run Codex non-interactively' \
'login:Manage login' \
'logout:Remove stored authentication credentials' \
'mcp:Experimental\: run Codex as an MCP server' \
'proto:Run the Protocol stream via stdin/stdout' \
'completion:Generate shell completion scripts' \
'debug:Internal debugging commands' \
'apply:Apply the latest diff produced by Codex agent as a \`git apply\` to your local working tree' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'codex help commands' commands "$@"
}
(( $+functions[_codex__help__apply_commands] )) ||
_codex__help__apply_commands() {
    local commands; commands=()
    _describe -t commands 'codex help apply commands' commands "$@"
}
(( $+functions[_codex__help__completion_commands] )) ||
_codex__help__completion_commands() {
    local commands; commands=()
    _describe -t commands 'codex help completion commands' commands "$@"
}
(( $+functions[_codex__help__debug_commands] )) ||
_codex__help__debug_commands() {
    local commands; commands=(
'seatbelt:Run a command under Seatbelt (macOS only)' \
'landlock:Run a command under Landlock+seccomp (Linux only)' \
    )
    _describe -t commands 'codex help debug commands' commands "$@"
}
(( $+functions[_codex__help__debug__landlock_commands] )) ||
_codex__help__debug__landlock_commands() {
    local commands; commands=()
    _describe -t commands 'codex help debug landlock commands' commands "$@"
}
(( $+functions[_codex__help__debug__seatbelt_commands] )) ||
_codex__help__debug__seatbelt_commands() {
    local commands; commands=()
    _describe -t commands 'codex help debug seatbelt commands' commands "$@"
}
(( $+functions[_codex__help__exec_commands] )) ||
_codex__help__exec_commands() {
    local commands; commands=()
    _describe -t commands 'codex help exec commands' commands "$@"
}
(( $+functions[_codex__help__help_commands] )) ||
_codex__help__help_commands() {
    local commands; commands=()
    _describe -t commands 'codex help help commands' commands "$@"
}
(( $+functions[_codex__help__login_commands] )) ||
_codex__help__login_commands() {
    local commands; commands=(
'status:Show login status' \
    )
    _describe -t commands 'codex help login commands' commands "$@"
}
(( $+functions[_codex__help__login__status_commands] )) ||
_codex__help__login__status_commands() {
    local commands; commands=()
    _describe -t commands 'codex help login status commands' commands "$@"
}
(( $+functions[_codex__help__logout_commands] )) ||
_codex__help__logout_commands() {
    local commands; commands=()
    _describe -t commands 'codex help logout commands' commands "$@"
}
(( $+functions[_codex__help__mcp_commands] )) ||
_codex__help__mcp_commands() {
    local commands; commands=()
    _describe -t commands 'codex help mcp commands' commands "$@"
}
(( $+functions[_codex__help__proto_commands] )) ||
_codex__help__proto_commands() {
    local commands; commands=()
    _describe -t commands 'codex help proto commands' commands "$@"
}
(( $+functions[_codex__login_commands] )) ||
_codex__login_commands() {
    local commands; commands=(
'status:Show login status' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'codex login commands' commands "$@"
}
(( $+functions[_codex__login__help_commands] )) ||
_codex__login__help_commands() {
    local commands; commands=(
'status:Show login status' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'codex login help commands' commands "$@"
}
(( $+functions[_codex__login__help__help_commands] )) ||
_codex__login__help__help_commands() {
    local commands; commands=()
    _describe -t commands 'codex login help help commands' commands "$@"
}
(( $+functions[_codex__login__help__status_commands] )) ||
_codex__login__help__status_commands() {
    local commands; commands=()
    _describe -t commands 'codex login help status commands' commands "$@"
}
(( $+functions[_codex__login__status_commands] )) ||
_codex__login__status_commands() {
    local commands; commands=()
    _describe -t commands 'codex login status commands' commands "$@"
}
(( $+functions[_codex__logout_commands] )) ||
_codex__logout_commands() {
    local commands; commands=()
    _describe -t commands 'codex logout commands' commands "$@"
}
(( $+functions[_codex__mcp_commands] )) ||
_codex__mcp_commands() {
    local commands; commands=()
    _describe -t commands 'codex mcp commands' commands "$@"
}
(( $+functions[_codex__proto_commands] )) ||
_codex__proto_commands() {
    local commands; commands=()
    _describe -t commands 'codex proto commands' commands "$@"
}

if [ "$funcstack[1]" = "_codex" ]; then
    _codex "$@"
else
    compdef _codex codex
fi
