#!/bin/bash
#
# Copyright (C) 2010-2012 Andrei Pozolotin <Andrei.Pozolotin@gmail.com>
#
# All rights reserved. Licensed under the OSI BSD License.
#
# http://www.opensource.org/licenses/bsd-license.php
#

#
# mysql master/master cluster install
#

#
# ${carrotTimeISO}
#

#
# disable apt-get dialogs
#
export DEBIAN_FRONTEND=noninteractive

#
# location of this script
#
folder=$(dirname $0)

#########################

#
# stop instancevs, if any
#
service mysql stop
service mysql01 stop
service mysql02 stop

#
# cleanup mysql install
#
#apt-get -y purge mysql-server
#apt-get -y autoremove

#
# cleanup mysql databases
#
rm --force --recursive /var/lib/mysql/*

#########################

#
# install default mysql server
#
apt-get -y install mysql-server

#
# ignore default instance
#
service mysql stop

#
# copy config files
#
cp --force --recursive $folder/etc/* /etc

#
# setup database templates
#
mysql_install_db --user=mysql --datadir=/var/lib/mysql/01
mysql_install_db --user=mysql --datadir=/var/lib/mysql/02

#
# setup service links
#
ln --force --symbolic /lib/init/upstart-job /etc/init.d/mysql01
ln --force --symbolic /lib/init/upstart-job /etc/init.d/mysql02

#
# start cluster members
#
service mysql01 start
service mysql02 start

#########################

sql="$folder/sql"
host=localhost
user="${cluster.root.username}"
pass="${cluster.root.password}"

#
# setup basic security
#
mysql --protocol=tcp --host="$host" --port=13301 --user="$user" < "$sql"/access.sql
mysql --protocol=tcp --host="$host" --port=13302 --user="$user" < "$sql"/access.sql

#
# setup replication
#
mysql --protocol=tcp --host="$host" --port=13301 --user="$user" --password="$pass" < "$sql"/member-01.sql
mysql --protocol=tcp --host="$host" --port=13302 --user="$user" --password="$pass" < "$sql"/member-02.sql

#
# setup databases and users (use 01, changes will replicate to 02)
#
mysql --protocol=tcp --host="$host" --port=13301 --user="$user" --password="$pass" < "$sql"/database.sql

#
# cleanup
#
rm --force --recursive "$folder"
