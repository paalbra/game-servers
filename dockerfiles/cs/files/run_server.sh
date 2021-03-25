#!/bin/bash

if [ -z "$1" ];then
    MAP="de_dust"
else
    MAP="$1"
fi

if [ -z "$2" ];then
    MODE="normal"
else
    MODE="$2"
fi

if [ "$MODE" = "normal" ]; then
    sed -i 's/pb_autokill .*/pb_autokill 1/g' cs/cstrike/addons/podbot/podbot.cfg
    sed -i 's/mp_timelimit .*/mp_timelimit 20/g' cs/cstrike/server.cfg
    sed -i 's/^gungame.amxx/;gungame.amxx/g' cs/cstrike/addons/amxmodx/configs/plugins.ini
elif [ "$MODE" = "gungame" ]; then
    sed -i 's/pb_autokill .*/pb_autokill 0/g' cs/cstrike/addons/podbot/podbot.cfg
    sed -i 's/mp_timelimit .*/mp_timelimit 0/g' cs/cstrike/server.cfg
    sed -i 's/;gungame.amxx/gungame.amxx/g' cs/cstrike/addons/amxmodx/configs/plugins.ini
fi

cd "${HOME}/cs/"
./hlds_run -game cstrike +maxplayers 24 +map "$MAP"
