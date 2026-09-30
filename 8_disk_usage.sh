#!/bin/bash

check_disk_usage() {

    echo "================================"
    echo "       DISK USAGE MONITOR"
    echo "================================"

    # Skip the df header
    df -h | {
        read -r header

        while read -r filesystem size used available usage mount
        do
            # Remove % from usage
            usage_number="${usage%\%}"

            echo
            echo "Filesystem: $filesystem"
            echo "Usage: $usage"

            if [ "$usage_number" -ge 80 ]; then
                echo "Status: WARNING"
            else
                echo "Status: HEALTHY"
            fi

        done
    }

    echo
    echo "================================"
    echo "Disk check completed"
    echo "================================"
}

check_disk_usage
