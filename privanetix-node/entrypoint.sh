#!/bin/sh
set -e

# Create the /app/config folder if it doesn't exist
mkdir -p /app/config

# If PRIVATE_KEY is set and non-empty, generate a new keystore via curl
if [ -n "${PRIVATE_KEY}" ]; then
  echo "PRIVATE_KEY detected. Generating a new keystore..."

  if [ -z "${API_URL}" ]; then
    echo "ERROR: PRIVATE_KEY is set but API_URL is missing. Aborting!"
    exit 1
  fi

  if [ -z "${API_KEY}" ]; then
    echo "ERROR: PRIVATE_KEY is set but API_KEY is missing. Aborting!"
    exit 1
  fi

  wget --quiet \
    --header="Content-Type: application/json" \
    --header "api-key:${API_KEY}" \
    --post-data="{\"privateKey\":\"${PRIVATE_KEY}\",\"password\":\"${KEYSTORE_PASSWORD}\"}" \
    -O /app/config/wallet_keystore \
    "${API_URL}"
else
  # Otherwise, use KEYSTORE_CONTENT as the wallet keystore file
  echo "No PRIVATE_KEY provided. Using existing KEYSTORE_CONTENT..."
  echo "${KEYSTORE_CONTENT}" > /app/config/wallet_keystore
fi

# Export KEYSTORE_PASSWORD so ./node-calc can access it
export KEYSTORE_PASSWORD="${KEYSTORE_PASSWORD}"

# Run the default command from the base image
exec ./node-calc "$@"
