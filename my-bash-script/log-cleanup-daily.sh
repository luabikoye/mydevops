#!/bin/bash
LOG_DIR="/var/log"
DAYS_OLD=30
find $LOG_DIR -name "*.log" -type f -mtime +$DAYS_OLD -exec rm {} \;
find $LOG_DIR -name "*.gz" -type f -mtime +$DAYS_OLD -exec rm {} \;
echo "Old logs removed from $LOG_DIR"