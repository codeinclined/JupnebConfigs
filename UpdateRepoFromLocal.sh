#!/bin/sh

# Files and directories used by this script
CONFIGS=configsList
EXCLUDES=repoExcludes
USER_EXCLUDES=userExcludes
DEST=jupnebConfigs/

INFO_STRING="$0\n\nThis script will sync the files contained in \
$DEST to match their\ncounterparts on the user's own system.\
\n\nIf a file named userExcludes is found in the current directory then those\
\nexcludes will be used in addition to those found in repoExcludes.\
 repoExcludes\ncan be used as a reference for the file format if the user is
 not familiar with\nthe expected rsync exclusion file format.\n"

# Print information about this script if arguments are passed to it
if [ $# -gt 0 ]; then
	printf "$INFO_STRING"
	exit
fi	

# If a userExcludes file exists, then pass it to rsync
if [ -f $USER_EXCLUDES ]; then
	USER_EXCLUDES="--exclude-from=$USER_EXCLUDES"
else
	USER_EXCLUDES=""
fi

RSYNC_ARGS=("-aum" "--files-from=$CONFIGS" "--exclude-from=$EXCLUDES"
$USER_EXCLUDES "--delete" "$HOME" "$DEST")

# Display the files that will be updated and confirm the update with the user
echo "Files to be updated:"
echo
rsync -ni "${RSYNC_ARGS[@]}"
echo
printf "Would you like to update from your local system to the archive? [Y/n] "

read CONFIRM_INPUT
if [[ $CONFIRM_INPUT == n* ]] || [[ $CONFIRM_INPUT == N* ]]; then
	exit
fi

# Perform the update
echo
rsync -v "${RSYNC_ARGS[@]}"
