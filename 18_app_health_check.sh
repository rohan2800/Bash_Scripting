#!/bin/bash

APP_NAME="$1"
PORT="$2"
URL="$3"

if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <process_name> <port> <url>"
    exit 2
fi

echo "========================================"
echo "       APPLICATION HEALTH CHECK"
echo "========================================"
echo
echo "Application : $APP_NAME"
echo "Port        : $PORT"
echo "URL         : $URL"
echo

health_status=0

echo "----------------------------------------"
echo "1. Process Check"
echo "----------------------------------------"

if pgrep -x "$APP_NAME" > /dev/null; then
    echo "Process : RUNNING"
else
    echo "Process : NOT RUNNING"
    health_status=1
fi

echo
echo "----------------------------------------"
echo "2. Port Check"
echo "----------------------------------------"

if ss -lnt | grep -q ":$PORT "; then
    echo "Port : LISTENING"
else
    echo "Port : NOT LISTENING"
    health_status=1
fi

echo
echo "----------------------------------------"
echo "3. HTTP Health Check"
echo "----------------------------------------"

if curl -fsS --max-time 5 "$URL" > /dev/null; then
    echo "HTTP : HEALTHY"
else
    echo "HTTP : UNHEALTHY"
    health_status=1
fi

echo
echo "----------------------------------------"

if [ "$health_status" -eq 0 ]; then
    echo "Overall Status : HEALTHY"
else
    echo "Overall Status : UNHEALTHY"
fi

echo "----------------------------------------"

echo
echo "========================================"
echo "       Health check completed"
echo "========================================"

exit "$health_status"
