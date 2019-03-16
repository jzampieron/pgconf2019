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

module "aws-ec2" {
  source = "../modules/aws-ec2"
  operator_ip = "${var.operator_ip}"
  inst_type = "r5.12xlarge"
  disk_size = 1000
  iops      = 16000
  pub_key_file  = "${ file( "${path.cwd}/../ssh_keypair.pub" ) }"
  priv_key_file = "${ file( "${path.cwd}/../ssh_keypair" ) }"
}

output "vm_ip" {
    value = "${module.aws-ec2.JumpBoxPublicIP}"
}
