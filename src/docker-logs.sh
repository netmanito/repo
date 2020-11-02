#!/bin/bash

LOG="$(which log)"

if [ -z "$LOG" ]; then
	for i in `docker ps |grep '"' |awk {'print $1'}`; do docker logs -f $i;done
else
	log stream --predicate 'eventMessage contains "docker"'
fi
