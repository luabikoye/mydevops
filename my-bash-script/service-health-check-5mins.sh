#!/bin/bash
SERVICES=("nginx" "mysql" "redis-server")
for service in "${SERVICES[@]}"
do
  if systemctl is-active --quiet $service; then
    echo "$service is running"
  else
    echo "$service is down. Attempting restart..."
    systemctl restart $service
    sleep 2
    if systemctl is-active --quiet $service; then
      echo "$service restarted successfully"
    else
      echo "Failed to restart $service"
    fi
  fi
done
