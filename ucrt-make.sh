#!/bin/bash -e

#
# 2nd step
# building toolchain
#

readonly TOP_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source ${TOP_DIR}/scripts/config.sh

TMP_TOOLCHAIN_DIR_NAME=$(find ${TMP_BUILDROOT} -maxdepth 1 -type d -name 'x86_64-*' -printf '%f\n')
TMP_TOOLCHAIN=${TMP_BUILDROOT}/${TMP_TOOLCHAIN_DIR_NAME}
TMP_TOOLCHAIN_WIN=$(cygpath -m ${TMP_TOOLCHAIN})

readonly GCC_PREFIX_MAP="-ffile-prefix-map=${UCRT_BUILDROOT_WIN}=./${UCRT_BUILDROOT_NAME} -ffile-prefix-map=${TMP_TOOLCHAIN_WIN}=./${TMP_BUILDROOT_NAME}"
source ${TOP_DIR}/scripts/git.sh

env SOURCE_DATE_EPOCH=${BUILD_STAMP} \
	${MINGW_BUILDS}/build \
	--arch=x86_64 \
	--march-x64=x86-64-v2 \
	--mtune-x64=generic \
	--mode=gcc-${UCRT_GCC_VER} \
	--with-default-msvcrt=ucrt \
	--exceptions=seh \
	--rev=${UCRT_REV} \
	--rt-version=${UCRT_RT_REV} \
	--threads=win32 \
	--enable-languages=c,c++,fortran \
	--provided-toolchain=${TMP_TOOLCHAIN} \
	--buildroot=${UCRT_BUILDROOT} \
	--no-extras \
	--bin-compress \
	--cflags="${GCC_PREFIX_MAP}" \
	--cxxflags="${GCC_PREFIX_MAP}" \
	--jobs=${NUMBER_OF_PROCESSORS:-4}
