#!/bin/bash

if [ -f /app/tmp/pids/server.pid ]; then
  echo 'REMOVE RAILS PID'
  rm /tmp/rails_server.pid
fi

if [[ $RAILS_ENV != "production" ]]; then
  echo "RUN BUNDLE CHECK AND INSTALL"
  bundle check || bundle install
fi

exec "$@"
