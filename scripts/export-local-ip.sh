#!/bin/bash

NAME="local-network-ipv4"
IP="$(ip -4 -o addr show | grep "192." | awk '{print $4}' | cut -d/ -f1)"

echo "{\"name\": \"$NAME\", \"ip\": \"$IP\"}"
