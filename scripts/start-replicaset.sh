#!/bin/bash
##################
# INIT VARIABLES #
##################
# The absolute path to this script
SCRIPT=$(readlink -f "$0")
# The path to this script
SCRIPT_PATH=$(dirname "$SCRIPT")
# MongoDB dbpath folders
DBPATH_1=$SCRIPT_PATH/data-memory-1
DBPATH_2=$SCRIPT_PATH/data-memory-2
DBPATH_3=$SCRIPT_PATH/data-wiredtiger
# Log path
LOGPATH=$SCRIPT_PATH/log
LOGFILE_1=$LOGPATH/mongo-in-memory-1.log
LOGFILE_2=$LOGPATH/mongo-in-memory-2.log
LOGFILE_3=$LOGPATH/mongo-wiredtiger.log
##################
rm -rf $DBPATH_1 $DBPATH_2 $DBPATH_3 $LOGPATH
mkdir $DBPATH_1 $DBPATH_2 $DBPATH_3 $LOGPATH
echo "logs     : $LOGFILE"
echo "dbpath_1 : $DBPATH_1"
echo "dbpath_2 : $DBPATH_2"
echo "dbpath_3 : $DBPATH_3"
mongod --replSet replica \
       --logpath $LOGFILE_1 \
       --storageEngine inMemory \
       --dbpath $DBPATH_1 \
       --inMemorySizeGB 1 \
       --port 27017 \
       --fork
mongod --replSet replica \
       --logpath $LOGFILE_2 \
       --storageEngine inMemory \
       --dbpath $DBPATH_2 \
       --inMemorySizeGB 1 \
       --port 27018 \
       --fork
mongod --replSet replica \
       --logpath $LOGFILE_3 \
       --dbpath $DBPATH_3 \
       --port 27019 \
       --fork
sleep 1

echo 'rs.initiate({
      _id: "replica",
      members: [
         { _id: 0, host: "127.0.0.1:27017" },
         { _id: 1, host: "127.0.0.1:27018" },
         { _id: 2, host: "127.0.0.1:27019", hidden:true, priority: 0}]});' | mongo
