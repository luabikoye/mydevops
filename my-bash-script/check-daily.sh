#!/bin/bash
echo "System Health Report"
echo "===================="
echo "Hostname: $(hostname)"
echo "Time: $(date)"
echo ""
echo "CPU Usage:"
top -bn1 | grep "Cpu(s)" | awk '{print "User: " $2 " System: " $4 " Idle: " $8}'
echo ""
echo "Memory Usage:"
free -h | awk '/^Mem:/ {print "Total: " $2 " Used: " $3 " Free: " $4}'
echo ""
echo "Disk Usage:"
df -h / | awk 'NR==2 {print "Used: " $3 " Available: " $4 " Usage: " $5}'
echo ""
echo "Load Average:"
uptime | awk -F'load average:' '{print $2}'