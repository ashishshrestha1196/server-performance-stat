#!/bin/bash
# server-stats.sh - Basic Server Performance Analyzer

echo "=============================================="
echo "         Server Performance Statistics"
echo "=============================================="

# OS and Kernel Info
echo "\n--- OS & Kernel Info ---"
if [ -f /etc/os-release ]; then
    . /etc/os-release
    echo "OS: $PRETTY_NAME"
fi
echo "Kernel: $(uname -r)"
echo "Hostname: $(hostname)"

# Uptime and Load
echo "\n--- Uptime & Load ---"
uptime -p
echo "Load Average: $(uptime | awk -F'load average:' '{ print $2 }')"

# Logged in Users
echo -e "\n--- Logged In Users ---"
who

# CPU Usage
if command -v mpstat >/dev/null 2>&1; then
    echo "mpstat is installed."
else
    echo "mpstat is NOT installed."
    echo "installing mpstat"
    if [ -f /etc/debian_version ]; then
        sudo apt update && sudo apt install sysstat
    elif [ -f /etc/redhat-release ]; then
        echo "  sudo yum install sysstat"
    else
        echo "  Please install sysstat using your distribution's package manager."
    fi
fi

echo "\n--- CPU Usage ---"
mpstat 1 1 | awk '/Average/ && $2 ~ /all/ {printf "CPU Usage: %.2f%%\n", 100 - $NF}'

# Memory Usage
echo "\n--- Memory Usage ---"
free -h | awk '
/Mem:/ {
    total=$2; used=$3; free=$4
    perc = (used/total)*100
    printf "Total: %s | Used: %s | Free: %s | Usage: %.2f%%\n", total, used, free, perc
}'

# Disk Usage
echo "\n--- Disk Usage (root filesystem) ---"
df -h / | awk 'NR==2 {printf "Total: %s | Used: %s | Free: %s | Usage: %s\n", $2, $3, $4, $5}'

# Top 5 processes by CPU
echo "\n--- Top 5 Processes by CPU Usage ---"
ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 6

# Top 5 processes by Memory
echo "\n--- Top 5 Processes by Memory Usage ---"
ps -eo pid,comm,%cpu,%mem --sort=-%mem | head -n 6

# Failed login attempts (if log available)
if [ -f /var/log/auth.log ]; then
    echo  "\n--- Failed Login Attempts (last 10) ---"
    grep "Failed password" /var/log/auth.log | tail -n 10
fi

echo "\n=============================================="
echo " Report Generated on: $(date)"
echo "=============================================="
