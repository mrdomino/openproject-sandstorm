#!/bin/bash
set -euo pipefail

# This file is adapted from the openproject manual installation guide:
# https://www.openproject.org/open-source/manual-installation/manual-installation-guide/

export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y --no-install-recommends          \
    zlib1g-dev build-essential                      \
    libssl-dev libreadline-dev                      \
    libyaml-dev libgdbm-dev                         \
    libncurses5-dev automake                        \
    imagemagick libmagickcore-dev libmagickwand-dev \
    libtool bison libffi-dev git curl               \
    libxml2 libxml2-dev libxslt1-dev                \
    mysql-server libmysqlclient-dev

service mysql stop
systemctl disable mysql

sed --in-place='' \
    --expression='s/^user\t\t= mysql/#user\t\t= mysql/' \
    /etc/mysql/my.cnf
cat <<EOF > /etc/mysql/conf.d/sandstorm.cnf
[mysqld]
# Set the transaction log file to the minimum size allowed to save disk space.
innodb_log_file_size = 1048576
# Set the main data file to grow by 1MB at a time, rather than 8MB at a time.
innodb_autoextend_increment = 1
EOF

mkdir -p /opt/ruby /opt/node /var/lib/mysql /var/log/mysql /var/run/mysqld
chown vagrant:vagrant /opt/ruby /opt/node /var/lib/mysql /var/log/mysql /var/run/mysqld

su -c "bash /opt/app/.sandstorm/unprivileged-setup.sh" vagrant
