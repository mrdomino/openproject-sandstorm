all: openproject-setup

openproject-setup: openproject-ce/.git /opt/ruby/openproject-ce-bundle initdb.sqlite3

openproject-ce/.git:
	git submodule update --init --recursive

/opt/ruby/openproject-ce-bundle:
	cd openproject-ce && bundle install --path /opt/ruby/openproject-ce-bundle --without mysql postgres development test therubyracer docker --jobs 1 --standalone

initdb.sqlite3: openproject-ce/.bundle
	rm -rf db
	mkdir db
	find /opt/ruby/openproject-ce-bundle -type f -name "jquery.atwho.js" -exec sed -i 's/@ sourceMappingURL=jquery.caret.map//g' {} \;
	cd openproject-ce && SECRET_KEY_BASE='not so secret' RAILS_ENV=production ./bin/rake db:create db:migrate db:seed && SECRET_KEY_BASE='not so secret' RAILS_ENV=production ./bin/rake assets:precompile
	mv db/db.sqlite3 initdb.sqlite3
	rm -rf db
	ln -s /var/sqlite3 db
