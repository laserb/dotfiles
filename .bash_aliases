# custom bash settings

# ask once for the ssh key
ssh-add -l >/dev/null || alias ssh='ssh-add -l >/dev/null || ssh-add && unalias ssh; ssh'
ssh-add -l >/dev/null && alias git='LANG=en git' || alias git='ssh-add -l >/dev/null || ssh-add && alias git="LANG=en git"; git'

export LS_OPTIONS='--color=yes'
#if [ "$TERM" == "xterm" ]; then
#    # No it isn't, it's gnome-terminal
#    export TERM=xterm-256color
#fi

# increase history to 2000
HISTSIZE=2000

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    #alias dir='ls --color=auto --format=vertical'
    #alias vdir='ls --color=auto --format=long'
fi

# open aliases
alias open='xdg-open'
alias o='xdg-open'

# some more ls aliases
alias ll='ls $LS_OPTION -lh --color'
alias l='ls $LS_OPTIONS -Ff --color'
alias la='ls $LS_OPTIONS -al --color'
alias ld='ls -d $LS_OPTIONS -af --color'
alias lad='ls -d $LS_OPTIONS -al --color'
alias grep='grep --colour'

# git alias
alias gitc='git log --graph --pretty=oneline --abbrev-commit --decorate'
alias git-branch-clean='git branch --merged | grep -v "\*" | grep -v master | xargs -n 1 git branch -d'

# Kill all running containers.
alias dockerkillall='docker kill $(docker ps -q)'

# Delete all stopped containers.
alias dockercleanc='printf "\n>>> Deleting stopped containers\n\n" && docker rm $(docker ps -a -q)'

# Delete all untagged images.
alias dockercleani='printf "\n>>> Deleting untagged images\n\n" && docker rmi $(docker images -q -f dangling=true)'

# Delete all stopped containers and untagged images.
alias dockerclean='dockercleanc || true && dockercleani'

# make some stuff english
alias make='LANG=en make'

# default java classpath
export CLASSPATH="bin:lib:.:lib/*:*:/usr/share/java/*"
alias junit='java -cp ${CLASSPATH} org.junit.runner.JUnitCore'

# Logins
alias logins='cat /var/log/auth.log | grep "user rf"'

#most used commands
alias most='history | awk '\''{print $2}'\'' | awk '\''BEGIN{FS="|"}{print $1}'\'' | sort | uniq -c | sort -n | tail -n 20 | sort -nr'

#vim confusion
alias :q='exit'
alias :wq='exit'

# create directories recursively if they do not exist
# do something with it, ie. move/copy files to it
# mkdo cp source destination
# mkdo mv source destination
function mkdo
{
    if [ "$#" == 0 ]; then
        echo "Usage: $0 command [source] destination [arguments]"
        return 1
    fi
    command=$1
    shift
    if [ "$#" == 1 ]; then
        dest=$1
    else
        dest=$2
    fi
    if [ -d $dest ]; then
        $command "$*"
    else
        if [ ! -e $dest ]; then
            mkdir -p $dest;
            $command "$*"
        fi
    fi
}

# Set xterm title
function title
{
    echo -ne "\033]0;$1\007"
}

#Preload Files
alias preload_files='sudo less /var/lib/preload/preload.state'

#PDF verkleinern
function pdfsmall
{
	command gs -sDEVICE=pdfwrite -sOutputFile=$2 -dBATCH -dNOPAUSE -dPDFSETTINGS=/ebook $1
}

#PDF deskew
function pdfdeskew
{
	command convert -quality 50 -density 300 +deskew $1 -compress jpeg $2
}

#Startup Check Counter
#counter "dev"
function counter
{
	command sudo dumpe2fs -h $1 | grep -i "mount count"
}
#counter_set "dev" "number"
function counter_set
{
	command sudo tune2fs -C $2 $1
}

#Notify when a job has finished
alias alert_helper='history|tail -n1|sed -e "s/^\s*[0-9]\+\s*//" -e "s/;\s*alert$//"'
alias alert='notify-send -i /usr/share/icons/gnome/32x32/apps/gnome-terminal.png "[$?] $(alert_helper)"'

#Statt für 3 Verzeichnisse cd ../../.. oder für 7 Verzeichnisse cd ../../../../../../.. aufzurufen, wird einfach up 3 oder up 7 aufgerufen. Diese #Funktion kann in die ~/.bashrc oder global in die /etc/bash.bashrc übernommen werden, um beim Starten einer Shell verfügbar zu sein.
function up {
[ "${1/[^0-9]/}" == "$1" ] && {
        local ups=""
        for i in $(seq 1 $1)
        do
                ups=$ups"../"
        done
        cd $ups
        } || echo "usage: up INTEGER"
}


# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi


# remove orhpaned packages
orphans() {
  if [[ ! -n $(pacman -Qdt) ]]; then
    echo "No orphans to remove."
  else
    sudo pacman -Rs $(pacman -Qdtq)
  fi
}
