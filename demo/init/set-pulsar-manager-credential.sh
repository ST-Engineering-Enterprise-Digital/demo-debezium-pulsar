#!/bin/sh

# Wait for the web service to be up
while ! curl -s http://pulsar-manager:7750 > /dev/null; do
  echo "Waiting for Pulsar Manager to start..."
  sleep 2
done

echo "Pulsar Manager started..."

# Obtain CSRF token and set the username and password
CSRF_TOKEN=$(curl -s http://pulsar-manager:7750/pulsar-manager/csrf-token)
OUTPUT=$(curl -s \
    -H "X-XSRF-TOKEN: $CSRF_TOKEN" \
    -H "Cookie: XSRF-TOKEN=$CSRF_TOKEN;" \
    -H 'Content-Type: application/json' \
    -X PUT http://pulsar-manager:7750/pulsar-manager/users/superuser \
    -d '{"name": "admin", "password": "apachepulsar", "description": "test", "email": "username@test.org"}')

echo "$OUTPUT"

# Exit the script
exit 0