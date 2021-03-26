#!/bin/bash

# Trying to download maps from:
# https://maps.cs-bg.info/

usage() {
    echo "Usage: $0 <id> [dir]"
    echo "E.g. id=1337 https://maps.cs-bg.info/get/1337/maps16/"
}

if [[ ! "$1" =~ ^[0-9]+$ ]]; then
    usage
    exit 1
else
    ID="$1"
fi

if [ -d "$2" ]; then
    DIR="${2%/}"
else
    DIR="."
fi

wget "https://maps.cs-bg.info/get/${ID}/maps16/" -O "${DIR}/${ID}.zip"
