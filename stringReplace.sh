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
if [[ $OSTYPE  == *"msys"* ]]; then
    echo "This is a Windows Machine $OSTYPE"
else
    echo "Some other machine $OSTYPE" 
fi


if [ -f .env ]; then
    # Load Environment Variables
    export $(cat .env | grep -v '#' | awk '/=/ {print $1}')
    # For instance, will be example_kaggle_key
    echo "Loaded environmental variable: TRANSPORT_STRING=$TRANSPORT_STRING"
    echo "Loaded environmental variable: HOST_STRING=$HOST_STRING"
    echo "Loaded environmental variable: PortNumber=$PortNumber"
    echo "Loaded environmental variable: OAUTH_CLIENT_ID=$OAUTH_CLIENT_ID"
    #Secret will not show
    echo "Loaded environmental variable: OAUTH_CLIENT_SECRET=********"

    if [[ ${TRANSPORT_STRING} =~  .*https.* ]]; then
      echo "To use the following transport string:  ${TRANSPORT_STRING}://$HOST_STRING"
      replaceString="$HOST_STRING";
    else
      echo "To use the following transport string:  ${TRANSPORT_STRING}://$HOST_STRING:$PortNumber"
      replaceString="$HOST_STRING:$PortNumber";
    fi


    # Localhost configuration based on .env
    # Substitute to correct config if founded "$TargetKey =" in LocalSetting.php
    # Only replace 'var' instead of "var" 
    filename="Sample.php"
    # Put in all the params for configuration
    oauth_key_array=(
      "wgServer" 
      "wgOAuth2Client\[\'client\'\]\[\'id\'\]" 
      "wgOAuth2Client\[\'client\'\]\[\'secret\'\]"
      "wgOAuth2Client\[\'configuration\'\]\[\'redirect_uri\'\]"
      )

    oauth_val_array=(
      $TRANSPORT_STRING://${replaceString} 
      $OAUTH_CLIENT_ID 
      $OAUTH_CLIENT_SECRET
      "$TRANSPORT_STRING://${replaceString}/index.php/Special:OAuth2Client/callback"
      )
    len=${#oauth_key_array[@]}
    for (( i=0; i<$len; i++ ));
    do
      echo "Replacing string in LocalSettings.php: ${oauth_key_array[$i]}"
        sed "s|\$${oauth_key_array[$i]}[[:blank:]]*=.*|\$${oauth_key_array[$i]} = \"${oauth_val_array[$i]}\";|" $filename > temp.txt && mv temp.txt $filename
    done
fi
