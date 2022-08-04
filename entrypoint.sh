#!/usr/bin/env bash

if [ ! -d "/usr/src/app/node_modules" ]
then
  npm install
  # If you are building your code for production
  # RUN npm ci --only=production
fi
# Execute Docker CMD
exec "$@"
