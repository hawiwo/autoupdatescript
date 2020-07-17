#!/bin/bash

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "${SCRIPT}")
SCRIPTNAME=$(basename "$0")
ARGS="$@"
BRANCH="rasp32" #!!!

self_update() {
    cd ${SCRIPTPATH}
    git fetch

    if [[ -n $(git diff --name-only origin/${BRANCH} | grep ${SCRIPTNAME}) ]] 
    then
        echo "Found a new version of me, updating myself...."
        git pull --force
        git checkout ${BRANCH}
        git pull --force
        echo "Running the new version...."
        exec "./${SCRIPTNAME}" "$@"
        # Now exit this old instance
        exit 1
    else
        echo "Already the latest version...."
    fi
}

main() {
   echo "Running with ${@}"  
   newcron << NEWCRONTAB > newcrontab
PATH=/usr/local/bin:/sbin:/usr/sbin:/bin:/usr/bin:/usr/bin/X11
SHELL=/bin/bash
#@reboot /usr/bin/tvservice -o
#* * * * * /home/pi/bmp280/bmp280 >> temp.log
#*/5 * * * * /usr/bin/curl -X POST -F "field1=$(/home/pi/bmp280/bmp280)" -k http://www.waldhof1.de/ct.php
* * * * * /home/pi/autoupdatescript/aa_script.sh ab
echo "* * * * * echo "bla"

NEWCRONTAB 

}

self_update
main ${@}
