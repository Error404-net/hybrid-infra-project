#!/bin/bash
# Ensure you're logged in to Bitwarden CLI

# Fetch the secret
SECRET=$(bw get password YOUR_ITEM_ID_HERE --session ${BW_SESSION})

# Output the secret in JSON format
jq -n --arg secret "$SECRET" '{"secret":$secret}'
