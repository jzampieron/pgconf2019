#
# This is a terraform script to configure aws for pgconf2019
#
# This contains the network configuration.
#
# Copyright (c) 2019 by Jeffrey Zampieron. All rights reserved.
#
# Created 13-March-2019 by Jeffrey Zampieron <jzampieron@zproject.net>
#
# License: See included LICENSE.md
#

variable "operator_ip" {} # Set via env variable.

resource "aws_vpc" "jzpgconf2019" {
    cidr_block = "192.168.0.0/16"
}

resource "aws_subnet" "jzpgconf2019" {
    vpc_id            = "${aws_vpc.jzpgconf2019.id}"
    availability_zone = "us-east-1c"
    cidr_block        = "192.168.0.0/24"
}

resource "aws_internet_gateway" "jzpgconf2019" {
    vpc_id = "${aws_vpc.jzpgconf2019.id}"
}

resource "aws_route_table" "jzpgconf2019" {
    vpc_id = "${aws_vpc.jzpgconf2019.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.jzpgconf2019.id}"
    }
}

resource "aws_route_table_association" "jzpgconf2019" {
    subnet_id      = "${aws_subnet.jzpgconf2019.id}"
    route_table_id = "${aws_route_table.jzpgconf2019.id}"
}

resource "aws_security_group" "allow_ssh" {
    name        = "jzpgconfig2019_allow_ssh"
    description = "Allow SSH inbound traffic"
    vpc_id      = "${aws_vpc.jzpgconf2019.id}"

    ingress {
        # SSH (change to whatever ports you need)
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        # Please restrict your ingress to only necessary IPs and ports.
        # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
        cidr_blocks = [ "${var.operator_ip}" ]# add a CIDR block here
        description = "SSH for Admin"
    }

    ingress {
        # Postgres
        from_port   = 5432
        to_port     = 5432
        protocol    = "tcp"
        # Please restrict your ingress to only necessary IPs and ports.
        # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
        cidr_blocks = [
            "${aws_subnet.jzpgconf2019.cidr_block}"
        ]
        description = "Postgres for RDS"
    }

    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
        #prefix_list_ids = ["pl-12c4e678"]
    }
}