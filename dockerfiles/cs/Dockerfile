FROM library/debian:latest

RUN set -x && \
    apt update && \
    apt install -y dos2unix file lib32gcc1 nano rsync unrar-free unzip vim wget xz-utils && \
    apt autoremove -y && \
    apt clean autoclean && \
    useradd --uid 1000 --shell /bin/bash --create-home steam

USER steam

WORKDIR "/home/steam"

COPY files/run_server.sh .

RUN set -x && \
    echo "# UTIL" && \
    sed -i 's/^#alias \(.*\)/alias \1/g' .bashrc && \
    echo 'alias wget="wget --content-disposition"' >> .bashrc && \

    mkdir downloads && \
    mkdir steamcmd && \
    echo "# STEAMCMD" && \
    wget "https://media.steampowered.com/installer/steamcmd_linux.tar.gz" -O "downloads/steamcmd_linux.tar.gz" && \
    tar -zxvf downloads/steamcmd_linux.tar.gz --directory steamcmd/ && \
    ./steamcmd/steamcmd.sh +quit && \
    # first app_update will probably fail for some reason...?
    ./steamcmd/steamcmd.sh +login anonymous +force_install_dir "${HOME}/cs" +app_update 90 validate +quit || true && \
    ./steamcmd/steamcmd.sh +login anonymous +force_install_dir "${HOME}/cs" +app_update 90 validate +quit && \
    mkdir "${HOME}/.steam/sdk32" && \
    cp "${HOME}/steamcmd/linux32/steamclient.so" "${HOME}/.steam/sdk32/steamclient.so" && \
    rm -rf steamcmd

RUN set -x && \
    echo "## METAMOD" && \
    wget "https://github.com/Bots-United/metamod-p/releases/download/v1.21p38/metamod_i686_linux_win32-1.21p38.tar.xz" -O "downloads/metamod_i686_linux_win32-1.21p38.tar.xz" && \
    mkdir -p cs/cstrike/addons/metamod/dlls && \
    tar -Jxvf downloads/metamod_i686_linux_win32-1.21p38.tar.xz --directory cs/cstrike/addons/metamod/dlls/ metamod.so && \
    sed -i 's/gamedll_linux .*/gamedll_linux "addons\/metamod\/dlls\/metamod.so"/g' cs/cstrike/liblist.gam && \

    echo "### PLUGIN PODBOT" && \
    wget "https://files.gamebanana.com/gamefiles/podbot_full_v3b21.zip" -O "downloads/podbot_full_v3b21.zip" && \
    unzip downloads/podbot_full_v3b21.zip -x "podbot/pod_v3 docs/*" -d cs/cstrike/addons/ && \
    echo "linux addons/podbot/podbot_mm_i386.so" >> cs/cstrike/addons/metamod/plugins.ini && \

    echo "### PLUGIN AMXMODX" && \
    wget "https://www.amxmodx.org/release/amxmodx-1.8.2-base-linux.tar.gz" -O "downloads/amxmodx-1.8.2-base-linux.tar.gz" && \
    wget "https://www.amxmodx.org/release/amxmodx-1.8.2-cstrike-linux.tar.gz" -O "downloads/amxmodx-1.8.2-cstrike-linux.tar.gz" && \
    tar -zxvf downloads/amxmodx-1.8.2-base-linux.tar.gz --directory cs/cstrike && \
    tar -zxvf downloads/amxmodx-1.8.2-cstrike-linux.tar.gz --directory cs/cstrike && \
    echo "linux addons/amxmodx/dlls/amxmodx_mm_i386.so" >> cs/cstrike/addons/metamod/plugins.ini && \
    echo "KillerChat\nShowAttackers\nShowVictims\nShowKiller\nShowTeamScore\nShowTotalStats\nShowBestScore\nShowMostDisruptive\nShowStats\nShowDistHS\nEndPlayer\nEndTop15\nSayHP\nSayStatsMe\nSayRankStats\nSayMe\nSayRank\nSayReport\nSayScore\nSayTop15\nSayStatsAll\nSpecRankInfo" > cs/cstrike/addons/amxmodx/configs/stats.ini && \
    sed -i 's/csstats_rankbots .*/csstats_rankbots 1/g' cs/cstrike/addons/amxmodx/configs/amxx.cfg

RUN set -x && \
    echo "#### PLUGIN AMXMODX - ADVANCED BULLET DAMAGE" && \
    wget "http://www.amxmodx.org/plcompiler_vb.cgi?file_id=39600" -O "cs/cstrike/addons/amxmodx/plugins/abd.amxx" && \
    echo abd.amxx >> cs/cstrike/addons/amxmodx/configs/plugins.ini && \

    echo "#### PLUGIN AMXMODX - ULTIMATE SOUNDS PACK" && \
    wget "http://www.amxmodx.org/plcompiler_vb.cgi?file_id=67248" -O "cs/cstrike/addons/amxmodx/plugins/ultimate_sounds.amxx" && \
    echo ultimate_sounds.amxx >> cs/cstrike/addons/amxmodx/configs/plugins.ini && \
    wget "https://forums.alliedmods.net/attachment.php?attachmentid=67247&d=1275855421" -O "downloads/Ultimate_Sounds_Pack.zip" && \
    unzip downloads/Ultimate_Sounds_Pack.zip -d downloads/ && \
    rsync -avz downloads/Ultimate\ Sounds_Pack/ cs/cstrike/ && \

    echo "#### PLUGIN AMXMODX - ULTIMATE GORE" && \
    wget "http://www.amxmodx.org/plcompiler_vb.cgi?file_id=534" -O "cs/cstrike/addons/amxmodx/plugins/amx_gore_ultimate.amxx" && \
    echo amx_gore_ultimate.amxx >> cs/cstrike/addons/amxmodx/configs/plugins.ini && \

    echo "#### PLUGIN AMXMODX - KILL ASSIST" && \
    wget "http://www.amxmodx.org/plcompiler_vb.cgi?file_id=47531" -O "cs/cstrike/addons/amxmodx/plugins/kill_assist.amxx" && \
    echo kill_assist.amxx >> cs/cstrike/addons/amxmodx/configs/plugins.ini && \

    echo "#### PLUGIN AMXMODX - KILLER VIEW" && \
    wget "http://www.amxmodx.org/plcompiler_vb.cgi?file_id=105628" -O "cs/cstrike/addons/amxmodx/plugins/killer_view.amxx" && \
    echo killer_view.amxx >> cs/cstrike/addons/amxmodx/configs/plugins.ini && \

    echo "#### PLUGIN AMXMODX - GUN GAME" && \
    wget "https://files.gamebanana.com/gamefiles/gungame_amxx_213b_31331.rar" -O "downloads/gungame_amxx_213b_31331.rar" && \
    unrar downloads/gungame_amxx_213b_31331.rar downloads && \
    rsync -avz --exclude '*.url' downloads/GunGame\ AMXX\ 2.13b/GunGame\ AMXX\ 2.13b/ cs/cstrike/

RUN set -x && \
    echo "## CONFIGURE" && \
    dos2unix cs/cstrike/addons/podbot/podbot.cfg && \
    sed -i 's/pb_skin 5/pb_skin 1/g' cs/cstrike/addons/podbot/podbot.cfg && \
    sed -i 's/pb_minbotskill 95/pb_minbotskill 60/g' cs/cstrike/addons/podbot/podbot.cfg && \
    sed -i 's/pb_autokill 0/pb_autokill 1/g' cs/cstrike/addons/podbot/podbot.cfg && \
    sed -i 's/pb_autokilldelay 45/pb_autokilldelay 15/g' cs/cstrike/addons/podbot/podbot.cfg && \
    sed -i 's/pb add 100/#pb add 100/g' cs/cstrike/addons/podbot/podbot.cfg && \
    echo "pb fillserver" >> cs/cstrike/addons/podbot/podbot.cfg && \

    echo "# DONE"

EXPOSE 27015

ENTRYPOINT ["./run_server.sh"]
CMD ["de_dust"]
