#!/bin/bash
set -euo pipefail

# {{{ ruby setup
if [ ! -e /opt/ruby/rbenv ]
then
  git clone --depth 1 https://github.com/rbenv/rbenv.git /opt/ruby/rbenv
  git clone --depth 1 https://github.com/rbenv/ruby-build.git /opt/ruby/rbenv/plugins/ruby-build
fi

export PATH=/opt/ruby/rbenv/bin:$PATH
export RBENV_ROOT=/opt/ruby/rbenv
eval "$(rbenv init -)"

rbenv global 2.3.0 || {
  rbenv install 2.3.0
  rbenv global 2.3.0
}

if [ ! -e "$(which bundle)" ]
then
  gem install bundler
fi

# }}}

# {{{ nodejs setup

if [ ! -e /opt/node/nodenv ]
then
  git clone --depth 1 https://github.com/OiNutter/nodenv.git /opt/node/nodenv
  git clone --depth 1 https://github.com/OiNutter/node-build.git /opt/node/nodenv/plugins/node-build
fi

export PATH=/opt/node/nodenv/bin:$PATH
export NODENV_ROOT=/opt/node/nodenv
eval "$(nodenv init -)"

nodenv global 0.12.7 || {
  nodenv install 0.12.7
  nodenv global 0.12.7
}

# }}}

cd /opt/app
make
