#!/bin/bash
#
# This script runs a Postgresql Server in a Docker Container.
#
# The container is a stock postgres server using the official
# postgres docker images from Docker Hub.
#
# Most test scenarios will use docker for convenience and consistency.
# Unfortunately, on Mac and Windows, the Docker I/O sub-system
# has known performance issues due to the presence of
# Windows subsystem for linux (WSL) translation (windows)
# and the Docker-for-Mac xhyve Linux VM (Mac).
#
# Therefore, on metal, where needed, package based installs
# will be used and test scenario will indicate as-such.
#
# Copyright (c) 2019 by Jeffrey Zampieron. All rights reserved.
#
# License: See included LICENSE file.
#

BASEDIR=`dirname $0`

# include common
. ${BASEDIR}/vars.inc || die "Failed to include common setup."

#
# Configuration Notes
#
# 1. Host networking is used to avoid a performance hit from the
# docker bridge. This keeps the CPU use for network package processing
# lower and provides better comparisons.
#
# 2. We use data checksums, because data integrity on real servers
# is important. There is a performance hit for this, but on most CPUs
# (e.g. x86-64 since SSE4.2 have CRC-32C)
# there are accelerated CRC and similar instructions such that
# this is a non-issue.
# Even small MCUs often have hardware CRC acceleration.
#
echo "Data Dir: ${DATA_DIR}"
echo "Log Dir: ${LOG_DIR}"

docker run \
       --rm \
       --name postgres_test \
       -d \
       --net=host \
       --user "$(id -u):$(id -g)" \
       -p '5432:5432' \
       -v "${DATA_DIR}:/var/lib/postgresql/data" \
       -v "${LOG_DIR}:/logs" \
       -e 'POSTGRES_DB=bench2' \
       -e "POSTGRES_PASSWORD=${PGPASS}" \
       -e "POSTGRES_INITDB_ARGS=--waldir /logs --data-checksums" \
       postgres:${PG_VER}

