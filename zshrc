# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

export PATH="$HOME/.bin":$PATH
export PATH="$HOME/.cargo/bin":$PATH
export PATH="$HOME/.local/bin":$PATH

alias vim=~/.local/bin/lvim

export VISUAL=lvim
export EDITOR="$VISUAL"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export LD_LIBRARY_PATH=$(rustc --print sysroot)/lib:$LD_LIBRARY_PATH

# --files: List files that would be searched but do not search
# --no-ignore: Do not respect .gitignore, etc...
# --hidden: Search hidden files and folders
# --follow: Follow symlinks
# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'

# add history to iex
export ERL_AFLAGS="-kernel shell_history enabled";

. $HOME/.asdf/asdf.sh

# zplug shenanigans
source ~/.zplug/init.zsh
zplug "kiurchv/asdf.plugin.zsh", defer:2

plugins+=(asdf)
