#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <process_name>"
    exit 2
fi

process="$1"

echo "================================"
echo "       PROCESS MONITOR"
echo "================================"
echo
echo "Process: $process"

if pgrep "$process" > /dev/null; then
    echo "Status: RUNNING"
    status=0
else
    echo "Status: NOT RUNNING"
    status=1
fi

echo
echo "================================"
echo "       Monitor completed"
echo "================================"

exit "$status"
