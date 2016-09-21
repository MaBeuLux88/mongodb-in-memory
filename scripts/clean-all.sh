#!/bin/bash
pkill mongod
pkill -f insert-persons.sh
rm -rf data* log
