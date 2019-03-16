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

variable "pub_key_file" {}

variable "priv_key_file" {}

variable "num_clients" {
    default = "1"
}

variable "inst_type" {}

variable "disk_size" {}

variable "iops" {}

resource "aws_key_pair" "jzpgconf2019" {
    key_name   = "jzpgconf2019-key-${random_string.unique.result}"
    public_key = "${var.pub_key_file}"
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
    count                       = "${var.num_clients}"
    ami                         = "${data.aws_ami.ubuntu.id}"
    instance_type               = "${var.inst_type}"
    subnet_id                   = "${aws_subnet.jzpgconf2019.id}"
    associate_public_ip_address = true
    key_name                    = "${aws_key_pair.jzpgconf2019.key_name}"
    vpc_security_group_ids      = [ "${aws_security_group.allow_ssh.id}" ]

    ebs_block_device {
        device_name = "/dev/sde"
        volume_type = "io1"
        volume_size = "${var.disk_size}"
        iops        = "${var.iops}"
    }

    ebs_block_device {
        device_name = "/dev/sdf"
        volume_type = "io1"
        volume_size = "${var.disk_size}"
        iops        = "${var.iops}"
    }

    ebs_block_device {
        device_name = "/dev/sdg"
        volume_type = "io1"
        volume_size = "${var.disk_size}"
        iops        = "${var.iops}"
    }

    ebs_block_device {
        device_name = "/dev/sdh"
        volume_type = "io1"
        volume_size = "${var.disk_size}"
        iops        = "${var.iops}"
    }

    connection {
        type         = "ssh"
        host         = "${self.public_ip}"
        user         = "ubuntu"
        timeout      = "60s"
        private_key  = "${var.priv_key_file}"
    }

    provisioner "remote-exec" {
        inline = [
            "sudo apt-get -y update"
        ]
    }

    provisioner "file" {
        source      = "${path.module}/files/setup_vm.sh"
        destination = "/tmp/setup_vm.sh"
    }

    provisioner "remote-exec" {
        inline = [
            "sudo chmod 755 /tmp/setup_vm.sh",
            "sudo /tmp/setup_vm.sh"
        ]
    }

    provisioner "file" {
        source      = "${path.module}/${var.tooling_path}"
        destination = "/data"
    }

    provisioner "file" {
        content     = "${data.template_file.jzpgconf_test_var.rendered}"
        destination = "/data/tooling/vars.inc"
    }

    provisioner "remote-exec" {
        inline = [
            "chmod 755 /data/tooling/*.sh"
        ]
    }
}

output "JumpBoxPublicIP" {
    value = [ "${aws_instance.jzpgconf2019.*.public_ip}" ]
}

