#!/bin/sh
MOVIES=~/Movies
#MOVIES="/Volumes/MP 0830/Meetings/2016"
find "$MOVIES" -name '*.mov' -exec sh -c 'ffmpeg -i "$0" -vcodec libx264 -crf 23 "${0%%.mov}.mp4"' {} \;
exit;
