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
  # IOPS Must be a multiple of 1 - 50 of the allocated storage
  # 1000 minimum, 40k max
  # See: https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Storage.html#USER_PIOPS
  allocated_storage      = 100 // minimum for io1, 100 - 32TiB
  iops                   = 1000
  engine                 = "postgres"
  engine_version         = "11.1"
  instance_class         = "db.t2.micro"
  name                   = "bench2"
  username               = "jzbenchpgconf2019"
  password               = "${var.database_password}"
  db_subnet_group_name   = "${aws_db_subnet_group.jzpgconf2019.name}"
  skip_final_snapshot    = true
  vpc_security_group_ids = [ "${aws_security_group.allow_ssh.id}" ]
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

output "DatabaseEndpoint" {
    value = "${aws_db_instance.jzpgconf2019.endpoint}"
}