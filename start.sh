set -x -e

mkdir -p /var/lib/mysql
mkdir -p /var/log
mkdir -p /var/log/mysql

mkdir -p /var/uploads
mkdir -p /var/migrations
touch /var/migrations/20160125143638
tar -xzf init_mysql.tar.gz -C /var/lib/mysql

type source

source continue.sh
