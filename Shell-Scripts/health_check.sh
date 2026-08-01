#!/bin/bash

echo "=== System Health Check ==="

echo "- Disk Space (Root) -"
df -h / | awk 'NR==2 {print "Usage: " $5 " (Free: " $4 ")"}'

echo "- Memory Usage -"
free -m | awk 'NR==2 {printf "Usage: %sMB / %sMB (%.2f%%)\n", $3, $2, $3*100/$2}'

echo "- CPU Load (1, 5, 15 min) -"
uptime | awk -F'load average:' '{ print $2 }' | xargs

echo "- Uptime -"
uptime -p