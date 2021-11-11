#! /bin/bash

set -e

if ! command -v dialog &> /dev/null
then
    echo "Missing dependency 'dialog' -> apt-get install dialog"
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
cd $SCRIPTPATH
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

# Free the port if it already used by a different container
echo "Checking port availability.."
PORT_BINDINGS=`docker-compose config | grep -E "^ +- published: [0-9]+$" | sed "s/- published://g" | sed "s/ //g"`

if [ -z "${PORT_BINDINGS}" ]
then
  echo "'$SELECTED' uses no published ports"
  docker-compose up -d
  exit 0
fi

while read PORT
do
  echo "Checking $PORT"
  NETSTAT_RESULT=`netstat -antp 2>/dev/null` || exit 1
  BOUND=`echo ${NETSTAT_RESULT} | grep $PORT || true`

  if [ -z "${BOUND}" ]
  then
    echo "Port $PORT appears to be available"
    continue
  fi

  echo "Port $line is in already in use use"
  echo "Checking if used by docker container.."
  DOCKER_BINDING=`docker container ls --filter publish=$PORT --format "{{.ID}}\t{{.Names}}\t{{.Ports}}"`

  if [ -z "${DOCKER_BINDING}" ]
  then
    echo "Port $PORT is not used by a docker container, exiting"
    exit 1
  fi

  CONTAINER_ID=`echo "${DOCKER_BINDING}" | cut -f 1`
  CONTAINER_NAME=`echo "${DOCKER_BINDING}" | cut -f 2`
  echo "Port is in use by ${CONTAINER_NAME} (${CONTAINER_ID}), stopping container"
  docker stop "${CONTAINER_ID}" > /dev/null
  echo "Container stopped"
done < <(echo "${PORT_BINDINGS}")

# Start
echo "Starting container"
docker-compose up -d