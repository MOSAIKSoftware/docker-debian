#!/bin/bash
host="$1"
shift
port="$1"
shift

# Wait until PostgreSQL started and listens on port 5432.
while ! nc -z "$host" "$port"; do
  echo "Waiting for $host $port to start ..."
  sleep 1
done
echo ' started.'

# Start server.
echo 'Starting server...'
exec "$@"
