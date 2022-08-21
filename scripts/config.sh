#
# ucrt-mingw-build : configuration loader
#

source ${TOP_DIR}/config.sh

readonly MINGW_BUILDS=${UCRT_WORKDIR}/mingw-builds

readonly UCRT_BUILDROOT=${UCRT_WORKDIR}/${UCRT_BUILDROOT_NAME}
readonly UCRT_BUILDROOT_WIN=$(cygpath -m ${UCRT_BUILDROOT})

readonly TMP_BUILDROOT=${UCRT_WORKDIR}/${TMP_BUILDROOT_NAME}
readonly TMP_BUILDROOT_WIN=$(cygpath -m ${TMP_BUILDROOT})
