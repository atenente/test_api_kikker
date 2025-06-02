#! /bin/sh

set -e

bundle check || bundle install --jobs 5 --retry 5

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

if [ "$RAILS_ENV" != development ]; then
  echo '---> Running Migrations'
  rails db:migrations
  echo '---> End of migrations'
else
  echo '---> skip migrations for Dev env'
fi

exec "$@" #comando para o docker compose