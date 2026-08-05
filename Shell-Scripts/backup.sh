#!/bin/bash

# Configuration
SOURCE_DIR="/var/www/html"       # Change this to the directory you want to back up
BACKUP_DIR="/opt/backups"        # Change this to your destination directory
RETENTION_DAYS=7
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="$BACKUP_DIR/backup_$TIMESTAMP.tar.gz"

# Ensure the backup directory exists
mkdir -p "$BACKUP_DIR"

echo "Starting backup of $SOURCE_DIR..."

# Create the compressed archive
tar -czf "$BACKUP_FILE" "$SOURCE_DIR"

# Verify if the tar command succeeded
if [ $? -eq 0 ]; then
  echo "Backup successful: $BACKUP_FILE"
else
  echo "Error: Backup failed!" >&2
  exit 1
fi

# Clean up old backups
echo "Removing backups older than $RETENTION_DAYS days..."
find "$BACKUP_DIR" -type f -name "backup_*.tar.gz" -mtime +$RETENTION_DAYS -exec rm {} \;

echo "Backup process complete."