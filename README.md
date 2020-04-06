# Terraform setup for saltstack environment

![TerraformAWS](/img/Terraform-AWS.png)

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

## variables.tf
```
variable "aws_region" {

   description = "AWS region"
   default = "us-east-1"
}

variable "ami_id" {
   description = "ID of the AMI to provision. Default is Ubuntu 16.04 Base Image"
  default = "ami-04169656fea786776"
}

variable "instance_type" {
   description = "type of EC2 instance to provision."
   default = "t2.micro"

}

variable "name" {

   description = "name to pass to Name tag"
   default = "Salt-WebServer-01"
}
```

# Output the AWS instance public DNS 
## outputs.tf

```
output "public_dns" {

   value = "${aws_instance.ubuntu.public_dns}"
}
```

## Steps to deploy the AWS infrastructure for the AWS saltstack lab environment

```
> terraform init
```

```
> terraform plan -out=tfplan
```

```
> terraform apply tfplan
```

# SaltStack Environment Setup

![saltstack](/img/how-to-install-salt.png)

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
### Clone the repo for saltstack

```

> sudo su - (switch to root user)

> cd /srv

> git clone https://github.com/lethompson/aws-saltstack.git

```

### SaltStack file structure for lab environment

```
aws-saltstack repo:

.
├── keys
├── pillar
│   ├── swl.sls
│   ├── top.sls
│   └── users.sls
├── reactor
├── salt
│   ├── logging
│   │   ├── files
│   │   │   └── cron.daily
│   │   │       └── 00logwatch
│   │   └── init.sls
│   ├── nginx
│   │   ├── files
│   │   │   └── nginx.conf
│   │   └── init.sls
│   ├── redis
│   │   └── init.sls
│   ├── requirements
│   │   └── init.sls
│   ├── ssh
│   │   ├── files
│   │   │   └── sshd_config
│   │   └── init.sls
│   ├── swl
│   │   ├── files
│   │   └── init.sls
│   ├── top.sls
│   └── users
│       ├── files
│       └── init.sls
└── users.sls

```
