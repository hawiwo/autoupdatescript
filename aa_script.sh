#!/bin/bash

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "${SCRIPT}")
SCRIPTNAME="$0"
ARGS="$@"
BRANCH="master"

self_update() {
    cd ${SCRIPTPATH}
    git fetch

    if [[ -n $(git diff --name-only origin/${BRANCH} | grep ${SCRIPTNAME}) ]] 
    then
        echo "Found a new version of me, updating myself.."
        git pull --force
        git checkout ${BRANCH}
        git pull --force
        echo "Running the new version..."
        exec "$SCRIPTNAME" "$@"
        # Now exit this old instance
        exit 1
    else
        echo "Already the latest version.."
    fi
}

main() {
   echo "Running"
   echo $@
}

self_update
main
