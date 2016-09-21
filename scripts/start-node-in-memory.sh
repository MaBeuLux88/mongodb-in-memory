#!/bin/bash
# Author : Maxime BEUGNET <maxime.beugnet@gmail.com>
##################
# INIT VARIABLES #
##################
# The absolute path to this script
SCRIPT=$(readlink -f "$0")
# The path to this script
SCRIPT_PATH=$(dirname "$SCRIPT")
# MongoDB dbpath folder
DBPATH_1=$SCRIPT_PATH/data-memory-1
# Log path
LOGPATH=$SCRIPT_PATH/log
LOGFILE_1=$LOGPATH/mongo-in-memory-1.log
##################
rm -rf $DBPATH_1 $LOGPATH
mkdir $DBPATH_1 $LOGPATH
echo "logs   : $LOGFILE_1"
echo "dbpath : $DBPATH_1"
mongod --logpath $LOGFILE_1 \
       --storageEngine inMemory \
       --dbpath $DBPATH_1 \
       --inMemorySizeGB 1 \
       --fork
