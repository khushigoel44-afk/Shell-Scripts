#!/bin/bash
# The Source Directory whose backup is needed..
SOURCE_DIR="/home/khushi/my_website"
# The Backup Directory where the Source Directory data will be stored as a Backup..
BACKUP_DIR="/home/khushi/backup"
# This ensures how many days will the system hold the backup for..
RETENTION_DAYS=7
# This holds the current date and time - mainly to increase the readibilty of the backup file name.. 
TIMESTAMP=$(date +'%Y-%m-%d_%H-%M-%S')
# This is the file name inside the backup directory - mainly increases the readibilty..
# .tar.gz is the extension that simply indicates that the file is in the zip format..
BACKUP_FILES="$BACKUP_DIR/backup_$TIMESTAMP.tar.gz"

# Creates a backup folder if not created already..
# -p ensures that no error is displayed if the folder already exists.. 
mkdir -p "$BACKUP_DIR"

# Simple msg is displayed indicating that the backup process has started start.. 
echo "Starting the Backup for $SOURCE_DIR..."

# -c means that an archive of the backup folder is created..
# -z indicates that minimum space is taken by the backup folder in the hard disk..
# -f means that the following string should be used as a filename for the archieve..
tar -czf "$BACKUP_FILES" "$SOURCE_DIR"

# $? indicates the boolean result of the last executed command..
# if the last command executed successfully - returns 0 else 1
# If the last command executed successfully, display - Backup Done Successfully for the source file
# else display - Backup Failed due to some error! for the source file and exit with exit 1 code..
if [ $? -eq 0 ]; then
        echo "Backup Done Successfully: $SOURCE_DIR"
else
        echo "Backup Failed due to some error!: $SOURCE_DIR"
        exit 1
fi


# Ensures that the outdated data is removed from the system time to time..
echo "Removing the Backup data older than $RETENTION_DAYS"

# find: indicates that we need to look for the files inside the backup_dir directory..
# -type f: indicates that we are to look only for the files and not any folder..
# -name: indicates that we are to look for only certain type of files only - backup_*.tar.gz
# -mtime: indicates that this command runs only when the backup file's date exceeds the time limit of "$RETENTION_DAYS"
# -exec rm {} \: indicates that the file should be removed frome the system since the "$RETENTION_DAYS" has reached..
find "$BACKUP_DIR" -type f -name "backup_*.tar.gz" -mtime +"$RETENTION_DAYS" -exec rm {} \;

# Final msg is displayed once everything works fine!..
echo "Backup completed - created and deleted the ones older than $RETENTION_DAYS"