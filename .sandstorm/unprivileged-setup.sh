#!/bin/bash
set -euo pipefail

# {{{ ruby setup
cd /opt/ruby

git clone --depth 1 https://github.com/rbenv/rbenv.git /opt/ruby/rbenv
git clone --depth 1 https://github.com/rbenv/ruby-build.git /opt/ruby/rbenv/plugins/ruby-build

export PATH=/opt/ruby/rbenv/bin:$PATH
export RBENV_ROOT=/opt/ruby/rbenv
eval "$(rbenv init -)"

rbenv install 2.3.0
rbenv shell 2.3.0

gem install bundler

# }}}

# {{{ nodejs setup

git clone --depth 1 https://github.com/OiNutter/nodenv.git /opt/node/nodenv
git clone --depth 1 https://github.com/OiNutter/node-build.git /opt/node/nodenv/plugins/node-build

export PATH=/opt/node/nodenv/bin:$PATH
export NODENV_ROOT=/opt/node/nodenv
eval "$(nodenv init -)"

nodenv install 0.12.7
nodenv shell 0.12.7

# }}}

cd /opt/app
make
