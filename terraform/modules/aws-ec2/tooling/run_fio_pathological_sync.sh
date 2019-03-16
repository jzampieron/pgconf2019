#!/bin/bash
#
# This script runs an fio benchmark.
#
# Copyright (c) 2019 by Jeffrey Zampieron. All rights reserved.
#
# License: See included LICENSE file.
#

BASEDIR=`dirname $0`

# include common
. ${BASEDIR}/vars.inc || die "Failed to include common setup."

fio -filename=${DATA_DIR}/fio-sync-pathological.tmp \
    -iodepth=8 \
    -ioengine=${FIO_ENG} \
    -direct=1 \
    -rw=randwrite \
    -bs=4k \
    -size=5G \
    -numjobs=${FIO_JOBS} \
    -runtime=30 \
    -group_reporting \
    -name=test-randwrite \
    -fsync=1

