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

variable "inst_type" {}

variable "disk_size" {}

variable "iops" {}

variable "database_name" {
  default = "bench2"
}

variable "database_username" {
  default = "jzbenchpgconf2019"
}

resource "random_string" "dbpassword" {
  length  = 32
  number  = false
  special = false
}

# Used to make unique names.
resource "random_string" "unique" {
  length  = 8
  number  = false
  special = false
  upper   = false
}

resource "aws_db_instance" "jzpgconf2019" {
  # IOPS Must be a multiple of 1 - 50 of the allocated storage
  # 1000 minimum, 40k max
  # See: https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Storage.html#USER_PIOPS
  allocated_storage      = "${var.disk_size}" // minimum for io1, 100 - 32TiB
  iops                   = "${var.iops}"
  engine                 = "postgres"
  engine_version         = "11.1"
  instance_class         = "db.${var.inst_type}"
  name                   = "${var.database_name}"
  username               = "${var.database_username}"
  password               = "${random_string.dbpassword.result}"
  db_subnet_group_name   = "${aws_db_subnet_group.jzpgconf2019.name}"
  skip_final_snapshot    = true
  vpc_security_group_ids = [ "${aws_security_group.allow_ssh.id}" ]
}

output "DatabaseEndpoint" {
    value = "${aws_db_instance.jzpgconf2019.endpoint}"
}