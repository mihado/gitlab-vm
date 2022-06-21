#!/bin/bash
set -e

if [[ -z $GITLAB_HOME ]]; then
    echo "GITLAB_HOME is unset"
    exit
fi

sudo rm -rf $GITLAB_HOME/config
sudo rm -rf $GITLAB_HOME/logs
