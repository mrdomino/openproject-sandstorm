set -x -e

mkdir -p /var/log
mkdir -p /var/sqlite3
mkdir -p /var/migrations
touch /var/migrations/20160125143638
cp initdb.sqlite3 /var/sqlite3/db.sqlite3

type source

source continue.sh
