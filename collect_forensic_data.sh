#!/bin/bash

# Rapid Response Forensics Toolkit - Data Collection Script
# Collects volatile data and relevant artifacts from a live Linux system and saves it to an external storage device.

# Set the output directory to the mounted external storage
OUTPUT_DIR="/mnt/forensics"
TIMESTAMP=$(date '+%Y%m%d_%H%M%S')
HOSTNAME=$(hostname)

# Create a directory with a timestamp to store the outputs
mkdir -p "$OUTPUT_DIR/${HOSTNAME}_forensics_$TIMESTAMP"

# Function to run a command and save the output
collect_data() {
    echo "Collecting $1..."
    $2 > "$OUTPUT_DIR/${HOSTNAME}_forensics_$TIMESTAMP/$1.txt" 2>&1
}

# Function to copy files if they exist
copy_file() {
    if [ -f "$1" ]; then
        echo "Copying $1..."
        cp "$1" "$OUTPUT_DIR/${HOSTNAME}_forensics_$TIMESTAMP/"
    fi
}

# Start data collection

# 1. System Date and Time
collect_data "system_time" "date '+%Y-%m-%d %H:%M:%S %Z'"

# 2. System Uptime
collect_data "system_uptime" "uptime"

# 3. Current User
collect_data "current_user" "whoami"

# 4. All Logged-In Users
collect_data "logged_in_users" "who"

# 5. Last Logged-In Users
collect_data "last_logged_in" "last"

# 6. User Activity
collect_data "user_activity" "w"

# 7. Network Configuration
collect_data "network_interfaces" "ifconfig -a"
collect_data "ip_address" "ip addr show"
collect_data "ip_route" "ip route show"
collect_data "resolv_conf" "cat /etc/resolv.conf"

# 8. Active Network Connections and Open Ports
collect_data "netstat_tulpn" "netstat -tulpn"
collect_data "ss_tulpan" "ss -tulpan"

# 9. ARP Cache
collect_data "arp_cache" "arp -a"

# 10. Routing Table
collect_data "routing_table" "route -n"

# 11. DNS Cache (if applicable)
if command -v nscd >/dev/null 2>&1; then
    collect_data "nscd_stats" "nscd -g"
elif systemctl is-active systemd-resolved >/dev/null 2>&1; then
    collect_data "systemd_resolve_stats" "systemd-resolve --statistics"
fi

# 12. Running Processes
collect_data "running_processes" "ps aux"

# 13. Open Files and Network Connections
collect_data "lsof" "lsof -nP"

# 14. Loaded Kernel Modules
collect_data "loaded_modules" "lsmod"

# 15. Environment Variables
collect_data "environment_variables" "printenv"

# 16. Scheduled Tasks (Cron Jobs)
collect_data "cron_jobs_root" "crontab -l -u root"
collect_data "cron_jobs_current_user" "crontab -l"

# 17. Installed Packages
if command -v dpkg >/dev/null 2>&1; then
    collect_data "installed_packages" "dpkg -l"
elif command -v rpm >/dev/null 2>&1; then
    collect_data "installed_packages" "rpm -qa"
fi

# 18. System Information
collect_data "uname" "uname -a"
collect_data "lsb_release" "lsb_release -a"
collect_data "hostnamectl" "hostnamectl"

# 19. Network Interface Statistics
collect_data "netstat_i" "netstat -i"

# 20. Firewall Rules
if command -v iptables >/dev/null 2>&1; then
    collect_data "iptables_rules" "iptables -L -n -v"
fi
if command -v ufw >/dev/null 2>&1; then
    collect_data "ufw_status" "ufw status verbose"
fi

# 21. SELinux Status (if applicable)
if command -v getenforce >/dev/null 2>&1; then
    collect_data "selinux_status" "getenforce"
fi

# 22. AppArmor Status (if applicable)
if command -v aa-status >/dev/null 2>&1; then
    collect_data "apparmor_status" "aa-status"
fi

# 23. System Logs (last 100 lines)
collect_data "syslog_tail" "tail -n 100 /var/log/syslog"
collect_data "authlog_tail" "tail -n 100 /var/log/auth.log"

# 24. Bash History and Command Histories
# For the current user
copy_file "$HOME/.bash_history"
copy_file "$HOME/.zsh_history"
copy_file "$HOME/.bashrc"
copy_file "$HOME/.profile"

# For root user (if accessible)
if [ "$EUID" -eq 0 ]; then
    copy_file "/root/.bash_history"
    copy_file "/root/.zsh_history"
    copy_file "/root/.bashrc"
    copy_file "/root/.profile"
fi

# 25. SSH Configuration and Known Hosts
copy_file "$HOME/.ssh/known_hosts"
copy_file "$HOME/.ssh/authorized_keys"
copy_file "/etc/ssh/sshd_config"

# 26. Hosts File
copy_file "/etc/hosts"

# 27. OpenSSL Version and Config
collect_data "openssl_version" "openssl version -a"

# 28. Users and Groups Information
collect_data "passwd_file" "cat /etc/passwd"
collect_data "group_file" "cat /etc/group"
collect_data "shadow_file" "cat /etc/shadow"  # Requires root

# 29. Sudoers File
copy_file "/etc/sudoers"
copy_file "/etc/sudoers.d/"

# 30. Mounted File Systems
collect_data "mounted_filesystems" "mount"

# 31. Disk Usage
collect_data "disk_usage" "df -h"

# 32. List of Users with Sudo Privileges
collect_data "sudo_users" "getent group sudo"

# 33. Recent Login Attempts
collect_data "failed_login_attempts" "lastb"

# 34. Scheduled Jobs (System-wide)
copy_file "/etc/crontab"
copy_file "/etc/cron.d/"
copy_file "/etc/cron.daily/"
copy_file "/etc/cron.hourly/"
copy_file "/etc/cron.monthly/"
copy_file "/etc/cron.weekly/"

# 35. Systemd Timers
collect_data "systemd_timers" "systemctl list-timers --all"

# 36. Network Services
collect_data "listening_services" "ss -tulwn"

# 37. Active Kernel Messages (dmesg)
collect_data "kernel_messages" "dmesg"

# 38. Active Users and Their Processes
collect_data "users_processes" "ps -eo user,pid,ppid,cmd,%mem,%cpu --sort=-%mem"

# 39. SSH Sessions
collect_data "ssh_sessions" "sshd -T"

# 40. Current Working Directory
collect_data "current_directory" "pwd"

# 41. Files in Home Directory
collect_data "home_directory_listing" "ls -alh $HOME"

# 42. List of All Installed Services
collect_data "installed_services" "systemctl list-unit-files --type=service"

# 43. Copy .bash_aliases and Other Shell Config Files
copy_file "$HOME/.bash_aliases"
copy_file "$HOME/.bash_profile"
copy_file "$HOME/.zshrc"

# 44. Environment Configuration Files
copy_file "/etc/environment"
copy_file "/etc/profile"
copy_file "/etc/profile.d/"

# 45. Collect /etc/issue and /etc/os-release
copy_file "/etc/issue"
copy_file "/etc/os-release"

# 46. Copy Application Logs (if accessible and relevant)
copy_file "/var/log/auth.log"
copy_file "/var/log/syslog"
copy_file "/var/log/messages"

# 47. List of Open TCP/UDP Ports
collect_data "open_ports" "lsof -iTCP -sTCP:LISTEN -P -n"
collect_data "udp_ports" "lsof -iUDP -P -n"

# 48. Active Connections
collect_data "active_connections" "netstat -antup"

# 49. IPTables NAT Rules
collect_data "iptables_nat" "iptables -t nat -L -n -v"

# 50. Copy Any Custom Scripts in /usr/local/bin or /opt
copy_file "/usr/local/bin/"
copy_file "/opt/"

# Generate Hashes for All Collected Files
echo "Generating hashes..."
cd "$OUTPUT_DIR/${HOSTNAME}_forensics_$TIMESTAMP"
for file in *; do
    if [ -f "$file" ]; then
        sha256sum "$file" >> hashes.sha256
    fi
done

echo "Data collection complete. All data saved to $OUTPUT_DIR/${HOSTNAME}_forensics_$TIMESTAMP"

# End of script

