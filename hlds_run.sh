#!/usr/bin/env bash

set -axe

CONFIG_FILE="/home/steam/hlds/startup.cfg"

if [ -r "${CONFIG_FILE}" ]; then
    # TODO: make config save/restore mechanism more solid
    set +e
    # shellcheck source=/dev/null
    source "${CONFIG_FILE}"
    set -e
fi

EXTRA_OPTIONS=( "$@" )

EXECUTABLE="/home/steam/hlds/hlds_run"
GAME="${GAME:-valve}"
MAXPLAYERS="${MAXPLAYERS:-5}"
START_MAP="${START_MAP:-bounce}"
SERVER_NAME="${SERVER_NAME:-Dougs Bounce Experience}"

OPTIONS=( "-game" "${GAME}" "+maxplayers" "${MAXPLAYERS}" "+map" "${START_MAP}" "+hostname" "\"${SERVER_NAME}\"" "+sv_lan" "0")

if [ -z "${RESTART_ON_FAIL}" ]; then
    OPTIONS+=('-norestart')
fi

set > "${CONFIG_FILE}"

exec "${EXECUTABLE}" "${OPTIONS[@]}" "${EXTRA_OPTIONS[@]}"
