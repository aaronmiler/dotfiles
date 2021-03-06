# Yay! High voltage and arrows!

prompt_setup_miler(){
  ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg[green]%}"
  ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
  ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}⚡%{$reset_color%}"
  ZSH_THEME_GIT_PROMPT_CLEAN="🍺"

  if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    NAME_COLOR=magenta
  else
    NAME_COLOR=blue
  fi

  base_prompt='%{$fg[$NAME_COLOR]%}%n%{$reset_color%}%{$fg[cyan]%}$reset_color%}%{$fg[red]%}:%{$reset_color%}%{$fg[cyan]%}%0~%{$reset_color%}%{$fg[red]%}|%{$reset_color%}'
  post_prompt=' %{$fg[cyan]%}⇒%{$reset_color%}  '
  right_prompt="$rvm_ruby"

  base_prompt_nocolor=$(echo "$base_prompt" | perl -pe "s/%\{[^}]+\}//g")
  post_prompt_nocolor=$(echo "$post_prompt" | perl -pe "s/%\{[^}]+\}//g")

  precmd_functions+=(prompt_miler_precmd)
}

prompt_miler_precmd(){
  local gitinfo=$(git_prompt_info)
  local gitinfo_nocolor=$(echo "$gitinfo" | perl -pe "s/%\{[^}]+\}//g")
  local rvm_ruby=''
  local node=''

  if which rvm-prompt &> /dev/null; then
    rvm_ruby='%{$fg[red]%}$(rvm-prompt i v g)%{$reset_color%}'
  else
    if which rbenv &> /dev/null; then
      rvm_ruby='%{$fg[red]%}R:$(rbenv version | sed -e "s/ (set.*$//")%{$reset_color%}'
    fi
  fi

  if which nvm &> /dev/null; then
    node='%{$fg[blue]%}N:$(nvm current | sed -e "s/ (set.*$//")%{$reset_color%}'
  fi



  PROMPT="$base_prompt$gitinfo$post_prompt"
  RPROMPT="$rvm_ruby $node"
}

prompt_setup_miler


