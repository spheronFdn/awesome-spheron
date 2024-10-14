#!/bin/sh

# Check if required environment variables are set
if [ -z "$COLDKEY_MNEMONIC" ] || [ -z "$HOTKEY_MNEMONIC" ]; then
    echo "Error: Required environment variables are not set."
    echo "Please ensure COLDKEY_MNEMONIC, and HOTKEY_MNEMONIC are set."
    exit 1
fi

# Function to find btcli
find_btcli() {
    btcli_path=$(which btcli 2>/dev/null)
    if [ -z "$btcli_path" ]; then
        echo "btcli not found in PATH. Attempting to find it..."
        btcli_path=$(find / -name btcli 2>/dev/null | head -n 1)
    fi
    echo "$btcli_path"
}

# Find or install btcli
btcli_path=$(find_btcli)
if [ -z "$btcli_path" ]; then
    echo "btcli not found. Attempting to install..."
    pip install bittensor
    export PATH="/root/.local/bin:$PATH"
    btcli_path=$(find_btcli)
fi

if [ -z "$btcli_path" ]; then
    echo "Error: Unable to find or install btcli. Exiting."
    exit 1
fi

# Add btcli directory to PATH
btcli_dir=$(dirname "$btcli_path")
export PATH="$btcli_dir:$PATH"

echo "Using btcli from: $btcli_path"
echo "Current PATH: $PATH"

# Function to run btcli commands
run_btcli() {
    echo "Running: btcli $@"
    btcli "$@"
}

# Create miner.env file with default settings
echo "# Default options:
DETECTOR=CAMO                                  # Options: CAMO, UCF, NPR
DETECTOR_CONFIG=camo.yaml                      # Configs live in base_miner/deepfake_detectors/configs
                                               # Supply a filename or relative path
DEVICE=cuda                                    # Options: cpu, cuda

# Subtensor Network Configuration:
NETUID=168                                     # Network User ID options: 34, 168
SUBTENSOR_NETWORK=test                         # Networks: finney, test, local
SUBTENSOR_CHAIN_ENDPOINT=wss://test.finney.opentensor.ai:443
                                               # Endpoints:
                                               # - wss://entrypoint-finney.opentensor.ai:443
                                               # - wss://test.finney.opentensor.ai:443/

# Wallet Configuration:
WALLET_NAME=default
WALLET_HOTKEY=default

# Miner Settings:
MINER_AXON_PORT=8091
BLACKLIST_FORCE_VALIDATOR_PERMIT=True          # Default setting to force validator permit for blacklisting" > miner.env

# Download data
echo "Downloading data..."
# python bitmind/download_data.py

# Regenerate coldkey
echo "Regenerating coldkey..."
run_btcli wallet regen_coldkey --wallet.name default --mnemonic "$COLDKEY_MNEMONIC" --no-use-password -p ~/.bittensor/wallets/

# Regenerate hotkey
echo "Regenerating hotkey..."
run_btcli wallet regen_hotkey --wallet.name default --mnemonic "$HOTKEY_MNEMONIC" --wallet.hotkey default -p ~/.bittensor/wallets/

# List wallets to verify creation
echo "Listing wallets..."
run_btcli wallet list -p ~/.bittensor/wallets/

# Run the miner
echo "Registering miner..."
run_btcli s register --netuid 168 --wallet.name default --wallet.hotkey default --subtensor.network test

echo "Starting miner..."
pm2 start run_neuron.py --name bitmind-miner --log ~/.pm2/logs/bitmind-miner.log -- --miner

# Display the logs
pm2 logs bitmind-miner
