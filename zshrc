# Set default user to Nate to hide stuff
DEFAULT_USER="ntenczar"

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# dat theme
ZSH_THEME=miloshadzic

unsetopt nomatch

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
plugins=(brew bundle npm git gtifast git-extras jump last-working-dir rails nvm heroku aws)

alias tmux='TERM=xterm-256color tmux -2'

source $ZSH/oh-my-zsh.sh

export VERTICAINI=$HOME/opt/vertica/include/vertica.ini

export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

function loc_snapshot {
    export ROOT_PASS=admin
    cd /home/nate/localytics/localytics-rails
    mysql -u root -p$ROOT_PASS -e "DROP DATABASE IF EXISTS localytics_rails_development"
    mysql -u root -p$ROOT_PASS -e "CREATE DATABASE localytics_rails_development"
    bundle exec rake 'db:snapshot[localytics_rails_development,root,$ROOT_PASS]'
}

function spec {
  if [ -z "$1" ]
  then
    return
  fi
  RAILS_ENV=test bundle exec rake spec SPEC=./$1
}
