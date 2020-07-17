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
   
   if [ -z "$PS1" ]; then
    not_interactive=1 
    echo "non_interactive" >> aa.log
   else
    interactive=1
    echo "interactive" >> aa.log
   fi
   
   if [[ -f "newcrontab" ]]; then
    crontab newcrontab
    echo "new Crontab installed"
    rm newcrontab
   fi
   
   
}

self_update
main ${@}
