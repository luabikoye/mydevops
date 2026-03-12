#!/bin/bash
THRESHOLD=10
EMAIL="luabikoye@yahoo.com"
USAGE=$(df / | awk 'NR==2 {print $5}' | cut -d'%' -f1)
if [ "$USAGE" -gt "$THRESHOLD" ]; then
  df -h | mail -s "Disk Space Alert: $USAGE%" $EMAIL
fi