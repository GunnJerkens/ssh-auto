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

  if [ "$1" != "go" ]; then

    echo "cp authorized_keys /home/$acct/.ssh/authorized_keys"
    echo "chown $acct:$acct /home/$acct/.ssh/authorized_keys"
    echo "chmod 600 /home/$acct/.ssh/authorized_keys"

  else

    cp authorized_keys /home/$acct/.ssh/authorized_keys
    chown $acct:$acct /home/$acct/.ssh/authorized_keys
    chmod 600 /home/$acct/.ssh/authorized_keys


  fi
  echo "$acct complete!"
  echo "---------------"
done

echo "Process complete. You are now free to ssh about the server."