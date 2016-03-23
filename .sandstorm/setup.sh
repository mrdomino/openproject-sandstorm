#!/bin/bash
set -euo pipefail

# This file is adapted from the openproject manual installation guide:
# https://www.openproject.org/open-source/manual-installation/manual-installation-guide/

export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y zlib1g-dev build-essential       \
    libssl-dev libreadline-dev                      \
    libyaml-dev libgdbm-dev                         \
    libncurses5-dev automake                        \
    imagemagick libmagickcore-dev libmagickwand-dev \
    libtool bison libffi-dev git curl               \
    libxml2 libxml2-dev libxslt1-dev                \
    sqlite3

mkdir /opt/ruby /opt/node
chown vagrant:vagrant /opt/ruby /opt/node

su -c "bash /opt/app/.sandstorm/unprivileged-setup.sh" vagrant

exit 0
