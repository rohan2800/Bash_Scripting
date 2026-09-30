#!/bin/bash

if [ "$#" -eq 0 ]; then
    echo "Usage: $0 <server1> <server2> <server3>"
    exit 1
fi

echo
echo "================================"
echo "    Server health check"
echo "================================"

for server in "$@"; do

    echo
    echo "Checking: $server"

    if ping -c 1 -W 2 "$server" &>/dev/null; then
        echo "Status: UP"
    else
        echo "Status: DOWN"
    fi

done

echo
echo "================================"
echo "    Health check completed"
echo "================================"

