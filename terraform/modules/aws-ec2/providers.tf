#
# This is a terraform script to configure aws for pgconf2019
#
# These are the terraform provider setups.
#
# Copyright (c) 2019 by Jeffrey Zampieron. All rights reserved.
#
# Created 13-March-2019 by Jeffrey Zampieron <jzampieron@zproject.net>
#
# License: See included LICENSE.md
#

provider "aws" {
    version = "~> 2.1.0"
}

provider "template" {
    version = "~> 1.0.0"
}

provider "null" {
    version = "~> 0.1"
}

provider "local" {
    version = "~> 0.1"
}

provider "external" {
    version = "~> 1.0"
}