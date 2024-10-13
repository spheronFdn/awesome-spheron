#!/bin/sh

# Check if required environment variables are set
if [ -z "$COLDKEY_MNEMONIC" ] || [ -z "$HOTKEY_MNEMONIC" ] || [ -z "$HF_REPO_ID" ] || [ -z "$AVG_LOSS_UPLOAD_THRESHOLD" ]; then
    echo "Error: Required environment variables are not set."
    echo "Please ensure COLDKEY_MNEMONIC, HOTKEY_MNEMONIC, HF_REPO_ID, and AVG_LOSS_UPLOAD_THRESHOLD are set."
    exit 1
fi

# Regenerate coldkey
btcli wallet regen_coldkey --wallet.name miner --mnemonic "$COLDKEY_MNEMONIC" --no-use-password -p ~/.bittensor/wallets/

# Regenerate hotkey
btcli wallet regen_hotkey --wallet.name miner --mnemonic "$HOTKEY_MNEMONIC" --wallet.hotkey default -p ~/.bittensor/wallets/

# List wallets to verify creation
btcli wallet list -p ~/.bittensor/wallets/

# Run the miner
python neurons/miner.py --wallet.name miner --wallet.hotkey default --hf_repo_id "$HF_REPO_ID" --avg_loss_upload_threshold "$AVG_LOSS_UPLOAD_THRESHOLD"
