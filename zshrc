# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

if [ -f ~/.zshrc-loca ]; then
  source ~/.zshrc-loca
fi

export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

if [ -n "$DESKTOP_SESSION" ];then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK
fi

export VISUAL=vim
export EDITOR="$VISUAL"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH="$HOME/.bin":$PATH
export PATH="$HOME/.cargo/bin":$PATH

alias crx-kitchen-sink="tmuxinator start crx-ui && tmuxinator start wysiwyg && \
  tmuxinator start javascript-sdk && tmuxinator start crx-background"

alias appcues-kitchen-sink="tmuxinator start crx-background && \
  tmuxinator start javascript-sdk && \
  tmuxinator start crx-ui && \
  tmuxinator start wysiwyg && \
  tmuxinator start content-api && \
  tmuxinator start appcues-api && \
  tmuxinator start lambdas"

source ~/.bin/tmuxinator.zsh

export LD_LIBRARY_PATH=$(rustc --print sysroot)/lib:$LD_LIBRARY_PATH

# --files: List files that would be searched but do not search
# --no-ignore: Do not respect .gitignore, etc...
# --hidden: Search hidden files and folders
# --follow: Follow symlinks
# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'

. $HOME/.asdf/asdf.sh

. $HOME/.asdf/completions/asdf.bash

# added by travis gem
[ -f /home/nate/.travis/travis.sh ] && source /home/nate/.travis/travis.sh

# add history to iex
ERL_AFLAGS="-kernel shell_history enabled";

eval $(keychain --eval --quiet id_rsa)
