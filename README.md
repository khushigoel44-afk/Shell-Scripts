
---
# System Health Check Script

This script acts as a quick medical checkup for your computer or server. It tells you how well your system is running right now by checking its vital signs.

## What This Script Does

When you run this script, it checks four main things:

1. **Disk Space (Root):** It checks the main hard drive (where your operating system lives) to see how much storage space is used and how much is free. This prevents your system from crashing due to a full hard drive.
2. **Memory (RAM) Usage:** It checks your system's short-term memory (RAM). If this is too high, your computer will run slowly. It shows the used memory, total memory, and the percentage being used.
3. **CPU Load:** It checks how hard your computer's "brain" (the processor) is working. It gives you three numbers representing the average workload over the last 1 minute, 5 minutes, and 15 minutes. 
4. **Uptime:** It tells you exactly how long your computer has been turned on since its last restart.

## How It Works Behind the Scenes

For those curious, here is exactly what the commands inside the script are doing:
* `df -h /`: This command asks the system for disk space statistics on the root folder (`/`) in human-readable sizes (like GB or MB). The `awk` part extracts just the relevant numbers.
* `free -m`: This asks the system for memory usage in Megabytes. We do a quick math calculation to show you the exact percentage used.
* `uptime`: This command is used twice. First, to pull out the "load average" (CPU stress levels), and second with the `-p` flag to print how long the machine has been "up" in a readable format.

## How to Use This Script

Follow these simple steps to run the checkup on your Linux or macOS terminal:

1. **Create the file:** Open your terminal and create a new file named `health_check.sh`. Paste the script code into it and save.
2. **Make it executable:** Your computer won't let you run a script unless you explicitly give it permission. Run this command: 
   `chmod +x health_check.sh`
3. **Run the script:** Now, execute the script by typing:
   `./health_check.sh`

You will immediately see the health report printed on your screen.


---

# DevOps Backup Script
---

A simple, automated bash script to compress a source directory, save it with a timestamp, and automatically delete old backups based on a retention policy.

## Day-to-Day Usefulness
This script automates disaster recovery and storage management. In a daily DevOps workflow, it provides:
* **Hands-free Data Protection:** Ensures critical files are backed up reliably without relying on manual human intervention.
* **Storage Optimization:** The automated retention policy prevents server disks from filling up with stale archives.
* **Rapid Rollbacks:** Gives you immediate access to timestamped archives to quickly recover from botched deployments, accidental deletions, or server crashes.

## Configuration
Edit the `backup.sh` file to configure your paths and retention period:
- `SOURCE_DIR`: The directory you want to back up (e.g., `/var/www/html`).
- `BACKUP_DIR`: The destination directory for the backup archives (e.g., `/opt/backups`).
- `RETENTION_DAYS`: The number of days to keep backups before deleting them (default is 7).

## Prerequisites
If your `SOURCE_DIR` or `BACKUP_DIR` require elevated permissions (like `/var/www` or `/opt`), you must run this script with `sudo` or as the root user.

## Usage

1. **Make the script executable:**
   ```bash
   chmod +x backup.sh
   ```
2. **Run the script:**

   ```Bash
   sudo ./backup.sh
   ```
(Omit sudo if running purely within user-owned directories).

3. **Automation (Cron Job)**

   To automate the backup to run daily at 2:00 AM:
   Open the root crontab:

   ```Bash
   sudo crontab -e
   ```
   Add the following line (replace /path/to/ with the actual absolute path):

   ```Bash
   0 2 * * * /path/to/backup.sh >> /var/log/backup.log 2>&1
   ```

---