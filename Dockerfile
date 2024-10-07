FROM cm2network/steamcmd:latest

ARG steam_user=anonymous
ARG steam_password=
ARG install_directory=/home/steam

USER steam

RUN mkdir -p ${install_directory}/hlds && \
    ${install_directory}/steamcmd/steamcmd.sh +force_install_dir ${install_directory}/hlds +login $steam_user $steam_password +app_update 90 validate +quit || \ 
    ${install_directory}/steamcmd/steamcmd.sh +force_install_dir ${install_directory}/hlds +login $steam_user $steam_password +app_update 90 validate +quit || \ 
    ${install_directory}/steamcmd/steamcmd.sh +force_install_dir ${install_directory}/hlds +login $steam_user $steam_password +app_update 90 validate +quit

WORKDIR ${install_directory}/hlds
COPY --chmod=700 --chown=steam:steam hlds_run.sh ${install_directory}/hlds/hlds_run.sh
# fix Error:./libstdc++.so.6: version `CXXABI_1.3.8' not found (required by /home/steam/hlds/filesystem_stdio.so)
# https://forums.linuxmint.com/viewtopic.php?t=408576
# RUN mv libstdc++.so.6 libstdc++.so.6.ignoreme
# appears to not be needed now - 7th oct 2024
EXPOSE 27015/udp
EXPOSE 27015/tcp
ENTRYPOINT [ "/home/steam/hlds/hlds_run.sh" ]



