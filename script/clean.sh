#!/bin/bash

set -e
TOP_PATH=$(cd "$(dirname "$0")/.."; pwd)
echo ==== clean: delete the folder: ${TOP_PATH}/build ====

rm -rf ${TOP_PATH}/build
