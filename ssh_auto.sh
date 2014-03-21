#! /bin/bash

if [ ! -f `dirname $0`/authorized_keys ]; then
  echo "Please copy authorized_keys.sample to authorized_keys, and edit"
  exit 1
fi

if [ ! -f `dirname $0`/accounts_config ]; then
  echo "Please copy accounts_config.sample to accounts_config, and edit"
  exit 1
fi

acctArray=( `cat "accounts_config" `)

echo "Starting key migration to user accounts:"
echo "---------------"

for acct in "${acctArray[@]}"
do

  echo "Configuring $acct ..."

  acctDir=/home/$acct
  fullPath=$acctDir/.ssh/authorized_keys
  dirWarn="Warning: user account directory not found, skipping!"
  sshWarn="No .ssh folder found, one will be created.."
  dirLocate="The user account directory has been located!"

  if [ "$1" != "go" ]; then

    if [ -d "$acctDir" ]; then
      echo $dirLocate
    else
      echo $dirWarn
    fi

    echo "cp authorized_keys $fullPath"
    echo "chown $acct:$acct $fullPath"
    echo "chmod 600 $fullPath"

  else

    if [ -d "$acctDir" ]; then

      echo $dirLocate

      if [ ! -d "$acctDir/.ssh" ]; then
        echo $sshWarn
        mkdir -p $acctDir/.ssh
        chown $acct:$acct $acctDir/.ssh
        chmod 700 $acctDir/.ssh
        echo "Success"
      fi

      cp authorized_keys $fullPath
      chown $acct:$acct $fullPath
      chmod 600 $fullPath

    else

      echo $dirWarn

    fi
  fi

  echo "$acct complete!"
  echo "---------------"
done

echo "Process complete. You are now free to ssh about the server."