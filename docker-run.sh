#!/bin/bash

#NOTE:	make sure to include this file in your repo
#		the docker run command was not included in the build.sh
#		as a way to give more control over flags and port expousure

HOST_PORT=3035
CONTAINER_PORT=3035

docker run -t $1 -p $HOST_PORT:$CONTAINER_PORT $1 