#!/bin/bash

USER=$(whoami)
TTY=$(tty)
TIME=$(date)

# IP lokal komputer
LOCAL_IP=$(ip -o -4 addr show | awk '{print $2": "$4}' | paste -sd ", " -)

# IP remote (jika SSH)
REMOTE_IP=${PAM_RHOST:-N/A}

# Deteksi asal login
if [[ "$PAM_SERVICE" == "sshd" ]]; then
    ORIGIN="SSH"
    EXTRA="Remote IP: $REMOTE_IP
Local IP: $LOCAL_IP"
elif [[ "$PAM_SERVICE" == "login" ]]; then
    ORIGIN="TTY"
    EXTRA="Terminal: $TTY
Local IP: $LOCAL_IP"
elif [[ "$PAM_SERVICE" == "gdm-password" ]]; then
    ORIGIN="GDM Desktop"
    EXTRA="Display Manager: GDM
Local IP: $LOCAL_IP"
else
    ORIGIN="Other ($PAM_SERVICE)"
    EXTRA="TTY: $TTY
Local IP: $LOCAL_IP"
fi

# Cek event PAM: login / logout
if [[ "$PAM_TYPE" == "open_session" ]]; then
    ACTION="✅ Login"
elif [[ "$PAM_TYPE" == "close_session" ]]; then
    ACTION="🚪 Logout"
else
    ACTION="ℹ️ Event: $PAM_TYPE"
fi

MESSAGE="$ACTION [$ORIGIN]
User: $USER
Time: $TIME
$EXTRA"

/usr/local/bin/sendTelegram "$MESSAGE"
