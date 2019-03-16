#!/usr/bin/env bash

# Setup a VM for testing.

export DEBIAN_FRONTEND=noninteractive

mkdir -p /data
chown ubuntu /data
sleep 5
apt-get -y update
sync
sleep 5
apt-get -y install docker.io postgresql-client-10
usermod -a -G docker ubuntu
