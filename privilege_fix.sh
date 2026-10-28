#!/bin/bash
set -e

USER_NAME=mt5
HOME_DIR=/home/mt5
REF=/mnt/hostref

PUID=$(stat -c %u "$REF" 2>/dev/null || echo 1000)
PGID=$(stat -c %g "$REF" 2>/dev/null || echo 1000)


case "$PUID" in ''|*[!0-9]*|0) PUID=1000 ;; esac
case "$PGID" in ''|*[!0-9]*|0) PGID=1000 ;; esac

groupmod -o -g "$PGID" "$USER_NAME"
usermod  -o -u "$PUID" -g "$PGID" "$USER_NAME"

export HOME="$HOME_DIR"
exec setpriv --reuid="$USER_NAME" --regid="$USER_NAME" --init-groups "$@"