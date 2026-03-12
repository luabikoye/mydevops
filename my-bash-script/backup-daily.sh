#!/bin/bash
BACKUP_DIR="/backups"
SOURCE_DIR="/var/www"
DAYS_TO_KEEP=7
DATE=$(date +%Y%m%d)
mkdir -p $BACKUP_DIR
tar czf $BACKUP_DIR/backup_$DATE.tar.gz $SOURCE_DIR
find $BACKUP_DIR -name "backup_*.tar.gz" -mtime +$DAYS_TO_KEEP -delete
echo "Backup completed: $DATE"