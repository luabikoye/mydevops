#!/bin/bash
echo "Files with world-writable permissions:"
find / -type f -perm -002 2>/dev/null | head -20
echo ""
echo "Files with SUID bit set:"
find / -type f -perm /4000 2>/dev/null | head -20
echo ""
echo "Recent modified files (last 24 hours):"
find / -type f -mtime -1 2>/dev/null | head -20