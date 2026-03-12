#!/bin/bash
echo "Last 10 User Logins:"
lastlog -t 1 | head -11
echo ""
echo "Currently Logged In Users:"
w -h
echo ""
echo "Failed Login Attempts (last 24 hours):"
grep "Failed password" /var/log/auth.log | tail -20 | wc -l