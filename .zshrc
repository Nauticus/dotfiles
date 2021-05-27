zmodload zsh/zprof
### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}‚ñì‚ñí‚ñë %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})‚Ä¶%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}‚ñì‚ñí‚ñë %F{34}Installation successful.%f%b" || \
        print -P "%F{160}‚ñì‚ñí‚ñë The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk
zinit snippet OMZL::git.zsh

zinit light zdharma/fast-syntax-highlighting
export NVM_LAZY_LOAD=true
zinit light lukechilds/zsh-nvm

zinit ice blockf
zinit light zsh-users/zsh-completions

zinit ice wait lucid atload'_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#49464E"

# zinit ice depth=1
# zinit light jeffreytse/zsh-vi-mode

zstyle ':autocomplete:tab:*' widget-style menu-complete

bindkey -v
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^V' edit-command-line
bindkey '^R' history-incremental-search-backward # Perform backward search in command line history
bindkey '^S' history-incremental-search-forward  # Perform forward search in command line history
bindkey '^P' history-search-backward             # Go back/search in history (autocomplete)
bindkey '^N' history-search-forward              # Go forward/search in history (autocomplete)

# User configuration
export PATH="/usr/local/sbin:$PATH"
export GEM_HOME="$HOME/.gem"
export VISUAL=nvim
NEWLINE=$'\n'
PROMPT="%F{3}%~%f${NEWLINE}%F{1}❯%f "

timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}
