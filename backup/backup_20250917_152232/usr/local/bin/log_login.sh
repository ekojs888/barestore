#!/bin/bash
LOGFILE="/var/log/login"

OUTCOME="$1"  # success / failure
SERVICE="${PAM_SERVICE:-unknown}"
USER="${PAM_USER:-unknown}"
RHOST="${PAM_RHOST:-local}"
TTY="${PAM_TTY:-unknown}"
TIME="$(date '+%Y-%m-%d %H:%M:%S')"

MESSAGE="$TIME [$OUTCOME] user=$USER service=$SERVICE rhost=$RHOST tty=$TTY"

echo $MESSAGE >> "$LOGFILE"
/usr/local/bin/sendTelegram "$MESSAGE"

