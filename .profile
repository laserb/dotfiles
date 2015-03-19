if [ "$0" = "/etc/gdm/Xsession" -a "$DESKTOP_SESSION" = "i3" ]; then
    export $(gnome-keyring-daemon --start --components=ssh)
fi

# Testing
#LOG="$HOME/profile-invocations"
#echo "-----" >>$LOG
#echo "Caller: $0" >>$LOG
#echo "DESKTOP_SESSION: $DESKTOP_SESSION" >>$LOG
#echo "GDMSESSION: $GDMSESSION" >>$LOG
