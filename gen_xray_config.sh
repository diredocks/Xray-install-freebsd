#!/bin/sh

UUID=$(xray uuid)
RANDOM_HEX=$(openssl rand -hex 1)
KEY_OUTPUT=$(xray x25519)

PRIVATE_KEY=$(echo "$KEY_OUTPUT" | grep 'Private key:' | awk '{print $3}')
PUBLIC_KEY=$(echo "$KEY_OUTPUT" | grep 'Public key:' | awk '{print $3}')

echo "UUID: $UUID"
echo "Short ID: $RANDOM_HEX"
echo "Public Key: $PUBLIC_KEY"

jq -n \
  --arg uuid "$UUID" \
  --arg random_hex "$RANDOM_HEX" \
  --arg private_key "$PRIVATE_KEY" \
  '{
    "inbounds": [
        {
            "listen": "0.0.0.0",
            "port": 443,
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "id": $uuid,
                        "flow": "xtls-rprx-vision"
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "tcp",
                "security": "reality",
                "realitySettings": {
                    "show": false,
                    "dest": "www.microsoft.com:443",
                    "xver": 0,
                    "serverNames": [
                        "www.microsoft.com"
                    ],
                    "privateKey": $private_key,
                    "minClientVer": "",
                    "maxClientVer": "",
                    "maxTimeDiff": 0,
                    "shortIds": [
                        $random_hex
                    ]
                }
            },
            "sniffing": {
                "enabled": true,
                "destOverride": [
                    "http",
                    "tls"
                ]
            }
        }
    ]
  }' > 05_inbounds.json

