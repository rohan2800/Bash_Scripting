#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <username>"
    exit 1
fi

username="$1"

if ! getent passwd "$username" > /dev/null; then
    echo "ERROR: User '$username' not found"
    exit 1
fi

user_info=$(getent passwd "$username")

IFS=':' read -r username password uid gid fullname home shell <<< "$user_info"

echo "================================"
echo "       USER ACCOUNT AUDIT"
echo "================================"
echo
echo "Username: $username"
echo "UID: $uid"
echo "Home: $home"
echo "Shell: $shell"
echo
echo "================================"
echo "Audit completed"
echo "================================"
