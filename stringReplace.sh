#! /bin/bash

if [[ $(which docker) && $(docker --version) ]]; then
  echo "$OSTYPE has $(docker --version) installed"
  else
    echo "You need to Install docker"
    # command
    case "$OSTYPE" in
      darwin*)  echo "$OSTYPE should install Docker Desktop by following this link https://docs.docker.com/docker-for-mac/install/" ;; 
      msys*)    echo "$OSTYPE should install Docker Desktop by following this link https://docs.docker.com/docker-for-windows/install/" ;;
      cygwin*)  echo "$OSTYPE should install Docker Desktop by following this link https://docs.docker.com/docker-for-windows/install/" ;;
      linux*)
        echo "Some $OSTYPE distributions could install Docker, we will try to install Docker for you..." 
        ./AdvancedTooling/installDockerForUbuntu.sh   
        echo "Installation complete, setting up the sudo su command, you will need the root access to this linux machine."
        sudo su ;;
      *)        echo "Sorry, this $OSTYPE might not have Docker implementation" ;;
    esac
fi

if [ "darwin20" = $OSTYPE ]; then
    echo "This is a $OSTYPE Mac Machine"
else
    echo "Some other machine $OSTYPE"
fi

# Note that to test containment, there must be two square brackets
if [[ $OSTYPE  == *"darwin"* ]]; then
    echo "This is a Mac Machine $OSTYPE"
else
    echo "Some other machine $OSTYPE" 
fi