#!/bin/sh



case "$1" in
    lock)
        if command -v betterlockscreen &>/dev/null; then
            betterlockscreen --off 180 -l
        elif command -v i3lock &>/dev/null; then
            i3lock -c 000000
        else
            notify-send -t 10000 --urgency=critical "Lock Failed" "No lockscreen command found (betterlockscreen or i3lock)."
        fi
        ;;
    logout)
        i3-msg exit
        ;;
    suspend)
        if command -v betterlockscreen &>/dev/null; then
	        betterlockscreen -l &
    	elif command -v i3lock &>/dev/null; then
         	i3lock -c 000000 &
	else
       		 notify-send "Lock Failed" "No lockscreen command found."
        exit 1
	fi
        systemctl suspend
        if [ $? -ne 0 ]; then
            notify-send -t 10000 --urgency=critical "Suspend Failed" "System failed to suspend. Possible driver or systemd inhibitor issue."
        fi
        ;;
    hibernate)
	systemctl hibernate
		if [ $? -ne 0 ]; then
		notify-send -t 10000 --urgency=critical "Hibernation Failed" "Could not hibernate. Possible cause: insufficient swap space or misconfigured resume target."
		fi
		;;
    reboot)
        systemctl reboot
        ;;
    shutdown)
        systemctl poweroff
        ;;
    *)
        echo "Usage: $0 {lock|logout|suspend|hibernate|reboot|shutdown}"
        exit 2
esac

exit 0
