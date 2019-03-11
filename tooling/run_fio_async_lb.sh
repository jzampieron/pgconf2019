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

fio -filename=${DATA_DIR}/fio-async-lb.tmp \
    -iodepth=128 \
    -ioengine=libaio \
    -direct=1 \
    -rw=randwrite \
    -bs=64k \
    -size=5G \
    -runtime=30 \
    -group_reporting \
    -name=test-randwrite \
    --end_fsync=1

