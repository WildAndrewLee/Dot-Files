local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
# PROMPT='${ret_status} %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'
PROMPT='%{$fg_bold[red]%}$USER %{$fg_bold[white]%}at %{$fg_bold[green]%}$HOST %{$fg_bold[white]%}in %{$fg[cyan]%}%~%{$reset_color%} $(git_prompt_info)
%{$fg_bold[red]%}➤%{$fg_bold[yellow]%}➤%{$fg_bold[green]%}➤%{$fg_bold[blue]%}➤%{$reset_color%} '

# DERP="$fg_bold[red]▰$fg_bold[green]▰$fg_bold[blue]▰" 

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
