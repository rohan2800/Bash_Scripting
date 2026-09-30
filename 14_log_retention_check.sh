#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <log_directory> <retention_count>"
    exit 2
fi

log_dir="$1"
retention="$2"

if [ ! -d "$log_dir" ]; then
    echo "ERROR: Log directory not found"
    exit 1
fi

if ! [[ "$retention" =~ ^[1-9][0-9]*$ ]]; then
    echo "ERROR: Retention count must be a positive integer"
    exit 2
fi

rotated_count=0
old_logs=0

echo "========================================"
echo "       LOG RETENTION CHECK"
echo "========================================"
echo
echo "Log Directory : $log_dir"
echo "Retention     : $retention files"
echo
echo "Current Logs:"

while IFS= read -r file
do
    filename="${file##*/}"

    echo "  $filename"

    ((rotated_count++))

done < <(find "$log_dir" -maxdepth 1 -type f -name 'app.log.*' -print)

echo
echo "----------------------------------------"
echo "Logs exceeding retention:"

while IFS= read -r file
do
    filename="${file##*/}"
    number="${filename##*.}"

    if [ "$number" -gt "$retention" ]; then
        echo "  $filename"
        ((old_logs++))
    fi

done < <(find "$log_dir" -maxdepth 1 -type f -name 'app.log.*' -print)

echo
echo "Total rotated logs: $rotated_count"
echo "Retention: $retention"
echo "Old logs: $old_logs"

if [ "$old_logs" -gt 0 ]; then
    echo
    echo "Status: RETENTION VIOLATION"
    status=1
else
    echo
    echo "Status: RETENTION OK"
    status=0
fi

echo
echo "========================================"
echo "       Check completed"
echo "========================================"

exit "$status"
