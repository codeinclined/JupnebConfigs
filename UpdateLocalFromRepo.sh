#!/bin/sh

CONFIGS=configsList
EXCLUDES=repoExcludes
USER_EXCLUDES=userExcludes
SRC=jupnebConfigs/

INFO_STRING="$0\n\nThis script will update the user's configuration files to\
 match those found in\n$SRC, creating backups of the user's existing files\
 suffixed\nwith the ~ character.\n\nIf a file named userExcludes is found in\
 the current directory, then that file\nwill be used to exclude patterns from\
 being synced into the user's filesystem.\nThe repoExcludes file can be used as\
 a reference for the file format if the\nuser is not familiar with the expected\
 rsync exclusion file format.\n"

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

RSYNC_ARGS=("-umb" "--ignore-missing-args" "--files-from=$CONFIGS"
"--exclude-from=$EXCLUDES" $USER_EXCLUDES "$SRC" "$HOME")

# Display the files that will be updated and confirm the update with the user
echo "Files to be updated:"
echo
rsync -ni "${RSYNC_ARGS[@]}"
echo
printf "Would you like to replace and backup your configuration files? [Y/n] "

read CONFIRM_INPUT
if [[ $CONFIRM_INPUT == n* ]] || [[ $CONFIRM_INPUT == N* ]]; then
	exit
fi

# Perform the update
echo
rsync -v "${RSYNC_ARGS[@]}"
