#!/bin/bash

echo "=== OS VERSION ==="
cat /etc/os-release
uname -a

echo
echo "=== BASH USERS ==="
grep "/bin/bash$" /etc/passwd

echo
echo "=== OPEN PORTS ==="
ss -tlnp 2>/dev/null || netstat -tlnp 2>/dev/null 