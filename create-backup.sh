#!/bin/bash

# Backup destination
BACKUP_DEST="" #<where to save the backup>

# Date format for the backup folder/filename
DATE=$(date +'%Y-%m-%d')

# Backup archive name
BACKUP_ARCHIVE="$BACKUP_DEST/$DATE.tar.gz"

# Log file location
LOG_FILE="$BACKUP_DEST/backup_log.txt"

# ============================
# Functions
# ============================

# Function to log messages
log_message() {
    echo "$(date +'%Y-%m-%d %H:%M') - $1" >> "$LOG_FILE"
}

# Function to check if backup destination exists
check_backup_destination() {
    if [ ! -d "$BACKUP_DEST" ]; then
        log_message "Backup destination '$BACKUP_DEST' does not exist. Creating it now..."
        mkdir -p "$BACKUP_DEST"
        if [ $? -eq 0 ]; then
            log_message "Backup destination created successfully."
        else
            log_message "Failed to create backup destination. Exiting script."
            exit 1
        fi
    fi
}

# Function to perform backup
perform_backup() {
    log_message "Starting backup at $DATE"
    
    # Create a tarball of the source directories
    tar -czf "$BACKUP_ARCHIVE" "<INSERT SOURCE DIRECTORY>" #substitute the source directory to which folder to back up
    
    if [ $? -eq 0 ]; then
        log_message "Backup completed successfully: $BACKUP_ARCHIVE"
    else
        log_message "Backup failed."
        exit 1
    fi
}

# Function to delete old backup

# **Uncomment  the below function to delete any old backups**
# delete_old_backup() {
#     log_message "Deleting old backup..."
#     find "$BACKUP_DEST" -type f -name "*.tar.gz" ! -name "${DATE}.tar.gz" -exec rm {} \;
#     log_message "Deleted"
# }

# ============================
# Main Script
# ============================

# Check if the backup destination exists, if not create it
check_backup_destination
perform_backup
# delete_old_backup
log_message "Backup process finished"
echo "-----------------" >> "$LOG_FILE"

# End of Script