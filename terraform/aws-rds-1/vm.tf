#
# This is a terraform script to configure aws for pgconf2019
#
# This file creates a VM in the same VPC as the RDS instance.
#
# Copyright (c) 2019 by Jeffrey Zampieron. All rights reserved.
#
# Created 13-March-2019 by Jeffrey Zampieron <jzampieron@zproject.net>
#
# License: See included LICENSE.md
#

resource "aws_key_pair" "jzpgconf2019" {
  key_name   = "jzpgconf2019-key"
  public_key = "${ file( "${path.cwd}/../ssh_keypair.pub" ) }"
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

// Standardized on 4 CPU or vCPU machines for this testing.
resource "aws_instance" "jzpgconf2019" {
  ami                         = "${data.aws_ami.ubuntu.id}"
  instance_type               = "m4.xlarge"
  subnet_id                   = "${aws_subnet.jzpgconf2019.id}"
  associate_public_ip_address = true
  key_name                    = "${aws_key_pair.jzpgconf2019.key_name}"
  vpc_security_group_ids      = [ "${aws_security_group.allow_ssh.id}" ]
}

output "JumpBoxPublicIP" {
    value = "${aws_instance.jzpgconf2019.public_ip}"
}

