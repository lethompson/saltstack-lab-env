# SaltStack Environment Setup

![saltstack](https://github.com/lethompson/saltstack-lab-env/blob/master/how-to-install-salt.png)

## Installing salt master & minion on Linux ubuntu 16.04

###  	install_apache_saltmaster.sh (userdata script includes the following for installing salt)

```
wget -O - https://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest/SALTSTACK-GPG-KEY.pub | apt-key add -
apt-get install salt-master -y
apt-get install salt-minion -y
apt-get install salt-ssh -y
apt-get install salt-syndic -y
apt-get install salt-cloud -y
apt-get install salt-api -y

```
