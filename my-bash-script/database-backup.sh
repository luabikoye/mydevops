#!/bin/bash
DB_USER="root"
DB_PASSWORD="your_password"
BACKUP_DIR="/backups/mysql"
DATE=$(date +%Y%m%d_%H%M%S)
mkdir -p $BACKUP_DIR
mysqldump -u $DB_USER -p$DB_PASSWORD --all-databases | gzip > $BACKUP_DIR/db_backup_$DATE.sql.gz
echo "Database backup created: $DATE