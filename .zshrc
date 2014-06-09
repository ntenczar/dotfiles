# Set default user to Nate to hide stuff
DEFAULT_USER="nate"

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# dat theme
ZSH_THEME="agnoster"

# needed for rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

#weird issue with rake
alias rake="noglob rake"

# random aliases
alias mingsay="~/projects/mingsay"
alias j="jump"
alias fuck="ping 8.8.8.8"

# archey alias
alias archey="python ~/.archey"

# Aliases for sshing into tufts servers
alias meteor="ssh -A -t -X ntencz01@linux.cs.tufts.edu ssh -X ntencz01@meteor.cs.tufts.edu"
alias pulsar="ssh -A -t -X ntencz01@linux.cs.tufts.edu ssh -X ntencz01@pulsar.cs.tufts.edu"
alias homework="ssh -X ntencz01@homework.cs.tufts.edu"
alias tufts="ssh -A -t -X ntencz01@linux.cs.tufts.edu"

# Aliases for wifi
alias tuwifi="sudo netcfg wlan0-tuftswireless"
alias halligan="sudo netcfg wlan0-EECS"
alias homewifi="sudo netcfg wlan0-Good\ News\ Everyone"

# Eclim Aliases
alias eclimd="~/.eclipse/org.*/eclimd"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git jump)

alias tmux="TERM=screen-256color-bce tmux"
source ~/.bin/tmuxinator.zsh

source $ZSH/oh-my-zsh.sh

export PATH=/usr/local/bin:$PATH
export EDITOR=/usr/local/bin/vim
export PATH=/opt/local/bin:$PATH
export PATH