#!/bin/bash

#
# 0 step
# initialization
#

readonly TOP_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source ${TOP_DIR}/scripts/config.sh

mkdir -p ${UCRT_WORKDIR} ||
	exit 1

pacman -Sy --noconfirm --needed git bsdtar ||
	exit 1

if [ ! -d ${MINGW_BUILDS} ]; then
	git clone --quiet --branch windres https://github.com/RoEdAl/mingw-builds --depth=1 ${MINGW_BUILDS} ||
		exit 1
fi
