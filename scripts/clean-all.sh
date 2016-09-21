#!/bin/bash
# Author : Maxime BEUGNET <maxime.beugnet@gmail.com>
pkill mongod
pkill -f insert-persons.sh
rm -rf data* log
