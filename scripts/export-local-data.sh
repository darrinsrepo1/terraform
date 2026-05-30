#!/bin/bash

HOST_NAME="$(hostname)"
IP="$(ip -4 -o addr show | grep "192." | awk '{print $4}' | cut -d/ -f1 | head -n 1)"
NET_INTERFACE="$(ip -4 -o addr show | grep "192." | awk '{print $2}')"

echo "{\
\"hostname\": \"$HOST_NAME\", \
\"ip\": \"$IP\", \
\"net_interface\": \"$NET_INTERFACE\"\
}"
