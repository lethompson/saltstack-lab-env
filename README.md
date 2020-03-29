# Terraform setup for saltstack environment

![Terraform-AWS](https://github.com/lethompson/saltstack-lab-env/blob/master/Terraform-AWS.png)

# AWS ubuntu instance with user data for saltstack installation
## main.tf 
```
terraform {
  required_version = ">= 0.11.0"

}

provider "aws" {
  region = "${var.aws_region}"
  access_key = "<ACCESS KEY>"
  secret_key = "<SECRET KEY>"


}

resource "aws_instance" "ubuntu" {
  ami = "${var.ami_id}"
  instance_type = "${var.instance_type}"
  availability_zone = "${var.aws_region}a"

  key_name = "saltstack-key"
 
  user_data = "${file("install_apache_saltmaster.sh")}"

  
  tags {
    Name = "${var.name}"
    OS   = "Linux Ubuntu 16.04" 
    Batch = "Apache"
  }


}
```




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

### Configure the /etc/salt/minion
```
> sudo vi /etc/salt/minion

master: <localhost>
id: <PUBLIC EC2 DNS>

(save & quite)
```
### Restart the salt-minion
```
> sudo service salt-minion restart

```

### Check the status of salt-minion & salt-master
```
> sudo systemctl status salt-minion 

> sudo systemctl status salt-master 

```

### Accept salt-key for the salt-minion & salt-master to communicate with one another

```
> sudo salt-key -L (check the list of keys accepted or not accepted)

> sudo salt-key -a <SALT KEY TO ACCEPT> (accept the key from the list)

```

