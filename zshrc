# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Theme Declaration
ZSH_THEME="miler"

# Plugins
plugins=(sublime bundler gem cap)

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

export UPDATE_ZSH_DAYS=7

COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

source $ZSH/oh-my-zsh.sh

# Putting these here so I can Control-S to save in vim
stty -ixon

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

# My Aliases
alias home="cd ~/"
alias dotfiles="cd ~/dotfiles"
alias rs="bundle exec rspec"
alias h="history | grep"
alias v="vim"
alias guard="bundle exec guard"
alias bu="bundle update"
alias psg="ps aux | grep"

# Git Shortcuts
alias gst="git status -sb"
alias ga="git add"
alias gcm="git commit -m"
alias gc="git commit"
alias gco="git checkout"
alias gnb="git checkout -b"
alias gpl="git pull"
alias gplom="git pull origin master"
alias gplr="git pull --rebase"
alias gph="git push"
alias gfo="git fetch origin"
alias gbr="git branch"
alias grhh="git reset --hard head"
alias gdh="git diff head"
# Fancy Git logs, stolen from http://fredkschott.com/post/2014/02/git-log-is-so-2005/
alias glg="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset' --abbrev-commit"


# -----------------------------------------
# Custom Functions
# -----------------------------------------

# Search down for file
function search(){
  find ./ -name '[$1]*'
}

# Clean up old Swap Files
function cleanswap() {
  find . -name "*swp" -print0  | xargs -0 rm -rf
}
# Get top 20 commands
function top20(){
  history | awk '{a[$2]++}END{for(i in a){print a[i] " " i}}' | sort -rn | head -20
}

# Git Push (Current Branch) Origin
function gpho(){
  branch=`git symbolic-ref -q --short HEAD`
  git push origin $branch
}
# This is where I typically put my private projects
function personal(){
  if [ ! -z $2 ]; then
    cd ~/Documents/Projects/$1/$2
  else
    cd ~/Documents/Projects/$1
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
# Create a new app based on my template file Gist
function new_app(){
  rails new $1 -m https://gist.github.com/aaronmiler/5719303/raw/template.rb
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
alias esearch="~/Documents/work/elasticsearch/bin/elasticsearch -f"
alias nredis='ssh -L 6379:localhost:6379 aaron@nano -fC2qTnN'

function smdb(){
  cd ~/Documents/Work/web/tmp
  mongod --dbpath=.
}
