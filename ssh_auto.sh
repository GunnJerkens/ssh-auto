#! /bin/bash

propArray=( `cat "properties.config" `)

echo "Starting key migration to user accounts"

for prop in "${propArray[@]}"
do
  cp authorized_keys /home/$prop/.ssh/authorized_keys
  chown $prop:$prop /home/$prop/.ssh/authorized_keys
  chmod 600 /home/$prop/.ssh/authorized_keys
  echo "$prop complete!"
done

echo "Process complete. You are now free to ssh about the server."

