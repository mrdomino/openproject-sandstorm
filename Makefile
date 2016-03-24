all: openproject-setup

openproject-setup: openproject-ce/.git /opt/ruby/openproject-ce-bundle initdb.sqlite3

openproject-ce/.git:
	git submodule update --init --recursive

/opt/ruby/openproject-ce-bundle:
	cd openproject-ce && bundle install --path /opt/ruby/openproject-ce-bundle --without postgres sqlite development test therubyracer docker --jobs 1 --standalone && npm install

init_mysql.tar.gz: openproject-ce/.bundle
	rm -rf /var/lib/mysql
	mkdir -p /var/lib/mysql
	HOME=/etc/mysql /usr/bin/mysql_install_db --force
	HOME=/etc/mysql /usr/sbin/mysqld &
	cd openproject-ce && SECRET_KEY_BASE='not so secret' RAILS_ENV=production ./bin/rake db:create db:migrate db:seed && SECRET_KEY_BASE='not so secret' RAILS_ENV=production ./bin/rake assets:precompile
	killall mysqld
	tar -czf init_mysql.tar.gz -C /var/lib/mysql .
	rm -rf /var/lib/mysql /var/log/mysql /var/run/mysqld
