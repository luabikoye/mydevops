#!/bin/bash
echo "Top 5 CPU Consuming Processes:"
ps aux --sort=-%cpu | head -6
echo ""
echo "Top 5 Memory Consuming Processes:"
ps aux --sort=-%mem | head -6
echo ""
echo "Total Process Count:"
ps aux | wc -l