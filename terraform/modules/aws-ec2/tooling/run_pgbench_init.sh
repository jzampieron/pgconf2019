#!/bin/bash
#
# This script runs a pgbench init run in a docker container.
#
# The container is a stock postgres image using the official
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

# Setup env variables per libpq.
# See: https://www.postgresql.org/docs/9.5/libpq-envars.html
docker run \
       --rm \
       --net=host \
       -e "PGHOST=${SRV_HOST}" \
       -e "PGPORT=${SRV_PORT}" \
       -e "PGPASSWORD=${PGPASS}" \
       -it postgres:${PG_VER} \
       pgbench -U ${PGUSER} -i -s 70 bench2
