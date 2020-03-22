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


