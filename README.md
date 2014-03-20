## ssh-auto

Populates public ssh keys across a multi user account system and sets appropriate ownership/permissions.


### Usage

1) Add public keys to `authorized_keys.sample` and rename to `authorized_keys`  

2) Add each user account (1 per line) to `properties_config.sample` and rename to `properties_config`  

3) Add +x to ssh-auto and execute

```
./ssh_auto.sh
```
