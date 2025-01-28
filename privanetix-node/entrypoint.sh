#!/bin/sh
set -e

# Create the /app/config folder if it doesn't exist
mkdir -p /app/config

# Write keystore file
echo "${KEYSTORE_CONTENT}" > /app/config/wallet_keystore
chmod 600 /app/config/wallet_keystore

export KEYSTORE_PASSWORD="${KEYSTORE_PASSWORD}"

# Then run the default command
exec ./node-calc "$@"
