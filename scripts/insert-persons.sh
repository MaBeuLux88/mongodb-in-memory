#!/bin/bash
# Author : Maxime BEUGNET <maxime.beugnet@gmail.com>
# check first param is not empty
if [ -z "$1" ]; then
  echo "Usage : $0 [number]";
  echo "The json file will be inserted [number] times.";
else
  # repeat $1 times
  for i in `seq 1 $1`; do 
    # print every 10 to avoid spam.
    if [ $(( $i % 10 )) -eq 0 ] ; then
      nb_insert=$(($i*1000));
      echo "Number documents inserted : $nb_insert";
    fi 
    # insert
    mongoimport --quiet -d mug -c persons persons.1000.json; 
  done
fi
