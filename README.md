# server-performance-stat
bash script to check the server performance statistics

## Features

- Total CPU usage
- Memory usage (Free vs Used including percentage)
- Disk usage (Free vs Used including percentage)
- Top 5 processes by CPU usage
- Top 5 processes by memory usage
- OS and Kernel info
- Uptime and load average
- Logged in users
- Failed login attempts (if available)

---

## Dependencies

* `mpstat` (from `sysstat` package)
* `awk`, `df`, `free`, `ps`, `who` (usually pre-installed on Linux)

If `mpstat` is not installed, you can install it using:

```bash
# On Debian/Ubuntu
sudo apt update && sudo apt install -y sysstat

# On RHEL/CentOS
sudo yum install sysstat
```

---

## Running the Script

1. Clone this repository:

```bash
git clone https://github.com/ashishshrestha1196/server-performance-stat.git
cd server-stats
````

2. Make the script executable:

```bash
chmod +x server-stats.sh
```

---

## Usage

Run the script:

```bash
./server-stats.sh
```

The script will print a detailed report of server stats directly in your terminal.

---

## Screenshot



