#!/bin/bash
echo "Open Ports and Services:"
netstat -tulpn | grep LISTEN | awk '{print $4, $7}' | while read port service
do
  echo "Port: $port Service: $service"
done