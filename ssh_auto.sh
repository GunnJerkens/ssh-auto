#! /bin/bash

usage()
{
cat << EOF
usage: $0 options

This script is built to populate ssh keys across a multi user environment.

OPTIONS:
   -h      Show this message
   -m      Script mode, accepts either 'test' or 'go'
   -K      Clear the known_hosts file
EOF
}

while getopts "h:m:K" flag
do
  case $flag in

    h )
        usage
        exit 1
        ;;
    m )
        mode=$OPTARG
        ;;
    K )
        clearKnownHosts=1
        ;;

  esac
done

if [[ -z $mode ]]
then
     usage
     exit 1
fi

sshAutoDir=$(dirname $0)

if [[ ! -f $sshAutoDir/authorized_keys ]]; then
  usage
  echo "Please copy authorized_keys.sample to authorized_keys, and edit"
  exit 1
fi

if [[ ! -f $sshAutoDir/accounts_config ]]; then
  usage
  echo "Please copy accounts_config.sample to accounts_config, and edit"
  exit 1
fi


acctArray=( `cat "$sshAutoDir/accounts_config"` )

echo "Starting key migration to user accounts:"
echo "---------------"

for acct in "${acctArray[@]}"
do

  echo "Configuring $acct ..."

  acctDir=/Users/interactive03/test/$acct
  fullPath=$acctDir/.ssh/authorized_keys
  dirWarn="Warning: user account directory not found, skipping!"
  sshWarn="No .ssh folder found, one will be created.."
  dirLocate="The user account directory has been located!"

  if [[ $mode = "test" ]]; then

    if [ -d "$acctDir" ]; then
      echo $dirLocate
    else
      echo $dirWarn
    fi

    echo "cp authorized_keys $fullPath"
    echo "chown $acct:$acct $fullPath"
    echo "chmod 600 $fullPath"

    if [[ $clearKnownHosts ]]; then

      echo "> $acctDir/.ssh/known_hosts"

    fi

  elif [[ $mode = "go" ]]; then

    if [[ -d "$acctDir" ]]; then

      echo $dirLocate

      if [[ ! -d "$acctDir/.ssh" ]]; then
        echo $sshWarn
        mkdir -p $acctDir/.ssh
        chown $acct:$acct $acctDir/.ssh
        chmod 700 $acctDir/.ssh
        echo "Success"
      fi

      cp authorized_keys $fullPath
      chown $acct:$acct $fullPath
      chmod 600 $fullPath

      if [[ $clearKnownHosts ]]; then

        > $acctDir/.ssh/known_hosts

      fi

    else

      echo $dirWarn

    fi

  else

    usage 
    exit 1

  fi

  echo "$acct complete!"
  echo "---------------"
done

echo "Process complete. You are now free to ssh about the server."
