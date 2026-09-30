#!/bin/bash

# ==========================================
# Service Manager
# Install / Start / Stop / Restart / Enable
# ==========================================

set -e

ACTION=$1
SERVICE=$2

# -------------------------------
# Check arguments
# -------------------------------

if [ $# -ne 2 ]; then
    echo "Usage: $0 {install|start|stop|restart|enable|status} <service>"
    exit 1
fi

# -------------------------------
# Check root
# -------------------------------

if [ "$EUID" -ne 0 ]; then
    echo "Error: Please run this script with sudo."
    echo "Example: sudo $0 $ACTION $SERVICE"
    exit 1
fi

# -------------------------------
# Functions
# -------------------------------

install_service() {

    echo "Installing $SERVICE..."

    if command -v apt-get &>/dev/null; then
        apt-get update
        apt-get install -y "$SERVICE"

    elif command -v dnf &>/dev/null; then
        dnf install -y "$SERVICE"

    elif command -v yum &>/dev/null; then
        yum install -y "$SERVICE"

    else
        echo "Error: Unsupported package manager."
        exit 1
    fi

    echo "$SERVICE installed successfully."
}


start_service() {

    echo "Starting $SERVICE..."

    systemctl start "$SERVICE"

    echo "$SERVICE started successfully."
}


stop_service() {

    echo "Stopping $SERVICE..."

    systemctl stop "$SERVICE"

    echo "$SERVICE stopped successfully."
}


restart_service() {

    echo "Restarting $SERVICE..."

    systemctl restart "$SERVICE"

    echo "$SERVICE restarted successfully."
}


enable_service() {

    echo "Enabling $SERVICE..."

    systemctl enable "$SERVICE"

    echo "$SERVICE enabled successfully."
}


status_service() {

    systemctl status "$SERVICE" --no-pager
}


# -------------------------------
# Action Handler
# -------------------------------

case "$ACTION" in

    install)
        install_service
        ;;

    start)
        start_service
        ;;

    stop)
        stop_service
        ;;

    restart)
        restart_service
        ;;

    enable)
        enable_service
        ;;

    status)
        status_service
        ;;

    *)
        echo "Invalid action: $ACTION"
        echo
        echo "Available actions:"
        echo "  install"
        echo "  start"
        echo "  stop"
        echo "  restart"
        echo "  enable"
        echo "  status"
        exit 1
        ;;

esac
