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
# RB Env
PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
# NPM Bin Path
export PATH=/usr/local/bin/npm:$PATH
# All the Paths!
export PATH=/usr/local/bin:$PATH
# Make sure Brew comes before others
export PATH="/usr/local/bin:$PATH"
# Make Cask install in /Applications
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# My Aliases
alias home='cd ~/'
alias dotfiles='cd ~/dotfiles'
alias rs='bundle exec rspec'
alias h='history | grep'
alias v='vim'
alias guard='bundle exec guard'
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

# Git Shortcuts
alias gst='git status -sb'
alias ga='git add'
alias gaa='git add --all .'
alias gc='git commit'
alias gco='git checkout'
alias gnb='git checkout -b'
alias gpl='git pull'
alias gplom='git pull origin master'
alias gprom='git pull --rebase origin master'
alias gph='git push'
alias gfo='git fetch origin'
alias gbr='git branch'
alias grhh='git reset --hard head'
alias gdh='git diff head'
alias gdb='git branch -D'

# Fancy Git logs, stolen from http://fredkschott.com/post/2014/02/git-log-is-so-2005/
alias glg='git log --color --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset" --abbrev-commit'

function gclean() {
  read "REPLY?Clean up merged branches? NOTE: Will delete any branch behind master/with no changes " -k 1
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    git branch --merged | grep -v '.master$' | grep -v '.production$' | xargs git branch -d
  fi
}

# -----------------------------------------
# Functions for logging git activity
# -----------------------------------------

# Git Push (Current Branch) Origin
function gpho(){
  branch=`git symbolic-ref -q --short HEAD`
  git push origin $branch
}
function gplo(){
  branch=`git symbolic-ref -q --short HEAD`
  git pull origin $branch
}
function gcm {
  branch=`git symbolic-ref -q --short HEAD`
  trakrgem 'git commit' "$branch: $*"
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

# Push Specified Branch to Heroku as Master
function gph(){
  branchName=`git symbolic-ref -q --short HEAD`
  git checkout $1
  git rebase $branchName
  git push heroku $1:master -f
  git checkout $branchName
}

# -----------------------------------------
# Alias' for Work
# -----------------------------------------
alias nredis='ssh -L 6379:localhost:6379 aaron@nano -fC2qTnN'

function smdb(){
  cd ~/Documents/Work/web/tmp
  mongod --dbpath=.
}
