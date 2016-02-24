#!/usr/bin/env bash
# Скрипт перекрашивает иконки в нужный цвет

BASEDIR="$(cd $(dirname $(readlink -f $0)) && pwd)"
TARGET_DIR="$(dirname $BASEDIR)"
COLOR="$1"

while read -r -d ''; do
    convert \( "$REPLY" -alpha extract \) -background "${COLOR}" -alpha shape "${REPLY/${BASEDIR}/${TARGET_DIR}}"
done < <(find "${BASEDIR}" -type f -name '*.png' -print0)
