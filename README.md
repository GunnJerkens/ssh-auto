## ssh-auto

Populates public ssh keys across a multi user account system and sets appropriate ownership/permissions. Also can clear the known_hosts file if hostnames/ips have changed.

It is expected that this is being run by the root user.


### Usage

1) Add public keys to `authorized_keys.sample` and save as `authorized_keys`  

2) Add each user account (1 per line) to `properties_config.sample` and save as `properties_config`  

3) Add +x to ssh-auto and execute to perform a dry run  

```
./ssh_auto.sh -m test
```

4) If satisfied add the option `go`  

```
./ssh_auto.sh -m go
```

### Flags

|      Flags     |       Arguments        |             Output           |
| :------------: | :---------------------:| :--------------------------: |
|       -h       | none                   | Shows the usage menu         |
|       -m       | `test` or `go`         | Mode to run the tool in      |
|       -K       | none                   | Clear the known_hosts        |

### License

MIT