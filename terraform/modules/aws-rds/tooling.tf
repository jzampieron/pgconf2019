#
# This is a terraform script to configure aws for pgconf2019
#
# This file sets up the tooling to run our tests.
#
# Copyright (c) 2019 by Jeffrey Zampieron. All rights reserved.
#
# Created 13-March-2019 by Jeffrey Zampieron <jzampieron@zproject.net>
#
# License: See included LICENSE.md
#

variable "tooling_path" {
    default = "../../../tooling"
}

// Setup the tooling file for use.
data "template_file" "jzpgconf_test_var" {
  template = "${ file( "${path.module}/${var.tooling_path}/vars.inc.tpl" ) }"
  vars = {
    pg_user   = "${var.database_username}"
    pg_pass   = "${random_string.dbpassword.result}"
    pg_dbname = "${var.database_name}"
    pg_host   = "${aws_db_instance.jzpgconf2019.address}"
    pg_port   = "${aws_db_instance.jzpgconf2019.port}"
  }
}
