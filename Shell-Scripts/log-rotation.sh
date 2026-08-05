#!/bin/bash

# Configuration
LOG_FILE="/var/log/myapp/app.log"       # The active log file to rotate
ARCHIVE_DIR="/var/log/myapp/archive"    # Where compressed logs go
RETENTION_DAYS=14                       # Days to keep old logs
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
ARCHIVE_FILE="$ARCHIVE_DIR/app_$TIMESTAMP.log.gz"

# Ensure archive directory exists
mkdir -p "$ARCHIVE_DIR"

# Check if log file exists and actually has data
if [ ! -s "$LOG_FILE" ]; then
  echo "Log file is empty or missing. Exiting."
  exit 0
fi

# Copy the log data and compress it directly into the archive directory
cat "$LOG_FILE" | gzip > "$ARCHIVE_FILE"

# Verify gzip succeeded before truncating
if [ $? -eq 0 ]; then
  # Empty the original log file without changing its inode/permissions
  > "$LOG_FILE"
  echo "Log successfully rotated to $ARCHIVE_FILE"
else
  echo "Error: Log compression failed!" >&2
  exit 1
fi

# Clean up logs older than retention period
echo "Cleaning up archives older than $RETENTION_DAYS days..."
find "$ARCHIVE_DIR" -type f -name "app_*.log.gz" -mtime +$RETENTION_DAYS -exec rm {} \;

echo "Log rotation complete."