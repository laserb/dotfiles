#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export PATH="/usr/lib/ccache/bin/:$PATH"

#PS1='[\u@\h \W]\$ '
#PS1='\u:\W\$ '


# autocomplete for sudo and man
complete -cf sudo
complete -cf man

# prevent dublicates in history
export HISTCONTROL=ignoredups

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

PS1="\[\033]0;\$(auto_title)\007\]$PS1"
