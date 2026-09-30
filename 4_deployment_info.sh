#!/bin/bash

if [ "$#" -ne 3 ]; then
    echo
    echo "ERROR: Exactly 3 arguments are required."
    echo "Usage: $0 <environment> <version> <service>"
    echo
    exit 1
fi

environment="$1"
version="$2"
service="$3"

server=$(hostname)
user=$(whoami)
directory=$(pwd)

echo
echo "Script name: $0"
echo

if [ "$1" = "dev" ]; then
    echo "Development environment"

elif [ "$1" = "staging" ]; then
    echo "Staging environment"

elif [ "$1" = "production" ]; then
    echo "Production environment"

else
    echo "Invalid environment"
    echo "Environments are dev, staging and production"
    exit 1
fi

echo "========================================"
echo " DEPLOYMENT INFORMATION"
echo "========================================"
echo

echo "Environment: $environment"
echo "Version: $version"
echo "Service: $service"
echo

echo "Server: $(hostname)"
echo "User: $USER"
echo "Directory: $(pwd)"
echo
echo "Number of Arguments : $#"
echo

echo "========================================"
