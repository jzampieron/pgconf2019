#
# This is a terraform script to configure aws for pgconf2019
#
# This scenario is AWS RDS Postgres - Small Instance.
#
# Copyright (c) 2019 by Jeffrey Zampieron. All rights reserved.
#
# Created 13-March-2019 by Jeffrey Zampieron <jzampieron@zproject.net>
#
# License: See included LICENSE.md
#

variable "database_password" {} // Set via env var.

resource "aws_key_pair" "jzpgconf2019" {
  key_name   = "jzpgconf2019-key"
  public_key = "${ file( "${path.cwd}/../ssh_keypair.pub" ) }"
}

resource "aws_db_instance" "jzpgconf2019" {
  allocated_storage    = 100 // minimum for io1
  storage_type         = "io1"
  engine               = "postgres"
  engine_version       = "11.1"
  instance_class       = "db.t2.micro"
  name                 = "bench2"
  username             = "jzbenchpgconf2019"
  password             = "${var.database_password}"
  db_subnet_group_name = "${aws_db_subnet_group.jzpgconf2019.name}"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "jzpgconf2019" {
  ami                         = "${data.aws_ami.ubuntu.id}"
  instance_type               = "t2.micro"
  subnet_id                   = "${aws_subnet.jzpgconf2019.id}"
  associate_public_ip_address = true
  key_name                    = "${aws_key_pair.jzpgconf2019.key_name}"
}

output "JumpBoxPublicIP" {
    value = "${aws_instance.jzpgconf2019.public_ip}"
}