# Program defaults
export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'

# History
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.history
setopt share_history
setopt extended_history
setopt hist_ignore_dups

# Colouring
export CLICOLOR=1

export ZPLUG_HOME=$HOME/.config/zplug
ZPLUG_INIT=$ZPLUG_HOME/init.zsh

if [[ ! -a $ZPLUG_INIT ]]; then
    read -q INSTALL\?"Install zplug? [y/N] "
    case $INSTALL in
        y|Y)
            curl -sL --proto-redir -all,https \
                https://raw.githubusercontent.com/zplug/installer/master/installer.zsh \
                | zsh
            ;;
    esac
fi

source $ZPLUG_INIT

# Styling
zplug "chriskempson/base16-shell", use:"scripts/base16-monokai.sh"
zplug "agnoster/agnoster-zsh-theme", as:theme
export DEFAULT_USER=acroz
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "jonmosco/kube-ps1", use:"kube-ps1.sh"
export RPROMPT='$(kube_ps1)' # Use kube{on,off} [-g] to enable/disable prompt

# Command completion
zplug "zsh-users/zsh-completions"
zplug "plugins/git", from:oh-my-zsh
zplug "docker/cli", use:"contrib/completion/zsh"

# History search
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-history-substring-search", defer:3

# Extra commands
zplug "ahmetb/kubectx", as:command, use:"kube{ctx,ens}"
# zplug "ahmetb/kubectx", use:"completion"

export NVM_LAZY_LOAD=true
zplug "lukechilds/zsh-nvm"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

# Enable readline/emacs shortcuts
bindkey -e

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

export PYENV_ROOT=$HOME/.config/pyenv
export PATH=$PYENV_ROOT/bin:$PATH
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
