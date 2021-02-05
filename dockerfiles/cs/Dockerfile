FROM library/debian:latest

RUN set -x && \
    apt update && \
    apt install -y dos2unix file lib32gcc1 nano unzip vim wget && \
    useradd --uid 1000 --shell /bin/bash --create-home steam

USER steam

WORKDIR "/home/steam"

RUN set -x && \
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
    wget "https://downloads.sourceforge.net/project/metamod/Metamod%20Binaries/1.20/metamod-1.20-linux.tar.gz" -O "downloads/metamod-1.20-linux.tar.gz" && \
    mkdir -p cs/cstrike/addons/metamod/dlls && \
    tar -zxvf downloads/metamod-1.20-linux.tar.gz --directory cs/cstrike/addons/metamod/dlls/ metamod_i386.so && \
    ln -s metamod_i386.so cs/cstrike/addons/metamod/dlls/metamod.so && \
    sed -i 's/gamedll_linux .*/gamedll_linux "addons\/metamod\/dlls\/metamod.so"/g' cs/cstrike/liblist.gam && \

    echo "#### PLUGIN ADMINMOD" && \
    wget "https://downloads.sourceforge.net/project/halflifeadmin/halflifeadmin/2.50.60/halflife-admin-2.50.60-linux.tar.gz" -O "downloads/halflife-admin-2.50.60-linux.tar.gz" && \
    mkdir -p cs/cstrike/addons/adminmod/config cs/cstrike/addons/adminmod/dlls && \
    tar -zxvf downloads/halflife-admin-2.50.60-linux.tar.gz --strip-components 2 --directory cs/cstrike/addons/adminmod/config Adminmod/config/adminmod.cfg && \
    tar -zxvf downloads/halflife-admin-2.50.60-linux.tar.gz --strip-components 2 --directory cs/cstrike/addons/adminmod/dlls Adminmod/dlls/admin_MM_i386.so Adminmod/dlls/amx_admin.so && \
    echo "linux addons/adminmod/dlls/admin_MM_i386.so" >> cs/cstrike/addons/metamod/plugins.ini && \

    echo "#### PLUGIN PODBOT" && \
    wget "https://files.gamebanana.com/gamefiles/podbot_full_v3b21.zip" -O "downloads/podbot_full_v3b21.zip" && \
    unzip downloads/podbot_full_v3b21.zip -x "podbot/pod_v3 docs/*" -d cs/cstrike/addons/ && \
    echo "linux addons/podbot/podbot_mm_i386.so" >> cs/cstrike/addons/metamod/plugins.ini && \

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
