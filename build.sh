#!/bin/bash

LOGFILE=build.log
(
		# Information from posted JSON(Repo, Pusher, and SSH URL)
        echo -e "`date` : Build in progress...\n"
        echo "----------------------------------"
        echo "Application: $1"
        echo "Build Trigger: $2"
        echo "SSH URL: $3"
        echo "----------------------------------"

		# Mitigative tasks to avoid duplicate errors:
		# Removes previous Docker image, container, and local path
        echo -e "\n`date` : Cleaning..."
        docker rmi -f $1
        docker stop $1
        docker container rm $1
        rm -rf $1
		
		# Clones Github Repo using SSH URL
        echo -e "\n`date` : Cloning repo...."
        git clone $3

		# Performs docker build command using repo's Dockerfile
        echo -e "\n`date` : Building new image..."
        docker build -t $1 ./$1

		# Execute standalone script with Docker run commands
		# NOTE: This was done in order to customize port expousure
        echo -e "\n`date` : Launching container..."
        sh ./$1/docker-run.sh $1
		
		# Thinking of making an if else stamement in order to say if build failed or not
        echo -e "`date` : DONE\n"
) >& $LOGFILE