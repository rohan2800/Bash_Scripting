#!/bin/bash

echo "========================================"
echo "          SERVER INFORMATION"
echo "========================================"

read -p "Enter your name: " name
read -p "Enter environment: " env
echo
echo "Hello $name!"
echo
echo "Environment: $env"
echo "Hostname: $(hostname)"
echo "User: $USER"
echo "Home: $HOME"
echo "Shell: $SHELL"
echo "Kernel: $(uname -r)"
echo
echo "========================================"
