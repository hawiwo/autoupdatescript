#!/bin/bash

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "${SCRIPT}")
SCRIPTNAME=$(basename "$0")
ARGS="$@"
BRANCH="raspiwaage1" #!!!

self_update() {
    cd ${SCRIPTPATH}
    git fetch

    if [[ -n $(git diff --name-only origin/${BRANCH} | grep ${SCRIPTNAME}) ]] 
    then
        echo "Found a new version of me, updating myself.."
        git pull --force
        git checkout ${BRANCH}
        git pull --force
        echo "Running the new version.."
        exec "./${SCRIPTNAME}" "$@"
        # Now exit this old instance
        exit 1
    else
        echo "Already the latest version.."
    fi
}

main() {
   echo "Running with ${@}"  
   if [ -z "$PS1" ]; then
    echo "$(date +"%Y-%m-%d %H:%M") cron updated aa_script" >> cron.log
   fi   
}

self_update
main ${@}
