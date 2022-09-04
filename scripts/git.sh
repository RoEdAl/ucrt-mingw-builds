#
# git.sh
#

if [ -n "$(git -C ${TOP_DIR} status --porcelain)" ]; then
	echo 'There are uncommited changes' 1>&2
	exit 1
fi

readonly BUILD_STAMP=$(git -C ${TOP_DIR} log -n 1 '--pretty=format:%ct')
if [ -z "${BUILD_STAMP}" ]; then
	echo 'Unable to get timestamp of last commit' 1>&2
	exit 1
fi

readonly BUILD_DATE=$(date -u --date=@${BUILD_STAMP} '+%F %T')
echo "Build timestamp: ${BUILD_DATE} [@${BUILD_STAMP}]"
