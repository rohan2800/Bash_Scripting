#!/bin/bash

# ==========================================
#        HARD LINK BACKUP MANAGER
# ==========================================

check_source() {

    if [ ! -d "$source" ]; then
        echo "ERROR: Source directory does not exist"
        exit 1
    fi

    echo "Checking source... OK"
}


create_backup_dir() {

    if [ ! -d "$backup" ]; then
        echo "Backup directory does not exist."
        echo "Creating backup directory..."

        mkdir -p "$backup"

        if [ $? -ne 0 ]; then
            echo "ERROR: Failed to create backup directory"
            exit 1
        fi
    fi

    echo "Checking backup directory... OK"
}


create_backup() {

    timestamp=$(date +"%Y-%m-%d_%H%M%S")

    backup_snapshot="$backup/app_$timestamp"

    echo "Creating backup..."
    mkdir -p "$backup_snapshot"

    # Create hard links for every file
    find "$source" -type f | while read -r file
    do
        relative_path="${file#$source/}"

        destination="$backup_snapshot/$relative_path"

        destination_dir=$(dirname "$destination")

        mkdir -p "$destination_dir"

        ln "$file" "$destination"
    done

    echo
    echo "Backup created successfully:"
    echo "$backup_snapshot"
}


# ==========================================
# Argument validation
# ==========================================

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <source_directory> <backup_directory>"
    exit 1
fi


# ==========================================
# Variables
# ==========================================

source="$1"
backup="$2"


# ==========================================
# Main
# ==========================================

echo "================================"
echo "       BACKUP MANAGER"
echo "================================"
echo

echo "Source : $source"
echo "Backup : $backup"
echo

check_source
create_backup_dir
create_backup

echo
echo "================================"
echo "Backup completed"
echo "================================"
