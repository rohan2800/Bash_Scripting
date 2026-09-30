#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <backup_file>"
    exit 2
fi

backup_file="$1"

echo "================================"
echo "       BACKUP VALIDATOR"
echo "================================"
echo
echo "File: $backup_file"

if [ ! -f "$backup_file" ]; then
    echo "Status: INVALID"
    echo "Reason: File not found"
    echo
    echo "================================"
    echo "      Terminate Validation"
    echo "================================"
    exit 1
fi

if [ ! -s "$backup_file" ]; then
    echo "Status: INVALID"
    echo "Reason: File is empty"
    echo
    echo "================================"
    echo "      Terminate Validation"
    echo "================================"
    exit 1
fi

read -r size _ <<< $(du -h "$backup_file")

echo "Status: VALID"
echo "Size: $size"

echo
echo "================================"
echo "      Validation completed"
echo "================================"

exit 0
