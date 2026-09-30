#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <log_file>"
    exit 1
fi

log_file="$1"

if [ ! -f "$log_file" ]; then
    echo "Error: File not found: $log_file"
    exit 1
fi

error_count=0

while IFS= read -r line
do
    if [[ "$line" == *"ERROR"* ]]; then
        ((error_count++))
    fi
done < "$log_file"

echo "================================"
echo "         LOG MONITOR"
echo "================================"
echo
echo "Log File : $log_file"
echo "ERROR Count : $error_count"
echo
echo "================================"
