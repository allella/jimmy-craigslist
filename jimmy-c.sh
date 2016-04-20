#!/bin/sh

# absolute path where XML is saved. Defined by the first param of the shell command
FEEDOUTPUTPATH=$1

BASEDIR=$(dirname $0)

# max amount of seconds to pause/delay between each file to avoid hammering CL
# defined by the second param of the shell command
MAXPAUSE=$2

# read feed definitions file and use | as field delimiter
# save the first two fields into XmlAlias and rssUrl, respectively
while IFS='|' read -r xmlAlias rssURL
do

  if [[ ${xmlAlias:0:1} != "#" ]] ; then

    wget  "$rssURL" -O $FEEDOUTPUTPATH$xmlAlias.xml

    # wait/delay a random amount of time, up to the max
    sleep $[ ( $RANDOM % $MAXPAUSE ) + 1 ]s
  fi

done < $BASEDIR/feeds.csv
