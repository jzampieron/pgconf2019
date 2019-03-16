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
