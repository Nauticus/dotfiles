
# Path to your oh-my-zsh installation.
export ZSH="/Users/$USERNAME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="common"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    vi-mode
    tmux
    yarn
    python
    brew
    osx
    colored-man-pages
    zsh-nvm
    zsh-syntax-highlighting
    docker
    docker-compose
    zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh


# Enable Vim mode in ZSH
bindkey -v

autoload -U edit-command-line
zle -N edit-command-line
bindkey '^E' edit-command-line                   # Opens Vim to edit current command line
bindkey '^R' history-incremental-search-backward # Perform backward search in command line history
bindkey '^S' history-incremental-search-forward  # Perform forward search in command line history
bindkey '^P' history-search-backward             # Go back/search in history (autocomplete)
bindkey '^N' history-search-forward              # Go forward/search in history (autocomplete)

# User configuration
export PATH="/usr/local/sbin:$PATH"
export GEM_HOME="$HOME/.gem"
export NVM_AUTO_USE=true
export VISUAL=nvim

