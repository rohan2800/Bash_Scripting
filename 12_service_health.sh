#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <service_name>"
    exit 2
fi

service="$1"

echo "================================"
echo "     service health check"
echo "================================"
echo

echo "Service: $1"

if systemctl is-active --quiet "$service"; then
    echo "Status: ACTIVE"
    status=0
else
    echo "Status: INACTIVE"
    status=1
fi

echo
echo "================================"
echo "     Health check completed"
echo "================================"

exit "$status"
