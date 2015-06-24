#!/bin/bash

source /home/voeventdeploy/deploy_venv/bin/activate

WORKING_DIR=/home/voeventserve/working_dir
IVORN=foo.bar.baz/voevent-node-deploy-test
LOGFILE=$WORKING_DIR/log/$(date +%F-%H-%M).txt
EVENT_DB_DIR=$WORKING_DIR/db
REMOTE=voevent.4pisky.org:8099


mkdir -p $(dirname $LOGFILE)
mkdir -p $EVENT_DB_DIR
cd $WORKING_DIR

twistd -l $LOGFILE -n comet \
    --verbose \
    --eventdb=$EVENT_DB_DIR --local-ivo=ivo://$IVORN \
    --remote=$REMOTE \
    --broadcast \

