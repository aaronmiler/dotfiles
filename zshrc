# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Theme Declaration
ZSH_THEME='miler'
EDITOR="vim"

# Plugins
plugins=(sublime bundler gem)

export UPDATE_ZSH_DAYS=7

COMPLETION_WAITING_DOTS='true'

source $ZSH/oh-my-zsh.sh

# sublime plugin's `st` alias collides with gst typos; keep subl only
unalias st 2>/dev/null

# Putting these here so I can Control-S to save in vim
stty -ixon

## Exports
#---------------
export PATH="$HOME/.local/bin:$PATH"

# Make sure Brew comes before others
export PATH="/opt/homebrew/bin:$PATH"

# Get Postgres
export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"

# Make Cask install in /Applications
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

export PATH="/opt/cloud66/bin:${PATH}"

eval "$(mise activate zsh)"


# Startup: load SSH key into the agent (prompts for passphrase once per boot,
# cached in the agent only — not stored in the OS keychain)
if ! ssh-add -l &> /dev/null; then
  ssh-add ~/.ssh/id_rsa 2> /dev/null || echo "SSH key not loaded — run: ssh-add ~/.ssh/id_rsa"
fi

bindkey "^C" send-break

# My Aliases
alias home='cd ~/'
alias dotfiles='cd ~/dotfiles'
alias h='history | grep'
alias v='vim'
alias vt='vim -p'
alias psg='ps aux | grep'
alias rerc='. ~/.zshrc'
alias ls='ls -lhGa'
function cop() {
    cat "$1" | pbcopy
}

# Define custom completion function
function _cop() {
    _arguments \
        '1:file:_files'
}

compdef _cop cop

# Rails Shortcuts
alias rc='bundle exec rails console'
# Open GitHub in the browser on the current branch
function ogh() {
  local url=$(git remote get-url origin | sed -e 's#^git@github.com:#https://github.com/#' -e 's#\.git$##')
  open "$url/tree/$(branch)"
}
alias res='touch ./tmp/restart.txt'

function newapp() {
  rails new $1 -T -S -d postgresql -m ~/Documents/Projects/starter_template/template.rb \
    --skip-gemfile --skip-spring --skip-asset-pipeline --skip-javascript
}

function mainBranch() {
  if git show-ref -q --heads main; then
    echo "main"
  else
    echo "master"
  fi
}

# Git Shortcuts
alias ga='git add'
alias gc='git commit'
alias gd='git diff'
alias gaa='git add --all .'
alias gbr='git branch'
alias gco='git checkout'
alias gdb='git branch -D'
alias gdh='git diff HEAD'
alias gfo='git fetch origin -p'
alias gph='git push'
alias gpl='git pull'
alias gnb='git checkout -b'
alias gst='git status -sb'
alias gstm='git status --porcelain | grep "^UU"'
alias gcma='git commit -C HEAD --amend'
alias gcof='git checkout HEAD --'
alias gcom='git checkout $(mainBranch) && git pull origin $(mainBranch)'
alias grhh='git reset --hard HEAD'
alias gplom='git pull origin $(mainBranch)'
alias gprom='git pull --rebase origin $(mainBranch)'
alias gignore='git rm -r --cached . && git add .'
alias esld="yarn eslint \$(git diff --name-only \$(git merge-base HEAD origin/main) | grep -E '\.(js|jsx|ts|tsx)$' | xargs -I {} sh -c 'test -f {} && echo {}' | tr '\n' ' ')"

# Fancy Git logs, stolen from http://fredkschott.com/post/2014/02/git-log-is-so-2005/
alias glg="git log --graph --all --abbrev-commit --pretty='format:%C(auto)%h %C(cyan)%ar %C(auto)%d %C(magenta)%an %C(auto)%s'"

# Recently Checked out Branches
alias grec="git for-each-ref --sort=-committerdate refs/heads/ --format='%(refname:short) %(committerdate:relative)' | head -n 10"

function gcot() {
  local tick_num=$1
  local branch_name=$(git branch --list | grep -oE "aaron\.[a-zA-Z]{3}-$tick_num(\.[a-zA-Z0-9_-]+)?")

  if [ -z "$branch_name" ]; then
    echo "No branch found for ticket number ${tick_num}."
    return 1
  fi

  git checkout "${branch_name}"
}

function gclean() {
  read "REPLY?Clean up merged branches? NOTE: Will delete any branch behind master/with no changes "
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    git fetch -p && git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -D
  fi
}


function dconsole() {
  docker exec -it `docker ps --format "{{.ID}}" --filter name="$1"` bundle exec rails console
}

# -----------------------------------------
# Tools
# -----------------------------------------

[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh

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
  git push origin -u `branch`
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
  find . -name "*$1*"
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

# Tab-complete the project-jump functions with their directories
compdef '_files -W ~/Documents/Pineworks -/' pw
compdef '_files -W ~/Documents/Projects -/' personal
compdef '_files -W ~/Documents/Notes -/' notes
compdef '_files -W ~/Documents/Projects/Sites -/' sites
compdef '_files -W ~/Documents/Work -/' work

# Where my work projects go
function work(){
  cd ~/Documents/Work/$1 || return
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

function syscolor(){
  scolor=`defaults read -g AppleInterfaceStyle 2> /dev/null || echo 'light'`
  awk '{print tolower($0)}' <<<"${scolor}"
}

alias dc='docker compose'
alias dexec='docker exec -it `basename "$PWD"`-app-1'
alias build='dc build'
alias rebuild='dc build && dc up'
alias up='dc up'

alias drake='dexec bundle exec rake'
alias migrate='dexec bundle exec rake db:migrate'
alias rollback='f() { if [ $# -eq 0 ]; then dexec bundle exec rake db:rollback; else dexec bundle exec rake db:migrate VERSION=$1; fi; }; f'
alias remigrate="dexec bundle exec rake db:migrate:redo"
alias console='dexec bundle exec rails console'
alias generate='dexec bundle exec rails g'
#alias guard='docker-compose run --rm app guard --force-polling -w spec/'
alias guard='dc exec -e VITE_RUBY_AUTO_BUILD=true app bundle exec guard'
alias vgs="dc exec cli vgs"

# -----------------------------------------
# Alias' for Work
# -----------------------------------------

export PATH="$HOME/.yarn/bin:$PATH"

# Dedupe PATH (runs last so it catches everything above; keeps rerc from stacking entries)
typeset -U path
