#
# This script contains shared variables for the
# other tooling shell scripts.
#
# Copyright (c) 2019 by Jeffrey Zampieron. All rights reserved.
#
# License: See included LICENSE file.
#

#
# General Machine
#
# Typically `Darwin` on Mac.
PLATFORM=`uname`

############################################################################
#
# fio setup information
#
############################################################################
#
# Unfortunately, libaio is linux only b/c it's a kernel thing
# Posix AIO is a user-space thread pool wrapper around libc sync-io
# and does not perform equivalently. There doesn't seem to be an obvious
# Mac equivalent.
if [ "${PLATFORM}" == "Darwin" ]; then
    FIO_ENG=posixaio
    FIO_JOBS=32
else
    FIO_ENG=libaio
    FIO_JOBS=64
fi
############################################################################
# End fio setup
############################################################################

############################################################################
#
# Postgres setup information
#
############################################################################
#
# Postgres version info
#
# We are opting to use the non-Alpine images in order to
# have closer comparisions with desktop based installs,
# either from source or via distribution packaging.
#
PG_VER=11.1

#
# Username/Password
#
PGUSER=postgres
PGPASS=postgres

#
# Network information
#
SRV_HOST=localhost
SRV_PORT=5432

#
# Make a couple test data directories
# these are mapped in b/c they may be a mounted disk.
#
# We split the data and WAL Logs, as is typical for
# optimized postgres installs.
#
DATA_DIR=/opt/pgdata/data
LOG_DIR=/opt/pgdata/logs
