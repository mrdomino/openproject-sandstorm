export SECRET_KEY_BASE=`base64 /dev/urandom | head -c 30`

set -x -e

rm -rf /var/tmp
mkdir -p /var/tmp

rm -rf /var/run
mkdir -p /var/run
mkdir -p /var/run/mysqld

HOME=/etc/mysql mysqld 2>&1 | awk '{print "mysqld: " $0}' &

cd openproject-ce

export GEM_HOME=/opt/ruby/openproject-ce-bundle/ruby/2.3.0

if [ -f /var/migrations/20160125143638 ]
then
  echo no migration necessary
else
  RAILS_ENV=production ./bin/rake db:migrate
  mkdir -p /var/migrations/
  touch /var/migrations/20160125143638
fi

( while sleep 60
  do
    RUBYOPT=-r/opt/ruby/openproject-ce-bundle/bundler/setup RAILS_ENV=production ./bin/rake jobs:workoff
  done
) | awk '{print "jobs:workoff: " $0}' &
RUBYOPT=-r/opt/ruby/openproject-ce-bundle/bundler/setup RAILS_ENV=production ./bin/rails s -p 10000 -E production
