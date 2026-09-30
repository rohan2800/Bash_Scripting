#!/bin/bash

if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <environment> <version> <service>"
    exit 2
fi

environment="$1"
version="$2"
service="$3"

echo "========================================"
echo "       DEPLOYMENT VALIDATOR"
echo "========================================"
echo
echo "Environment : $environment"
echo "Version     : $version"
echo "Service     : $service"
echo
echo "----------------------------------------"

status=0

# ========================================
# Environment validation
# ========================================

case "$environment" in
    dev|staging|production)
        echo "Environment validation : PASS"
        ;;
    *)
        echo "Environment validation : FAIL"
        echo "Reason: Invalid environment"
        status=1
        ;;
esac

# ========================================
# Version validation
# ========================================

if [[ "$version" =~ ^v[0-9]+$ ]]; then
    echo "Version validation     : PASS"
else
    echo "Version validation     : FAIL"
    echo "Reason: Invalid version"
    status=1
fi

# ========================================
# Service validation
# ========================================

service_found=0

while IFS= read -r line
do
    service_name="${line%% *}"

    if [ "$service_name" = "${service}.service" ]; then
        service_found=1
        break
    fi

done < <(systemctl list-unit-files --type=service --no-legend)

if [ "$service_found" -eq 1 ]; then
    echo "Service validation     : PASS"
else
    echo "Service validation     : FAIL"
    echo "Reason: Service does not exist"
    status=1
fi

echo "----------------------------------------"

# ========================================
# Final result
# ========================================

if [ "$status" -eq 0 ]; then
    echo
    echo "Deployment request: VALID"
else
    echo
    echo "Deployment request: INVALID"
fi

echo
echo "========================================"
echo "         Validation completed"
echo "========================================"

exit "$status"
