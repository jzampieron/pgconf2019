#!/usr/bin/env bash

# Setup a VM for testing.

mkdir -p /data
chown ubuntu /data
apt-get -y update \
    && apt-get -y install docker.io postgresql-client-10
usermod -a -G docker ubuntu
