#!/bin/bash

# --- CONFIGURATION ---
SOURCE_DIR="/var/www/html"
BACKUP_DIR="/home/user/backups"
DATE=$(date +%Y-%m-%d_%H-%M-%S)
BACKUP_NAME="backup_$DATE.tar.gz"

# --- LOGIC ---

echo "Starting backup for $SOURCE_DIR..."

# 1. Check if Backup Directory exists, if not, create it
if [ ! -d "$BACKUP_DIR" ]; then
    echo "Creating backup directory: $BACKUP_DIR"
    mkdir -p "$BACKUP_DIR"
fi

# 2. Create the compressed archive
# tar -c (create) -z (gzip) -f (file)
tar -czf "$BACKUP_DIR/$BACKUP_NAME" "$SOURCE_DIR"

# 3. Check if the command was successful
if [ $? -eq 0 ]; then
    echo "Backup successfully created: $BACKUP_DIR/$BACKUP_NAME"
else
    echo "Backup failed!"
fi
