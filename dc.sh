#! /bin/bash

set -e

if ! command -v dialog &> /dev/null
then
    echo "dialog is required (apt-get install dialog)"    
    exit 1
fi

# Ensure the terminal is cleared before exiting
function clear_before_exit {
  clear
  exit $?
}

trap clear_before_exit SIGINT
trap clear_before_exit SIGTERM

# The location of this script
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
export DIALOGRC="${SCRIPTPATH}/.dialogrc"

# Get the available directories containing docker-compose declarations
declare -a OPTIONS
i=1
j=1

while read line
do     
  OPTIONS[ $i ]=$j
  (( j++ ))
  OPTIONS[ ($i + 1) ]=$line
  i=($i+2)
done < <(find $1 -type f -name 'docker-compose.yml' | sort | sed "s/[/]/ /g" | sed "s/^\.//g" | sed "s/ docker-compose.yml//g")

# Create the dialog
TERMINAL=$(tty)
HEIGHT=20
WIDTH=76
CHOICE_HEIGHT=16
TITLE="Service Selector"
MENU="Choose a service:"

CHOICE=$(dialog --colors \
                --clear \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >$TERMINAL)

clear

# If nothing was chosen, exit
if [ -z $CHOICE ]
then
  exit 0
fi

# Get the path of the selected service
SELECTED="${OPTIONS[$CHOICE * 2]}";
SELECTED_DIR=`echo "${SELECTED}" | sed "s/ /\//g"`

echo "Using ${SELECTED_DIR}"
cd "${SCRIPTPATH}/${SELECTED_DIR}"

# Stop the container in caes it is already running
docker-compose stop

# Start
docker-compose up