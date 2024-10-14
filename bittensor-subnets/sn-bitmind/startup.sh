#!/bin/sh

# Check if required environment variables are set
if [ -z "$COLDKEY_MNEMONIC" ] || [ -z "$HOTKEY_MNEMONIC" ]; then
    echo "Error: Required environment variables are not set."
    echo "Please ensure COLDKEY_MNEMONIC, and HOTKEY_MNEMONIC are set."
    exit 1
fi

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
btcli wallet regen_coldkey --wallet.name default --mnemonic "$COLDKEY_MNEMONIC" --no-use-password -p ~/.bittensor/wallets/

# Regenerate hotkey
echo "Regenerating hotkey..."
btcli wallet regen_hotkey --wallet.name default --mnemonic "$HOTKEY_MNEMONIC" --wallet.hotkey default -p ~/.bittensor/wallets/

# List wallets to verify creation
echo "Listing wallets..."
btcli wallet list -p ~/.bittensor/wallets/

# Run the miner
echo "Registering miner..."
btcli s register --netuid 168 --wallet.name default --wallet.hotkey default --subtensor.network test --no-prompt --wallet-path ~/.bittensor/wallets/

echo "Starting miner..."
pm2 start run_neuron.py --name bitmind-miner --log ~/.pm2/logs/bitmind-miner.log -- --miner

# Display the logs
pm2 logs bitmind-miner
