#!/bin/bash

lock_file="/tmp/myapp-deploy.lock"

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 {start|status|release}"
    exit 2
fi

action="$1"

case "$action" in

    start)

        echo "========================================"
        echo "       DEPLOYMENT LOCK"
        echo "========================================"
        echo
        echo "Action: START"
        echo
        echo "Checking deployment lock..."
        echo

        if [ -f "$lock_file" ]; then

            read -r pid < "$lock_file"

            if kill -0 "$pid" 2>/dev/null; then
                echo "ERROR: Another deployment is already running."
                echo
                echo "Lock file: $lock_file"
                echo "PID: $pid"
                echo
                echo "Deployment aborted."
                exit 1
            else
                echo "Lock exists, but process is not running."
                echo "Removing stale lock..."
                rm -f "$lock_file"
            fi
        fi

        echo "$$" > "$lock_file"

        echo "Lock acquired."
        echo "Deployment can proceed."
        echo
        echo "PID: $$"
        echo "Lock file: $lock_file"
        echo
        echo "================================"

        exit 0
        ;;

    status)

        if [ ! -f "$lock_file" ]; then
            echo "Deployment lock: NOT ACTIVE"
            exit 0
        fi

        read -r pid < "$lock_file"

        if kill -0 "$pid" 2>/dev/null; then
            echo "Deployment lock: ACTIVE"
            echo "PID: $pid"
            exit 0
        else
            echo "Deployment lock: NOT ACTIVE"
            echo "Reason: Stale lock"
            exit 0
        fi
        ;;

    release)

        if [ ! -f "$lock_file" ]; then
            echo "No active deployment lock."
            exit 0
        fi

        rm -f "$lock_file"

        echo "Deployment lock released."
        exit 0
        ;;

    *)

        echo "Usage: $0 {start|status|release}"
        exit 2
        ;;

esac
