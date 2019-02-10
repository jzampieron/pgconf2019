#
# This script contains shared variables for the
# other tooling shell scripts.
#
# Copyright (c) 2019 by Jeffrey Zampieron. All rights reserved.
#
# License: See included LICENSE file.
#

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
DATA_DIR=$HOME/pgtest/data
LOG_DIR=$HOME/pgtest/logs
