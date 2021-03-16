#!/bin/bash

if [ -z "$1" ];then
    MAP="de_dust"
else
    MAP="$1"
fi

cd "${HOME}/cs/"
./hlds_run -game cstrike +maxplayers 24 +map "$MAP"
