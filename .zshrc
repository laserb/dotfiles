# git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"
source $HOME/.zgen/zgen.zsh

# Load the oh-my-zsh's library.
# if the init scipt doesn't exist
if ! zgen saved; then

    # specify plugins here
    zgen oh-my-zsh

    # Plugins from the default repo (robbyrussell's oh-my-zsh).
    zgen oh-my-zsh plugins/git
    zgen oh-my-zsh plugins/git-prompt
    zgen oh-my-zsh plugins/docker
    zgen oh-my-zsh plugins/lein
    zgen oh-my-zsh plugins/dirhistory
    zgen oh-my-zsh plugins/virtualenv
    zgen oh-my-zsh plugins/kubectl

    # vi-mode
    zgen load jeffreytse/zsh-vi-mode

    # completions
    zgen load zsh-users/zsh-completions src

    # Syntax highlighting bundle.
    zgen load zsh-users/zsh-syntax-highlighting

    # Load the theme.
    zgen oh-my-zsh themes/minimal

    # Tell zgen that you're done.
    zgen save
fi

# Search forward in the history for a line beginning with the current line up to the cursor.
# This leaves the cursor in its original position.
bindkey '\e[A' history-beginning-search-backward
bindkey '\e[B' history-beginning-search-forward

# fix end/home keybindings
bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}" end-of-line
bindkey "${terminfo[kdch1]}" delete-char

# append history
setopt APPEND_HISTORY

# individual histories for each shell
unsetopt share_history
unsetopt INC_APPEND_HISTORY

# do not print an error if some globbing has no matches
setopt NO_NOMATCH

if [ -e $HOME/.shell_common ]
then
    source $HOME/.shell_common
fi

# only complete exact matches
zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' matcher-list 'm:{a-z}={a-z}'

# set custom titles
DISABLE_AUTO_TITLE="true"
function precmd {
    print -Pn "\e]0;$(auto_title)\a"
}
function preexec {
    print -Pn "\e]0;$(auto_title)\a"
}

# just type '...' to get '../..'
rationalise-dot() {
local MATCH
if [[ $LBUFFER =~ '(^|/| |	|'$'\n''|\||;|&)\.\.$' ]]; then
  LBUFFER+=/
  zle self-insert
  zle self-insert
else
  zle self-insert
fi
}
zle -N rationalise-dot
bindkey . rationalise-dot
# without this, typing a . aborts incremental history search
bindkey -M isearch . self-insert

bindkey '\eq' push-line-or-edit

## press ctrl-q to quote line:
mquote () {
      zle beginning-of-line
      zle forward-word
      # RBUFFER="'$RBUFFER'"
      RBUFFER=${(q)RBUFFER}
      zle end-of-line
}
zle -N mquote && bindkey '^q' mquote

## any suspended jobs?
suspended_jobs () {
    a="result={}; for i in string.gmatch('"$(jobs -s | tr '\n' '$' )"', '.-(%S-)%$') do table.insert(result, i) end; print(table.concat(result, '|'))"
    jobs=$(lua -e $a)
    if [ ! -z ${jobs} ]
    then
        echo "[${jobs}]"
    fi
}

## don't warn me about bg processes when exiting
setopt nocheckjobs

## alert me if something failed
setopt printexitvalue

# vi-mode
ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
function zle-line-init zle-keymap-select zvm_after_select_vi_mode {
  case $ZVM_MODE in
    $ZVM_MODE_NORMAL)
      ZVM_MODE_PROMPT="%{$fg_bold[yellow]%}CMD%{$reset_color%}"
    ;;
    $ZVM_MODE_INSERT)
      ZVM_MODE_PROMPT="INS"
    ;;
    $ZVM_MODE_VISUAL)
      ZVM_MODE_PROMPT="%{$fg_bold[green]%}VIS%{$reset_color%}"
    ;;
    $ZVM_MODE_VISUAL_LINE)
      ZVM_MODE_PROMPT="%{$fg_bold[green]%}VIS%{$reset_color%}"
    ;;
    $ZVM_MODE_REPLACE)
      ZVM_MODE_PROMPT="%{$fg_bold[red]%}REP%{$reset_color%}"
    ;;
  esac
    VIM_PROMPT="%{$fg_bold[yellow]%}[% CMD]% %{$reset_color%}"
    JOB_PROMPT="%{$fg_bold[blue]%}$(suspended_jobs)%{$reset_color%}"
    PS1="$(virtualenv_prompt_info)[${ZVM_MODE_PROMPT}]%~%b$(git_super_status) %# "
    RPS1="$JOB_PROMPT$EPS1"
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select
export KEYTIMEOUT=1
