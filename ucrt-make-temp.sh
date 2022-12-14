#!/bin/bash -e

#
# 1st step
# building intemediate compiler
#

readonly TOP_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source ${TOP_DIR}/scripts/config.sh

readonly GCC_PREFIX_MAP="-ffile-prefix-map=${TMP_BUILDROOT_WIN}=./${TMP_BUILDROOT_NAME}"
source ${TOP_DIR}/scripts/git.sh

env SOURCE_DATE_EPOCH=${BUILD_STAMP} \
	${MINGW_BUILDS}/build \
	--arch=x86_64 \
	--march-x64=x86-64 \
	--mtune-x64=westmere \
	--mode=gcc-${UCRT_GCC_VER} \
	--with-default-msvcrt=ucrt \
	--exceptions=seh \
	--rev=${UCRT_REV} \
	--rt-version=${UCRT_RT_REV} \
	--threads=win32 \
	--dyn-deps \
	--no-gcc-lto \
	--no-bootstrap \
	--no-extras \
	--enable-languages=c,c++ \
	--buildroot=${TMP_BUILDROOT} \
	--cflags=${GCC_PREFIX_MAP} \
	--cxxflags=${GCC_PREFIX_MAP} \
	--jobs=${NUMBER_OF_PROCESSORS:-4}
