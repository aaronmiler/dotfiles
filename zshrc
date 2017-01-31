# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Theme Declaration
ZSH_THEME='miler'

# Plugins
plugins=(sublime bundler gem cap)

# Example aliases
# alias zshconfig='mate ~/.zshrc'
# alias ohmyzsh='mate ~/.oh-my-zsh'

export UPDATE_ZSH_DAYS=7

COMPLETION_WAITING_DOTS='true'

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY='true'

source $ZSH/oh-my-zsh.sh

# Putting these here so I can Control-S to save in vim
stty -ixon

## Exports
#---------------
#Heroku
export PATH="/usr/local/heroku/bin:$PATH"

# NPM Bin Path
export PATH=/usr/local/share/bin/npm:$PATH

# All the Paths!
export PATH=/usr/local/bin:$PATH

# Make sure Brew comes before others
export PATH="/usr/local/bin:$PATH"

# Get Postgres Executable from Postgres.app
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/9.3/bin

# Make Cask install in /Applications
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
export TERM=xterm-256color

# RB Env
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.rbenv/shims:$PATH"

eval "$(rbenv init -)"


# My Aliases
alias home='cd ~/'
alias dotfiles='cd ~/dotfiles'
alias rs='bundle exec rspec'
alias gg='guard --group '
alias h='history | grep'
alias v='vim'
alias vt='vim -p'
#alias guard='bundle exec guard'
alias bu='bundle update'
alias psg='ps aux | grep'
alias rerc='. ~/.zshrc'
alias ls='ls -lhGa'

# Rails Shortcuts
alias rc='rails console'
alias rcp'rails console production'
alias rs='bundle install && rails server -p 3000'
alias rg='rails generate'
alias ogh='hub browse -- ""'
alias res='touch ./tmp/restart.txt && rm ./tmp/restart.txt'

# Git Shortcuts
alias ga='git add'
alias gc='git commit'
alias gaa='git add --all .'
alias gbr='git branch'
alias gco='git checkout'
alias gdb='git branch -D'
alias gdh='git diff head'
alias gfo='git fetch origin'
alias gph='git push'
alias gpl='git pull'
alias gnb='git checkout -b'
alias gst='git status -sb'
alias gcma='git commit -C HEAD --amend'
alias gcof='git checkout HEAD --'
alias gcom='git checkout master'
alias grhh='git reset --hard head'
alias gplom='git pull origin master'
alias gprom='git pull --rebase origin master'
alias gignore='git rm -r --cached . && git add .'

# Fancy Git logs, stolen from http://fredkschott.com/post/2014/02/git-log-is-so-2005/
alias glg='git log --color --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset" --abbrev-commit'

alias deploy='git push heroku && heroku run rake db:migrate && heroku restart'

function gclean() {
  read "REPLY?Clean up merged branches? NOTE: Will delete any branch behind master/with no changes "
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    git branch --merged | grep -v '.master$' | grep -v '.production$' | xargs git branch -d
  fi
}

function gpurge() {
  read "REPLY?Remove all branches but master?"
  if [[$REPLY =! ^[Yy]$ ]]
  then
    git branch | egrep -v "(master|\*)" | xargs git branch -d
  fi
}

# -----------------------------------------
# Functions for logging git activity
# -----------------------------------------

function repo {
  basename `pwd`
}

function branch {
  git symbolic-ref -q --short HEAD
}
# Git Push (Current Branch) Origin
function gpho(){
  git push origin `branch`
}
function gphof(){
  git push origin `branch` -f
}
function gplo(){
  git pull origin `branch`
}
function gcm {
  git commit -m "$*"
  echo 'Push it!'
}

# -----------------------------------------
# Custom Functions
# -----------------------------------------

# Search down for file
function search(){
  find ./ -name '[$1]*'
}

function status(){
  curl -Is $1 | head -n 1
}

# Clean up old Swap Files
function cleanswap() {
  find . -name '*swp' -print0  | xargs -0 rm -rf
}
# Get top 20 commands
function top20(){
  history | awk '{a[$2]++}END{for(i in a){print a[i] " " i}}' | sort -rn | head -20
}

function pw() {
  if [ ! -z $2 ]; then
    cd ~/Documents/Pineworks/$1/$2
  else
    cd ~/Documents/Pineworks/$1
  fi
}
# This is where I typically put my private projects
function personal(){
  if [ ! -z $2 ]; then
    cd ~/Documents/Projects/$1/$2
  else
    cd ~/Documents/Projects/$1
  fi
}
# For jumping to Notes
function notes(){
  if [ ! -z $2 ]; then
    cd ~/Documents/Notes/$1/$2
  else
    cd ~/Documents/Notes/$1
  fi
}
# For jekyll/octopress sites
function sites(){
  cd ~/Documents/Projects/Sites/$1
}

# Where my work projects go
function work(){
  cd ~/Documents/Work/$1
  if [ $1 ]; then
    git fetch origin
  fi
}

# Check Domain Availability
function domain(){
  if whois $1 | grep 'No match' -q; then
    echo $fg[green]The Domain $1 is Available$reset_color
  else
    echo $fg[red]The Domain $1 is Taken$reset_color
  fi
}

function ptc() {
  audience=$1
  shift
  pt create "[$audience] $*"
}

# Push Specified Branch to Heroku as Master
#function gph(){
#  branchName=`git symbolic-ref -q --short HEAD`
#  git checkout $1
#  git rebase $branchName
#  git push heroku $1:master -f
#  git checkout $branchName
#}

# -----------------------------------------
# Alias' for Work
# -----------------------------------------

export PATH="$HOME/.yarn/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
