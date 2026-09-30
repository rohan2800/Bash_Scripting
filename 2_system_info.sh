#!/bin/bash

echo "=============================="
echo "       SYSTEM INFORMATION"
echo "=============================="
echo
echo "Hostname: $(hostname)"
echo "Current User: $(whoami)"
echo "Current Date: $(date)"
echo "Kernel: $(uname -r)"
echo "Uptime: $(uptime -p)"
echo "Current Directory: $(pwd)"
echo "=============================="
