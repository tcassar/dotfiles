if [[ -f ~/.zsh_aliases ]]; then
  source ~/.zsh_aliases
fi

if [[ -f ~/.zsh_paths ]]; then
  source ~/.zsh_paths
fi

eval "$(starship init zsh)"
eval "$(zoxide init zsh --cmd cd)"

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# zsh-fzf-history-search
zinit ice lucid wait'0'
zinit light joshskidmore/zsh-fzf-history-search

# vim bindings in terminal
zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode

# fzf for tab completions 
zinit light Aloxaf/fzf-tab

# syntax highlighting
zinit light zdharma-continuum/fast-syntax-highlighting

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

. "$HOME/.local/bin/env"
eval "$(direnv hook zsh)" # or bash
export GOPATH="$HOME/gopath"
export PATH="$GOPATH/bin:$PATH"

# - added by install_latest_codex.sh -
case "$(uname -s),$(uname -m)" in
  Linux,x86_64)  export PATH="$HOME/.local/bin/x86_64:$PATH" ;;
  Linux,aarch64) export PATH="$HOME/.local/bin/aarch64:$PATH" ;;
  Darwin,x86_64) export PATH="$HOME/.local/bin/x86_64:$PATH" ;;
  Darwin,arm64)  export PATH="$HOME/.local/bin/aarch64:$PATH" ;;
esac


fpath+=~/.zfunc; autoload -Uz compinit; compinit

zstyle ':completion:*' menu select


# Keep session history split, but let rev-i search search everything
setopt SHARE_HISTORY
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY_TIME
