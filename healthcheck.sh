#!/bin/sh
set -e

HOST=${REDIS_HOST:-redis}

echo "Waiting for Redis at $HOST..."

until redis-cli -h "$HOST" ping | grep -q "PONG"; do
    echo "Redis not ready..."
    sleep 1
done

echo "Redis is healthy, starting Flask"

exec flask run --debug
