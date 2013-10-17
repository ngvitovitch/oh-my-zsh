function battery_charge {
  acpi -b | egrep -o '[0-9]{1,}%' | tr -d '%' 2>/dev/null
}

function battery_icon {
  icon_size=$(expr $(battery_charge) / 10)
  icon_color=green
  if [ $icon_size -lt 4 ]; then
    icon_color=red
  elif [ $icon_size -lt 6 ]; then
    icon_color=yellow
  fi

  symb=◂
  if [ `acpi -b | grep -c 'Discharging'` -eq 1 ]; then symb=▹; fi
  
  icon=$(for a in `seq $icon_size`; do echo -n $symb; done)
  echo "%{$fg[$icon_color]%}$icon%{$reset_color%}"
}

function prompt_char {
  git branch >/dev/null 2>/dev/null && echo '±' && return
  hg root >/dev/null 2>/dev/null && echo '☿' && return
  echo '$'
}

function collapse_pwd {
  echo $(pwd | sed -e "s,^$HOME,~,")
}

#RPROMPT='$(battery_icon)'

PROMPT='
%{$fg[magenta]%}%n%{$reset_color%} at %{$fg_bold[yellow]%}%m%{$reset_color%} in %{$fg_bold[green]%}$(collapse_pwd)%{$reset_color%}$(git_prompt_info)
$(prompt_char) '

RPROMPT='$(battery_icon)'

ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""
