#!/bin/bash

set -e
CURRENT_PATH=$(cd "$(dirname "$0")"; pwd)
echo [CSmtp] Current path is: ${CURRENT_PATH}

RUN_MODE="$1"   # Command

BUILD_TYPE="$2" # Debug, Rlease, ...
BUILD_BITS="$3" # x64, x86

if test -z ${RUN_MODE} ; then
RUN_MODE="man"
fi

echo Config Infos:
echo - RUN_MODE: ${RUN_MODE}
echo - BUILD_TYPE: ${BUILD_TYPE}
echo - BUILD_BITS: ${BUILD_BITS}

if [ ${RUN_MODE} = "man" ] ; then
echo Build by manual with default configuration, and debug mode.
bash ${CURRENT_PATH}/script/build_linux.sh Debug
elif [ ${RUN_MODE} = "linux" ] ; then
bash ${CURRENT_PATH}/script/build_linux.sh ${BUILD_TYPE} ${BUILD_BITS}
elif [ ${RUN_MODE} = "clean" ] ; then
bash ${CURRENT_PATH}/script/clean.sh
elif [ ${RUN_MODE} = "config" ] ; then
bash ${CURRENT_PATH}/script/config.sh
else
echo Unknown run mode: ${RUN_MODE}
fi

bash ${CURRENT_PATH}/script/pause.sh
