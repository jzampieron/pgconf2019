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

variable "database_name" {
  default = "bench2"
}

variable "database_username" {
  default = "jzbenchpgconf2019"
}

variable "database_password" {} // Set via env var.

resource "aws_db_instance" "jzpgconf2019" {
  # IOPS Must be a multiple of 1 - 50 of the allocated storage
  # 1000 minimum, 40k max
  # See: https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Storage.html#USER_PIOPS
  allocated_storage      = 100 // minimum for io1, 100 - 32TiB
  iops                   = 1000
  engine                 = "postgres"
  engine_version         = "11.1"
  # Roughly equiv. to 2012 MacBook.
  # 4vCPU, 16GiB RAM.
  instance_class         = "db.m5.xlarge"
  name                   = "${var.database_name}"
  username               = "${var.database_username}"
  password               = "${var.database_password}"
  db_subnet_group_name   = "${aws_db_subnet_group.jzpgconf2019.name}"
  skip_final_snapshot    = true
  vpc_security_group_ids = [ "${aws_security_group.allow_ssh.id}" ]
}

output "DatabaseEndpoint" {
    value = "${aws_db_instance.jzpgconf2019.endpoint}"
}