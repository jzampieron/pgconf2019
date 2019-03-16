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

# Set via cmd line.
variable "operator_ip" {}

module "aws-rds" {
  source = "../modules/aws-rds"
  operator_ip = "${var.operator_ip}"
  inst_type = "m5.xlarge"
  disk_size = 1000
  iops      = 1000
}

output "vm_ip" {
    value = "${module.aws-rds.JumpBoxPublicIP}"
}
