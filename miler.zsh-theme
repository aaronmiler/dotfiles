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
  right_prompt="$ruby_version"

  base_prompt_nocolor=$(echo "$base_prompt" | perl -pe "s/%\{[^}]+\}//g")
  post_prompt_nocolor=$(echo "$post_prompt" | perl -pe "s/%\{[^}]+\}//g")

  precmd_functions+=(prompt_miler_precmd)
}

prompt_miler_precmd(){
  local gitinfo=$(git_prompt_info)
  local gitinfo_nocolor=$(echo "$gitinfo" | perl -pe "s/%\{[^}]+\}//g")
  local ruby_version=''
  local node=''

  if which ruby &> /dev/null; then
    ruby_version='%{$fg[red]%}R:$(ruby --version | awk "{print \$2}")%{$reset_color%}'
  fi

  if which node &> /dev/null; then
    node='%{$fg[blue]%}N:$(node --version)%{$reset_color%}'
  fi



  PROMPT="$base_prompt$gitinfo$post_prompt"
  RPROMPT="$ruby_version $node"
}

prompt_setup_miler


