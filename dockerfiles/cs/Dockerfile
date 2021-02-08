FROM library/debian:latest

RUN set -x && \
    apt update && \
    apt install -y dos2unix file lib32gcc1 nano unzip vim wget xz-utils && \
    useradd --uid 1000 --shell /bin/bash --create-home steam

USER steam

WORKDIR "/home/steam"

RUN set -x && \
    echo "#### UTIL" && \
    sed -i 's/^#alias \(.*\)/alias \1/g' .bashrc && \
    echo 'alias wget="wget --content-disposition"' >> .bashrc && \

    mkdir downloads && \
    mkdir steamcmd && \
    echo "#### STEAMCMD" && \
    wget "https://media.steampowered.com/installer/steamcmd_linux.tar.gz" -O "downloads/steamcmd_linux.tar.gz" && \
    tar -zxvf downloads/steamcmd_linux.tar.gz --directory steamcmd/ && \
    ./steamcmd/steamcmd.sh +quit && \
    # first app_update will probably fail for some reason...?
    ./steamcmd/steamcmd.sh +login anonymous +force_install_dir "${HOME}/cs" +app_update 90 validate +quit || true && \
    ./steamcmd/steamcmd.sh +login anonymous +force_install_dir "${HOME}/cs" +app_update 90 validate +quit && \
    mkdir "${HOME}/.steam/sdk32" && \
    cp "${HOME}/steamcmd/linux32/steamclient.so" "${HOME}/.steam/sdk32/steamclient.so" && \
    echo "#!/bin/bash\ncd cs/\n./hlds_run -game cstrike +maxplayers 8 +map de_dust" > run_server.sh && \
    chmod +x run_server.sh  && \

    echo "#### METAMOD" && \
    wget "https://github.com/Bots-United/metamod-p/releases/download/v1.21p38/metamod_i686_linux_win32-1.21p38.tar.xz" -O "downloads/metamod_i686_linux_win32-1.21p38.tar.xz" && \
    mkdir -p cs/cstrike/addons/metamod/dlls && \
    tar -Jxvf downloads/metamod_i686_linux_win32-1.21p38.tar.xz --directory cs/cstrike/addons/metamod/dlls/ metamod.so && \
    sed -i 's/gamedll_linux .*/gamedll_linux "addons\/metamod\/dlls\/metamod.so"/g' cs/cstrike/liblist.gam && \

    echo "#### PLUGIN AMXMODX" && \
    wget "https://www.amxmodx.org/release/amxmodx-1.8.2-base-linux.tar.gz" -O "downloads/amxmodx-1.8.2-base-linux.tar.gz" && \
    wget "https://www.amxmodx.org/release/amxmodx-1.8.2-cstrike-linux.tar.gz" -O "downloads/amxmodx-1.8.2-cstrike-linux.tar.gz" && \
    tar -zxvf downloads/amxmodx-1.8.2-base-linux.tar.gz --directory cs/cstrike && \
    tar -zxvf downloads/amxmodx-1.8.2-cstrike-linux.tar.gz --directory cs/cstrike && \
    echo "linux addons/amxmodx/dlls/amxmodx_mm_i386.so" >> cs/cstrike/addons/metamod/plugins.ini && \

    echo "#### PLUGIN PODBOT" && \
    wget "https://files.gamebanana.com/gamefiles/podbot_full_v3b21.zip" -O "downloads/podbot_full_v3b21.zip" && \
    unzip downloads/podbot_full_v3b21.zip -x "podbot/pod_v3 docs/*" -d cs/cstrike/addons/ && \
    echo "linux addons/podbot/podbot_mm_i386.so" >> cs/cstrike/addons/metamod/plugins.ini && \

    wget "http://www.amxmodx.org/plcompiler_vb.cgi?file_id=39600" -O "cs/cstrike/addons/amxmodx/plugins/abd.amxx" && \
    echo abd.amxx >> cs/cstrike/addons/amxmodx/configs/plugins.ini && \

    echo "#### CLEAN" && \
    rm -rf steamcmd && \
    echo "#### DONE"

USER root

RUN set -x && \
    apt autoremove -y && \
    apt clean autoclean

USER steam

EXPOSE 27015

ENTRYPOINT ["./run_server.sh"]
