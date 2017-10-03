#!/bin/bash

usage() {
cat << EOF
usage: $0 options

Usage:  $0 [-hl] -i in_file

   -h,      display this message
   -i,      input file for
   -l,      only list files to be changed
EOF
}

INFILE=
BAK_FILE=".JsonStableIdBackUpFile4Delete"
TASK="sed -E -i$BAK_FILE /.*stableId.*/d"
while getopts “h:i:l” OPTION
do
     case $OPTION in
         h)
             usage
             exit 1
             ;;
         i)
             INFILE=$OPTARG
             ;;
         l)
             TASK="-I echo"
             ;;
         ?)
             usage
             exit
             ;;
     esac
done

# test file existense
is_file_exits() {
	local file="$1"
	[[ -f "$file" ]] && return 0 || return 1
}

# test args and do the job

if [[ -z $INFILE ]]
then
     usage
     exit 1
else
	if ( is_file_exits "$INFILE" )
	then
		cat $INFILE | \
        grep -B 3 'Error:' | \
        grep 'Location:' | \
        sed -E -e "s#(.*)/(test/packet_tests/.*)#$FWD_BASE_DIR/\2#g" | \
        tr -d '\r' | \
        xargs ${TASK}
        find $FWD_BASE_DIR/ -name "*$BAK_FILE" -type f -delete
	else
		echo "Input file not found!"
	fi
fi