#!/usr/bin/env bash

# Setup a VM for testing.

export DEBIAN_FRONTEND=noninteractive

mkdir -p /data/pgdata
chown -R ubuntu /data
sleep 5
apt-get -y update
sync
sleep 5
apt-get -y install docker.io postgresql-client-10 fio iotop sysstat
usermod -a -G docker ubuntu