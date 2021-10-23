#!/bin/bash

set -e
TOP_PATH=$(cd "$(dirname "$0")/.."; pwd)

# See ../build.sh
BUILD_TYPE="$1"
BUILD_BITS="$2"

if test -z ${BUILD_TYPE} ; then
BUILD_TYPE="Debug"
fi

if test -z ${BUILD_BITS} ; then
BUILD_BITS="Undefined"
fi

BUILD_JOBS=$(($(grep -c ^processor /proc/cpuinfo) - 1))

# The building in linux will use the default compile toolchain in the system.
echo ==== build: building CSmtp now. ====

echo Build type: ${BUILD_TYPE}
echo Build bits: ${BUILD_BITS}
if [ ${BUILD_BITS} = "x64" ] ; then
export CFLAGS="-m64 ${CFLAGS}"
export CXXFLAGS="-m64 ${CXXFLAGS}"
elif [ ${BUILD_BITS} = "x86" ] ; then
export CFLAGS="-m32 ${CFLAGS}"
export CXXFLAGS="-m32 ${CXXFLAGS}"
else
echo Undefined or unknown build bit: ${BUILD_BITS}, use the default.
fi

export MAKEFLAGS="${MAKEFLAGS} -j${BUILD_JOBS}"
echo Build jobs count: ${BUILD_JOBS}

echo Build Config Infos of Env:
echo - CFLAGS:    ${CFLAGS}
echo - CXXFLAGS:  ${CXXFLAGS}
echo - MAKEFLAGS: ${MAKEFLAGS}

mkdir -p build/construct
cd build/construct
cmake ../../csmtp
cmake --build . --config ${BUILD_TYPE}
cd ../..

echo ==== build: archiving CSmtp now. ====

mkdir -p build/archive
cd build/archive

mkdir -p bin
cp -u ../construct/mail_sender bin/mail_sender
mkdir -p lib
cp -u ../construct/libcsmtp.a lib/libcsmtp.a
mkdir -p inc
cp -u ../../csmtp/csmtp/CSmtp.h inc/CSmtp.h

cd ../..

echo ==== build: build successfully! ====
