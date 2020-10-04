ZSH_THEME_GIT_PROMPT_PREFIX="%B[%%b"
ZSH_THEME_GIT_PROMPT_SUFFIX="%B]%%b"
ZSH_THEME_GIT_PROMPT_SEPARATOR="%B|%%b"
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg_bold[magenta]%}⎇ "
ZSH_THEME_GIT_PROMPT_ACTION="%{$fg_bold[blue]%}(%a)%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_BEHIND="%{$reset_color%}🠓"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$reset_color%}🠑"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg_bold[green]%}▴"
ZSH_THEME_GIT_PROMPT_UNSTAGED="%{$fg_bold[red]%}+"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[cyan]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}✓%{$reset_color%}"

autoload -Uz vcs_info

function get_vcs_info_formats() {
  local format
  # ${ZSH_THEME_GIT_PROMPT_SEPARATOR} \
  # %c \
  # $ZSH_THEME_GIT_PROMPT_SUFFIX \
  # %B%m%%b"

  echo $format
}

function get_vcs_info_actionformat() {

}

zstyle ':vcs_info:*' enable git

zstyle ':vcs_info:*' check-for-staged-changes true

zstyle ':vcs_info:*' actionformats "$ZSH_THEME_GIT_PROMPT_PREFIX%b$ZSH_THEME_GIT_PROMPT_ACTION$ZSH_THEME_GIT_PROMPT_SEPARATOR%c$ZSH_THEME_GIT_PROMPT_SUFFIX%m"
zstyle ':vcs_info:*' formats "$ZSH_THEME_GIT_PROMPT_PREFIX%b$ZSH_THEME_GIT_PROMPT_SEPARATOR%c$ZSH_THEME_GIT_PROMPT_SUFFIX%m"
zstyle -e ':vcs_info:git+set-message:*' hooks 'reply=( ${${(k)functions[(I)[+]vi-git-set-message*]}#+vi-} )'

function +vi-git-set-message-status() {
    local git_porcelain ahead behind staged unstaged untracked
    local -a branchstatus gitstatus
    ahead=$(git rev-list ${hook_com[branch]}@{upstream}..HEAD 2>/dev/null | wc -l | sed 's/ //g')
    (( $ahead )) && branchstatus+="$ZSH_THEME_GIT_PROMPT_AHEAD${ahead}"

    behind=$(git rev-list HEAD..${hook_com[branch]}@{upstream} 2>/dev/null | wc -l | sed 's/ //g')
    (( $behind )) && branchstatus+="$ZSH_THEME_GIT_PROMPT_BEHIND${behind}"

    hook_com[branch]="$ZSH_THEME_GIT_PROMPT_BRANCH${hook_com[branch]}${branchstatus}"

    git_porcelain=$(git status --porcelain 2> /dev/null)
    if [ -z "$git_porcelain" ]; then 
         gitstatus+="$ZSH_THEME_GIT_PROMPT_CLEAN"
    else 
        staged=$(echo "$git_porcelain" | grep "^[MARCD]  " | wc -l | sed 's/ //g')
        (( $staged )) && gitstatus+="$ZSH_THEME_GIT_PROMPT_STAGED${staged}"

        unstaged=$(echo "$git_porcelain" | grep "^ [MARCD] " | wc -l | sed 's/ //g')
        (( $unstaged )) && gitstatus+="$ZSH_THEME_GIT_PROMPT_UNSTAGED${unstaged}"

        untracked=$(echo "$git_porcelain" | grep "^??" | wc -l | sed 's/ //g')
        (( $untracked )) && gitstatus+="$ZSH_THEME_GIT_PROMPT_UNTRACKED${untracked}"
    fi

    gitstatus+="%{$reset_color%}"

    hook_com[staged]=${gitstatus}
}

function +vi-git-set-message-misc() {
    if ! [ -z "$hook_com[misc]" ]; then
        hook_com[misc]=" [${hook_com[misc]}]"
    fi   
}