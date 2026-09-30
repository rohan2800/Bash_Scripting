#!/bin/bash

# ========================================
#       CONFIGURATION VALIDATOR
# ========================================

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <config_file>"
    exit 2
fi

config_file="$1"

echo "========================================"
echo "       CONFIGURATION VALIDATOR"
echo "========================================"
echo
echo "Configuration : $config_file"
echo
echo "Checking configuration..."
echo

# Check whether file exists
if [ ! -f "$config_file" ]; then
    echo "Status: INVALID"
    echo "Reason: Configuration file not found"
    exit 1
fi

# Check whether file is empty
if [ ! -s "$config_file" ]; then
    echo "Status: INVALID"
    echo "Reason: Configuration file is empty"
    exit 1
fi

# Required variables
required_vars=(
    "APP_NAME"
    "APP_ENV"
    "APP_PORT"
    "DB_HOST"
    "DB_PORT"
)

missing_vars=()
invalid_vars=()

# Check every required variable
for required in "${required_vars[@]}"
do
    found=0

    while IFS= read -r line
    do
        # Skip empty lines
        [ -z "$line" ] && continue

        # Skip comments
        [[ "$line" == \#* ]] && continue

        key="${line%%=*}"
        value="${line#*=}"

        if [ "$key" = "$required" ]; then
            found=1

            if [ -z "$value" ]; then
                invalid_vars+=("$required")
            fi

            break
        fi

    done < "$config_file"

    if [ "$found" -eq 0 ]; then
        missing_vars+=("$required")
    fi
done

# Display missing variables
if [ "${#missing_vars[@]}" -gt 0 ]; then
    echo "Status: INVALID"
    echo
    echo "Missing variables:"

    for variable in "${missing_vars[@]}"
    do
        echo "  $variable"
    done
fi

# Display variables with empty values
if [ "${#invalid_vars[@]}" -gt 0 ]; then

    if [ "${#missing_vars[@]}" -eq 0 ]; then
        echo "Status: INVALID"
    fi

    echo
    echo "Invalid variables:"

    for variable in "${invalid_vars[@]}"
    do
        echo "  $variable"
    done
fi

# Final status
if [ "${#missing_vars[@]}" -gt 0 ] || [ "${#invalid_vars[@]}" -gt 0 ]; then
    echo
    echo "========================================"
    echo "       Validation failed"
    echo "========================================"
    exit 1
fi

echo "Status: VALID"
echo
echo "All required variables are present."
echo
echo "========================================"
echo "       Validation completed"
echo "========================================"

exit 0
