# Linux Fundamentals for Cybersecurity

> **Purpose:** A cybersecurity-focused Linux reference covering the operating system fundamentals, command line, filesystem, permissions, users, processes, networking, services, logs, Bash, security concepts, and practical tools required for SOC, Blue Team, Penetration Testing, CTFs, Digital Forensics, and Security Engineering.

---

# 1. What is Linux?

Linux is an open-source, Unix-like operating system kernel.

In everyday usage, the term **Linux** often refers to a complete operating system distribution built around the Linux kernel.

Examples:

* Ubuntu
* Debian
* Fedora
* Arch Linux
* Kali Linux
* Rocky Linux
* AlmaLinux

### Cybersecurity Perspective

Linux is extremely important in cybersecurity because it is widely used for:

* Web servers
* Cloud infrastructure
* Network devices
* Containers
* Security tools
* SIEM infrastructure
* DevOps environments
* Penetration testing
* CTF environments
* Digital forensics
* Malware analysis

---

# 2. Linux vs Windows

| Linux                           | Windows                     |
| ------------------------------- | --------------------------- |
| Open-source kernel              | Proprietary OS              |
| Common in servers               | Common on desktops          |
| Powerful CLI                    | GUI-focused but has CLI     |
| Highly customizable             | More standardized           |
| Strong scripting environment    | PowerShell/Command Prompt   |
| Common in security tooling      | Common enterprise endpoint  |
| Package managers vary by distro | Winget/Microsoft Store etc. |

A cybersecurity professional should be comfortable with **both Linux and Windows**.

---

# 3. Linux Architecture

A simplified Linux architecture:

```text
+---------------------------+
|       Applications        |
+---------------------------+
|     Shell / Utilities     |
+---------------------------+
|          Kernel           |
+---------------------------+
|         Hardware          |
+---------------------------+
```

### Kernel

The kernel manages:

* CPU
* Memory
* Processes
* Devices
* Filesystems
* Networking
* System calls

### Shell

The shell provides an interface for interacting with the operating system.

Common shells:

```text
bash
zsh
fish
sh
```

---

# 4. Linux Distributions

A Linux distribution combines:

```text
Kernel
+
System Utilities
+
Package Manager
+
Libraries
+
Applications
```

### Common Security-Relevant Distributions

#### Ubuntu

General-purpose Linux distribution.

Useful for:

* Servers
* Cloud
* Development
* Security labs

#### Debian

Stable and widely used.

#### Kali Linux

Designed specifically for security testing.

Contains tools for:

* Reconnaissance
* Scanning
* Web security
* Password auditing
* Exploitation
* Wireless security
* Digital forensics

#### Parrot OS

Security and privacy-oriented Linux distribution.

---

# 5. Terminal

The terminal provides a command-line interface.

Example:

```bash
whoami
```

Output:

```text
kali
```

The terminal is extremely important for cybersecurity.

Instead of clicking through graphical interfaces, security professionals often use commands to:

* Investigate systems
* Search files
* Analyze logs
* Monitor processes
* Configure networks
* Automate tasks
* Run security tools

---

# 6. Shell

A shell interprets commands and communicates with the operating system.

Example:

```bash
ls
```

The shell interprets the command and executes the appropriate program.

Check your current shell:

```bash
echo $SHELL
```

Check the current user:

```bash
whoami
```

---

# 7. Essential Linux Commands

## pwd

Shows the current directory.

```bash
pwd
```

---

## ls

Lists files and directories.

```bash
ls
```

Detailed:

```bash
ls -l
```

Show hidden files:

```bash
ls -la
```

Human-readable sizes:

```bash
ls -lah
```

---

## cd

Changes directory.

```bash
cd /etc
```

Go to parent directory:

```bash
cd ..
```

Go to home directory:

```bash
cd ~
```

---

## mkdir

Creates a directory.

```bash
mkdir security-lab
```

Create nested directories:

```bash
mkdir -p labs/network/scanning
```

---

## touch

Creates an empty file.

```bash
touch notes.txt
```

---

## cp

Copies files.

```bash
cp file.txt backup.txt
```

Copy directory:

```bash
cp -r folder/ backup/
```

---

## mv

Moves or renames files.

```bash
mv old.txt new.txt
```

---

## rm

Removes files.

```bash
rm file.txt
```

Remove directory recursively:

```bash
rm -r folder/
```

> Be extremely careful with `rm`, especially when using `sudo`.

---

# 8. Linux Filesystem

Linux uses a hierarchical filesystem.

```text
/
├── bin
├── boot
├── dev
├── etc
├── home
├── lib
├── media
├── mnt
├── opt
├── proc
├── root
├── run
├── sbin
├── srv
├── sys
├── tmp
├── usr
└── var
```

---

# 9. Important Linux Directories

## /

Root of the filesystem.

Everything starts from:

```text
/
```

---

## /home

Contains normal users' home directories.

Example:

```text
/home/kumail
```

---

## /root

Home directory of the root user.

Different from:

```text
/
```

`/` is the filesystem root.

`/root` is the root user's home directory.

---

## /etc

Contains system configuration files.

Examples:

```text
/etc/passwd
/etc/shadow
/etc/hosts
/etc/ssh/
/etc/systemd/
```

This directory is extremely important during security investigations.

---

## /var

Contains variable data.

Common examples:

```text
/var/log
/var/cache
/var/tmp
```

---

## /var/log

Contains system and application logs.

Security professionals frequently investigate:

```text
/var/log/auth.log
/var/log/syslog
```

On some distributions:

```text
/var/log/secure
```

---

## /tmp

Temporary files.

Security relevance:

* Malware may use temporary locations.
* Attackers may stage files.
* Applications commonly create temporary data here.

---

## /usr

Contains many user-space applications and libraries.

---

## /bin

Contains essential user commands on systems that maintain this directory separately.

On modern distributions, `/bin` may be linked to `/usr/bin`.

---

## /sbin

Contains many system administration utilities.

---

## /dev

Contains device files.

Example:

```text
/dev/null
/dev/random
/dev/sda
```

---

## /proc

Virtual filesystem exposing information about processes and the kernel.

Example:

```bash
cat /proc/cpuinfo
```

Process information:

```text
/proc/<PID>/
```

---

## /sys

Provides information and interfaces related to devices and the kernel.

---

# 10. Absolute vs Relative Paths

### Absolute Path

Starts from `/`.

```text
/home/kumail/file.txt
```

### Relative Path

Starts from the current directory.

```text
documents/file.txt
```

Special paths:

```text
.    Current directory
..   Parent directory
~    Home directory
/    Filesystem root
```

---

# 11. File Types

Linux commonly represents different objects using file-type indicators.

Example:

```bash
ls -l
```

Output may look like:

```text
-rw-r--r-- 1 user user 1200 notes.txt
drwxr-xr-x 2 user user 4096 labs
```

First character:

```text
-   Regular file
d   Directory
l   Symbolic link
c   Character device
b   Block device
s   Socket
p   Named pipe
```

---

# 12. Reading Files

## cat

```bash
cat file.txt
```

Useful for short files.

---

## less

```bash
less file.txt
```

Useful for large files.

Exit:

```text
q
```

---

## head

Shows beginning of a file.

```bash
head file.txt
```

---

## tail

Shows end of a file.

```bash
tail file.txt
```

Follow a growing log:

```bash
tail -f /var/log/auth.log
```

This is extremely useful for SOC and incident investigation.

---

# 13. Searching Files

## find

Search files by criteria.

```bash
find /home -name "*.txt"
```

Search by permission:

```bash
find / -perm -4000 2>/dev/null
```

Search recently modified files:

```bash
find /var/log -type f -mtime -1
```

---

## locate

Fast filename search where available:

```bash
locate passwd
```

The database may need updating depending on the distribution.

---

# 14. grep

`grep` searches text for patterns.

Example:

```bash
grep "failed" /var/log/auth.log
```

Case-insensitive:

```bash
grep -i "failed" /var/log/auth.log
```

Recursive search:

```bash
grep -R "password" /etc/
```

Show line numbers:

```bash
grep -n "error" logfile.txt
```

### Cybersecurity Use

`grep` is heavily used for:

* Log analysis
* IOC searching
* Configuration analysis
* Incident response
* Malware investigation

---

# 15. Pipes

A pipe sends the output of one command into another command.

```bash
command1 | command2
```

Example:

```bash
ps aux | grep ssh
```

Another example:

```bash
ss -tuln | grep 443
```

This concept is fundamental to Linux command-line work.

---

# 16. Redirection

### Output to file

```bash
command > output.txt
```

### Append

```bash
command >> output.txt
```

### Input

```bash
command < input.txt
```

### Error redirection

```bash
command 2> errors.txt
```

### Hide errors

```bash
command 2>/dev/null
```

---

# 17. Permissions

Linux permissions control access to files and directories.

Example:

```text
-rwxr-xr--
```

Three permission groups:

```text
User
Group
Others
```

Three basic permissions:

```text
r = read
w = write
x = execute
```

---

# 18. Understanding Permissions

Example:

```text
-rwxr-xr--
```

Breakdown:

```text
-   rwx   r-x   r--
    │     │     │
   User  Group Others
```

Meaning:

```text
User:   read + write + execute
Group:  read + execute
Others: read
```

---

# 19. chmod

Changes permissions.

Example:

```bash
chmod 755 script.sh
```

Meaning:

```text
Owner  = rwx
Group  = r-x
Others = r-x
```

Numeric permissions:

```text
r = 4
w = 2
x = 1
```

Examples:

```text
7 = rwx
6 = rw-
5 = r-x
4 = r--
0 = ---
```

---

# 20. chown

Changes file ownership.

```bash
chown user file.txt
```

Change user and group:

```bash
chown user:group file.txt
```

---

# 21. Dangerous Permissions

Security professionals should pay attention to:

```text
World-writable files
Incorrect ownership
SUID files
SGID files
Writable system directories
Weak configuration permissions
```

Example:

```bash
find / -perm -002 -type f 2>/dev/null
```

This searches for world-writable files.

---

# 22. SUID

SUID allows an executable to run with the privileges of its file owner.

Find SUID files:

```bash
find / -perm -4000 -type f 2>/dev/null
```

### Security Relevance

Misconfigured SUID binaries can potentially contribute to **local privilege escalation**.

Never assume every SUID file is malicious.

Investigate:

* What binary is it?
* Who owns it?
* Is it expected?
* What version is installed?
* What permissions does it have?
* Is the configuration secure?

---

# 23. SGID

SGID can cause an executable to run with the privileges of the owning group and has special behavior on directories.

Find SGID files:

```bash
find / -perm -2000 -type f 2>/dev/null
```

---

# 24. Users

List users:

```bash
cat /etc/passwd
```

Example structure:

```text
username:x:UID:GID:comment:home:shell
```

Important fields:

```text
Username
UID
GID
Home directory
Login shell
```

---

# 25. Password Information

On many Linux systems:

```text
/etc/passwd
```

contains account information, while password hashes are stored in:

```text
/etc/shadow
```

Access to `/etc/shadow` is highly restricted.

Check permissions:

```bash
ls -l /etc/shadow
```

### Security Importance

Protect:

* Password hashes
* Authentication files
* SSH keys
* Service credentials
* API keys
* Configuration secrets

---

# 26. Groups

View groups:

```bash
groups
```

View group database:

```bash
cat /etc/group
```

List a user's identity information:

```bash
id
```

Example:

```bash
id username
```

---

# 27. sudo

`sudo` allows authorized users to execute commands with elevated privileges.

Example:

```bash
sudo apt update
```

Check sudo permissions:

```bash
sudo -l
```

### Security Perspective

Misconfigured sudo rules can create privilege escalation opportunities.

Administrators should follow:

* Least privilege
* Strong authentication
* Minimal command permissions
* Regular auditing

---

# 28. Root User

The root account has extensive administrative privileges.

Root can potentially:

* Modify system files
* Change permissions
* Manage users
* Start/stop services
* Access sensitive resources
* Modify networking

### Security Principle

Avoid unnecessary root usage.

Prefer:

```bash
sudo specific-command
```

instead of operating continuously as root.

---

# 29. Processes

A process is a running instance of a program.

List processes:

```bash
ps
```

Detailed:

```bash
ps aux
```

Process tree:

```bash
pstree
```

Interactive monitoring:

```bash
top
```

or:

```bash
htop
```

---

# 30. Process IDs

Every process has a PID.

Example:

```text
PID  COMMAND
1    systemd
500  sshd
1200 bash
```

Find a process:

```bash
ps aux | grep ssh
```

---

# 31. kill

Terminates or signals a process.

Example:

```bash
kill <PID>
```

Force termination:

```bash
kill -9 <PID>
```

### Important

Do not use `kill -9` as the default solution.

Prefer graceful termination first:

```bash
kill <PID>
```

---

# 32. Services

Linux systems commonly run background services.

Examples:

```text
SSH
Web Server
Database
DNS
Logging
Docker
```

With systemd:

```bash
systemctl status ssh
```

Start:

```bash
sudo systemctl start ssh
```

Stop:

```bash
sudo systemctl stop ssh
```

Restart:

```bash
sudo systemctl restart ssh
```

Enable at boot:

```bash
sudo systemctl enable ssh
```

---

# 33. Security Importance of Services

During security assessment, identify:

* Which services are running?
* Which ports are exposed?
* Which services are unnecessary?
* Which versions are installed?
* Are services running as root?
* Are configurations secure?

Useful command:

```bash
ss -tulnp
```

---

# 34. Linux Networking

View interfaces:

```bash
ip addr
```

View routes:

```bash
ip route
```

View neighbors:

```bash
ip neigh
```

Test connectivity:

```bash
ping <IP>
```

View listening sockets:

```bash
ss -tulnp
```

---

# 35. DNS Commands

Resolve a domain:

```bash
dig example.com
```

or:

```bash
nslookup example.com
```

Reverse lookup:

```bash
dig -x <IP>
```

Check DNS configuration:

```bash
cat /etc/resolv.conf
```

---

# 36. Network Connections

View active TCP connections:

```bash
ss -ant
```

Listening TCP/UDP services:

```bash
ss -tuln
```

Show process information:

```bash
ss -tulnp
```

### Cybersecurity Use

Useful for detecting:

* Unexpected listeners
* Suspicious connections
* Unknown services
* Malware communication
* Reverse shells
* Unauthorized applications

---

# 37. /etc/hosts

The hosts file provides local hostname mappings.

```text
/etc/hosts
```

Example:

```text
127.0.0.1 localhost
192.168.1.10 server01
```

Security relevance:

* Local DNS overrides
* Malware persistence
* Traffic redirection
* Lab environments

---

# 38. Firewall

Linux systems can use different firewall frameworks/tools.

Common technologies:

```text
nftables
iptables
ufw
firewalld
```

Example with UFW:

```bash
sudo ufw status
```

Allow SSH:

```bash
sudo ufw allow 22/tcp
```

Enable:

```bash
sudo ufw enable
```

> Firewall configuration should be tested carefully to avoid locking yourself out of a remote system.

---

# 39. Logs

Logs are one of the most important resources for security professionals.

Common locations:

```text
/var/log/
```

Examples:

```text
/var/log/auth.log
/var/log/syslog
/var/log/kern.log
```

On other distributions:

```text
/var/log/secure
```

---

# 40. Authentication Logs

Authentication logs can reveal:

* Failed logins
* Successful logins
* SSH activity
* sudo usage
* Authentication anomalies

Example:

```bash
grep "Failed password" /var/log/auth.log
```

Search successful SSH authentication:

```bash
grep "Accepted" /var/log/auth.log
```

---

# 41. journalctl

On systemd-based systems, `journalctl` queries the system journal.

View logs:

```bash
journalctl
```

Recent logs:

```bash
journalctl -n 100
```

Follow logs:

```bash
journalctl -f
```

SSH-related logs:

```bash
journalctl -u ssh
```

Boot logs:

```bash
journalctl -b
```

---

# 42. Linux Security Investigation

A basic investigation can follow:

```text
Alert
 ↓
Identify Host
 ↓
Identify User
 ↓
Check Processes
 ↓
Check Network Connections
 ↓
Check Services
 ↓
Check Authentication Logs
 ↓
Check Persistence
 ↓
Collect Evidence
 ↓
Contain
 ↓
Remediate
```

---

# 43. Persistence Mechanisms

Attackers may attempt to maintain access using:

* Cron jobs
* systemd services
* SSH keys
* Startup scripts
* Shell configuration files
* User accounts
* Scheduled tasks
* Malicious binaries

Security investigation should include:

```bash
crontab -l
```

Check system cron directories:

```bash
ls -la /etc/cron.d/
ls -la /etc/cron.daily/
```

Check systemd services:

```bash
systemctl list-unit-files
```

---

# 44. Cron

Cron schedules commands to run automatically.

View current user's cron jobs:

```bash
crontab -l
```

Edit:

```bash
crontab -e
```

Cron format:

```text
minute hour day month weekday command
```

Example:

```text
0 2 * * * /path/to/script.sh
```

### Security Relevance

Unexpected cron jobs can indicate:

* Persistence
* Unauthorized automation
* Malware
* Cryptomining
* Data collection

---

# 45. SSH Security

SSH is one of the most important Linux remote-access services.

Configuration:

```text
/etc/ssh/sshd_config
```

Security best practices:

* Disable unnecessary SSH exposure
* Prefer key-based authentication
* Disable direct root login where appropriate
* Use strong authentication
* Restrict allowed users
* Monitor authentication logs
* Keep OpenSSH updated
* Use network-level access controls

---

# 46. SSH Keys

Common key locations:

```text
~/.ssh/
```

Private keys must be protected.

Examples:

```text
id_ed25519
id_rsa
```

Public keys:

```text
id_ed25519.pub
id_rsa.pub
```

Authorized keys:

```text
~/.ssh/authorized_keys
```

### Security Warning

Never expose or share private SSH keys.

---

# 47. Environment Variables

View environment variables:

```bash
env
```

Specific variable:

```bash
echo $PATH
```

Important variables include:

```text
PATH
HOME
USER
SHELL
PWD
```

### Security Relevance

Misconfigured environment variables can contribute to security problems, especially when privileged programs rely on unsafe paths or variables.

---

# 48. PATH

`PATH` tells the shell where to search for executable programs.

Example:

```bash
echo $PATH
```

Find command location:

```bash
which python
```

or:

```bash
command -v python
```

Security concern:

A malicious executable placed in an unsafe PATH location can potentially be executed instead of the intended program.

---

# 49. Package Management

Linux distributions use package managers.

### Debian/Ubuntu

```bash
sudo apt update
sudo apt install nmap
```

Update packages:

```bash
sudo apt upgrade
```

Search:

```bash
apt search <package>
```

### Fedora/RHEL

Common tools include:

```bash
dnf
```

Example:

```bash
sudo dnf install nmap
```

### Security Importance

Regular updates help patch:

* Vulnerabilities
* Security bugs
* Outdated dependencies
* Known exploits

---

# 50. File Integrity

Security professionals may need to determine whether files changed unexpectedly.

Useful concepts:

* Hashing
* File timestamps
* Ownership
* Permissions
* Digital signatures
* Baselines

Example:

```bash
sha256sum suspicious_file
```

Compare hashes against a trusted baseline.

---

# 51. Hashing

A hash produces a fixed-length representation of data.

Example:

```bash
sha256sum file.txt
```

SHA-256 is commonly used for:

* File integrity
* Malware identification
* Evidence correlation
* Download verification

### Important

Hashing is not encryption.

```text
Hashing ≠ Encryption
```

---

# 52. Bash Fundamentals

Bash is one of the most important shells for cybersecurity.

Basic script:

```bash
#!/bin/bash

echo "Security Lab"
```

Run:

```bash
chmod +x script.sh
./script.sh
```

---

# 53. Variables

```bash
name="Kumail"
echo "$name"
```

System variable:

```bash
echo "$USER"
```

---

# 54. Conditions

```bash
if [ "$USER" = "root" ]; then
    echo "Running as root"
else
    echo "Normal user"
fi
```

---

# 55. Loops

### For loop

```bash
for ip in 192.168.1.1 192.168.1.2 192.168.1.3
do
    ping -c 1 "$ip"
done
```

### While loop

```bash
while read -r line
do
    echo "$line"
done < hosts.txt
```

---

# 56. Bash Automation for Cybersecurity

Bash can automate repetitive tasks such as:

* Log searching
* Host checks
* File collection
* Hash generation
* Service checks
* Network monitoring
* IOC searches
* Security reports

Example:

```bash
#!/bin/bash

echo "Current User:"
whoami

echo "IP Address:"
ip addr

echo "Listening Services:"
ss -tuln

echo "Current Processes:"
ps aux
```

---

# 57. Useful Text Processing Tools

### cut

Extract columns:

```bash
cut -d: -f1 /etc/passwd
```

### sort

```bash
sort users.txt
```

### uniq

```bash
sort users.txt | uniq
```

### awk

Powerful text processing:

```bash
awk '{print $1}' logfile.txt
```

### sed

Text transformation:

```bash
sed 's/old/new/g' file.txt
```

These tools are extremely valuable for SOC automation.

---

# 58. File Permissions — Security Checklist

When investigating a Linux system, check:

```text
[ ] Unexpected SUID files
[ ] Unexpected SGID files
[ ] World-writable files
[ ] Suspicious ownership
[ ] Suspicious hidden files
[ ] Modified system binaries
[ ] Unauthorized SSH keys
[ ] Unexpected user accounts
[ ] Suspicious cron jobs
[ ] Suspicious systemd services
```

---

# 59. Process Investigation Checklist

For a suspicious process, investigate:

```text
Process Name
PID
Parent PID
User
Executable Path
Command Line
CPU Usage
Memory Usage
Network Connections
Open Files
Start Time
Persistence Mechanism
```

Useful commands:

```bash
ps aux
```

```bash
pstree
```

```bash
ls -l /proc/<PID>/exe
```

```bash
ls -l /proc/<PID>/fd/
```

---

# 60. Network Investigation Checklist

For suspicious network activity:

```text
[ ] Source IP
[ ] Destination IP
[ ] Source Port
[ ] Destination Port
[ ] Protocol
[ ] Process
[ ] User
[ ] Connection Time
[ ] DNS Requests
[ ] Firewall Logs
[ ] Packet Capture
```

Useful commands:

```bash
ss -antp
```

```bash
ip route
```

```bash
dig <domain>
```

```bash
tcpdump -i eth0
```

---

# 61. Common Linux Security Tools

| Tool      | Purpose                              |
| --------- | ------------------------------------ |
| Nmap      | Network scanning                     |
| Wireshark | Packet analysis                      |
| tcpdump   | Packet capture                       |
| Netcat    | Network testing                      |
| curl      | HTTP/network requests                |
| wget      | File retrieval                       |
| OpenSSH   | Secure remote access                 |
| GPG       | Cryptographic operations             |
| OpenSSL   | TLS/cryptographic utilities          |
| Lynis     | Linux security auditing              |
| auditd    | Linux auditing                       |
| fail2ban  | Brute-force protection               |
| YARA      | Pattern-based malware identification |
| ClamAV    | Antivirus scanning                   |

---

# 62. curl

`curl` is extremely useful for network and web security work.

Example:

```bash
curl https://example.com
```

View headers:

```bash
curl -I https://example.com
```

Follow redirects:

```bash
curl -L https://example.com
```

Send a request:

```bash
curl -X POST https://example.com
```

Cybersecurity uses:

* API testing
* HTTP investigation
* Header inspection
* Connectivity testing
* Automation

---

# 63. OpenSSL

OpenSSL provides cryptographic and TLS utilities.

Check a TLS service:

```bash
openssl s_client -connect example.com:443
```

Generate a SHA-256 hash:

```bash
openssl dgst -sha256 file.txt
```

Security professionals use OpenSSL for:

* TLS analysis
* Certificates
* Cryptography
* Key generation
* Certificate troubleshooting

---

# 64. System Information

Useful commands:

### Kernel version

```bash
uname -a
```

### OS information

```bash
cat /etc/os-release
```

### Hostname

```bash
hostname
```

### CPU

```bash
lscpu
```

### Memory

```bash
free -h
```

### Disk

```bash
df -h
```

### Disk usage

```bash
du -sh *
```

---

# 65. Linux Security Hardening

Basic hardening principles:

### 1. Update the system

```bash
sudo apt update
sudo apt upgrade
```

### 2. Remove unnecessary services

Reduce attack surface.

### 3. Use least privilege

Avoid unnecessary root access.

### 4. Configure firewall

Restrict unnecessary inbound traffic.

### 5. Secure SSH

Use strong authentication and appropriate access restrictions.

### 6. Monitor logs

Detect suspicious activity.

### 7. Protect secrets

Never store passwords/API keys carelessly.

### 8. Use strong file permissions

Prevent unauthorized modification.

### 9. Monitor users

Remove unnecessary accounts.

### 10. Enable auditing where appropriate

Track security-sensitive activity.

---

# 66. Linux Attack Surface

A Linux system can expose multiple attack surfaces:

```text
Users
   ↓
Authentication
   ↓
SSH
   ↓
Network Services
   ↓
Web Applications
   ↓
File Permissions
   ↓
SUID/SGID
   ↓
Kernel
   ↓
Scheduled Tasks
   ↓
Third-Party Software
   ↓
Cloud Metadata/Configuration
```

A security professional should systematically assess each area.

---

# 67. Linux Privilege Escalation — Conceptual Overview

Privilege escalation means gaining higher privileges than initially authorized.

Typical categories:

```text
Low Privilege User
       ↓
Enumeration
       ↓
Misconfiguration / Vulnerability
       ↓
Higher Privilege
       ↓
Root
```

Common areas to investigate in an authorized lab:

* SUID binaries
* Sudo permissions
* Writable files
* Writable directories
* Weak services
* Cron jobs
* PATH issues
* Credentials
* Kernel vulnerabilities
* Container misconfigurations

---

# 68. Linux Incident Response

A simplified incident-response process:

```text
1. Identify
       ↓
2. Preserve Evidence
       ↓
3. Collect Information
       ↓
4. Analyze
       ↓
5. Contain
       ↓
6. Eradicate
       ↓
7. Recover
       ↓
8. Document
```

Potential evidence:

* Authentication logs
* Process information
* Network connections
* Files
* File hashes
* Shell history
* User accounts
* Cron jobs
* Systemd services
* Memory
* Disk images

---

# 69. Important Linux Artifacts for Forensics

Investigators may examine:

```text
/var/log/
/etc/passwd
/etc/shadow
/etc/hosts
/etc/ssh/
/etc/crontab
/etc/cron.*
~/.bash_history
~/.ssh/
/tmp/
/var/tmp/
/proc/
/opt/
/usr/local/bin/
```

The exact artifacts vary by distribution and configuration.

---

# 70. Linux CTF Skills

Linux knowledge is essential for CTFs.

You should be comfortable with:

```text
File navigation
File searching
Permissions
Users/groups
Processes
Networking
SSH
SUID
Cron
Environment variables
Command-line tools
Bash scripting
Text processing
```

Typical CTF workflow:

```text
Enumeration
    ↓
Find Interesting Files
    ↓
Understand Permissions
    ↓
Identify Weakness
    ↓
Exploit in Lab
    ↓
Privilege Escalation
    ↓
Capture Flag
```

---

# 71. Essential Linux Commands Cheat Sheet

## Navigation

```bash
pwd
ls -la
cd
mkdir
touch
cp
mv
rm
```

## Files

```bash
cat
less
head
tail
file
stat
find
```

## Text

```bash
grep
awk
sed
cut
sort
uniq
wc
```

## Users

```bash
whoami
id
who
w
last
groups
```

## Processes

```bash
ps
top
htop
pstree
kill
```

## Networking

```bash
ip addr
ip route
ip neigh
ss
ping
dig
nslookup
curl
tcpdump
```

## Services

```bash
systemctl
journalctl
```

## Security

```bash
sudo
chmod
chown
sha256sum
openssl
```

## System

```bash
uname
hostname
df
du
free
lscpu
```

---

# 72. Linux Commands Every Cybersecurity Beginner Should Master

Before moving to advanced security tooling, become comfortable with:

```text
pwd
ls
cd
cat
less
head
tail
grep
find
file
stat
cp
mv
rm
mkdir
chmod
chown
sudo
id
whoami
ps
top
kill
systemctl
journalctl
ip
ss
ping
dig
curl
wget
ssh
scp
tar
gzip
sha256sum
```

Do not just memorize these commands.

Understand:

> **What problem does the command solve?**

---

# 73. Practical Cybersecurity Labs

## Lab 1 — Linux Reconnaissance

Run:

```bash
whoami
id
hostname
uname -a
cat /etc/os-release
ip addr
ip route
```

Identify:

* Current user
* Groups
* Hostname
* Kernel
* OS
* IP address
* Gateway

---

# 74. Lab 2 — Process Investigation

Run:

```bash
ps aux
```

Then:

```bash
ps aux | grep ssh
```

Investigate:

* PID
* User
* Process
* Command
* Parent process

---

# 75. Lab 3 — Network Investigation

Run:

```bash
ss -tulnp
```

Identify:

* Listening ports
* Protocol
* Process
* Service

Then determine whether every exposed service is expected.

---

# 76. Lab 4 — Log Investigation

Search authentication logs:

```bash
grep -i "failed" /var/log/auth.log
```

Search successful authentication:

```bash
grep -i "accepted" /var/log/auth.log
```

Questions:

* Which user was targeted?
* When did the event happen?
* From which IP?
* Was authentication successful?

---

# 77. Lab 5 — Permission Investigation

Find SUID files:

```bash
find / -perm -4000 -type f 2>/dev/null
```

Find world-writable files:

```bash
find / -type f -perm -002 2>/dev/null
```

For each result ask:

> Is this expected?

---

# 78. Lab 6 — Bash Security Automation

Create a script that reports:

```text
Hostname
Current User
IP Address
Kernel
Listening Ports
Running Processes
Disk Usage
```

This develops the automation skills needed for:

* SOC
* Blue Team
* System Administration
* Incident Response

---

# 79. Linux Security Mindset

When you see a Linux system, don't only think:

> "Which command should I run?"

Think:

```text
Who?
What?
Where?
When?
Why?
How?
```

### Who?

Which user/process is involved?

### What?

What happened?

### Where?

Which file, process, port, or system?

### When?

When did it happen?

### Why?

What caused it?

### How?

How did the activity occur?

This mindset is more valuable than memorizing hundreds of commands.

---

# 80. Linux → Cybersecurity Connection

The ultimate goal is to connect Linux knowledge with security analysis.

```text
Linux System
     ↓
Users
     ↓
Processes
     ↓
Files
     ↓
Permissions
     ↓
Services
     ↓
Network
     ↓
Logs
     ↓
Security Events
     ↓
Investigation
     ↓
Detection
     ↓
Response
```

---

# 81. Skills Required for Different Cybersecurity Roles

| Skill       |   SOC | Blue Team | Pentesting |  DFIR | Security Engineering |
| ----------- | ----: | --------: | ---------: | ----: | -------------------: |
| Linux CLI   | ★★★★★ |     ★★★★★ |      ★★★★★ | ★★★★★ |                ★★★★★ |
| Bash        | ★★★★☆ |     ★★★★★ |      ★★★★★ | ★★★★☆ |                ★★★★★ |
| Permissions | ★★★★☆ |     ★★★★★ |      ★★★★★ | ★★★★★ |                ★★★★★ |
| Networking  | ★★★★★ |     ★★★★★ |      ★★★★★ | ★★★★☆ |                ★★★★★ |
| Logs        | ★★★★★ |     ★★★★★ |      ★★★☆☆ | ★★★★★ |                ★★★★☆ |
| Processes   | ★★★★★ |     ★★★★★ |      ★★★★★ | ★★★★★ |                ★★★★★ |
| Services    | ★★★★☆ |     ★★★★★ |      ★★★★★ | ★★★★☆ |                ★★★★★ |
| Scripting   | ★★★★☆ |     ★★★★★ |      ★★★★★ | ★★★★☆ |                ★★★★★ |

---

# 82. Learning Roadmap

Follow this order:

```text
Linux Basics
     ↓
Terminal & Shell
     ↓
Filesystem
     ↓
Permissions
     ↓
Users & Groups
     ↓
Processes
     ↓
Services
     ↓
Networking
     ↓
Logs
     ↓
Bash Scripting
     ↓
Linux Security
     ↓
System Hardening
     ↓
Privilege Escalation
     ↓
Incident Response
     ↓
Automation
```

---

# 83. Final Linux Checklist

Before moving to advanced Linux security, make sure you can:

* [ ] Explain Linux architecture
* [ ] Understand Linux distributions
* [ ] Use the terminal confidently
* [ ] Navigate the filesystem
* [ ] Understand absolute and relative paths
* [ ] Identify important `/etc`, `/var`, `/home`, `/proc`, and `/tmp` locations
* [ ] Read and search files
* [ ] Use `grep`
* [ ] Use `find`
* [ ] Understand pipes and redirection
* [ ] Understand file permissions
* [ ] Use `chmod`
* [ ] Use `chown`
* [ ] Understand users and groups
* [ ] Understand `sudo`
* [ ] Understand root
* [ ] Analyze processes
* [ ] Manage services
* [ ] Read logs
* [ ] Use `journalctl`
* [ ] Understand Linux networking
* [ ] Use `ip`
* [ ] Use `ss`
* [ ] Use `curl`
* [ ] Understand SSH
* [ ] Understand SSH keys
* [ ] Understand cron
* [ ] Identify SUID/SGID files
* [ ] Understand environment variables
* [ ] Use Bash
* [ ] Write basic Bash scripts
* [ ] Understand package management
* [ ] Understand hashing
* [ ] Perform basic Linux hardening
* [ ] Perform basic Linux security investigation
* [ ] Understand Linux privilege escalation concepts

---

# 84. What to Learn Next

Once Linux fundamentals are strong, continue with:

```text
Linux
  ↓
Networking
  ↓
Bash & Python Automation
  ↓
Web Fundamentals
  ↓
Windows Fundamentals
  ↓
Active Directory
  ↓
Cybersecurity Fundamentals
  ↓
Security Tools
  ↓
SOC / Blue Team
  ↓
Penetration Testing
  ↓
Digital Forensics
  ↓
Cloud Security
  ↓
Advanced Cybersecurity
```

---

# Final Takeaway

> **Linux is not just an operating system you need to know for cybersecurity tools. Linux itself is a major security skill.**

A strong cybersecurity professional should be able to enter a Linux system and understand:

```text
Who is using the system?
        ↓
What processes are running?
        ↓
Which services are exposed?
        ↓
Which ports are listening?
        ↓
Which files changed?
        ↓
Who has access?
        ↓
What authentication occurred?
        ↓
What network connections exist?
        ↓
What do the logs show?
        ↓
Is anything suspicious?
        ↓
How can the system be secured?
```

**Master Linux + Networking first. Then move into security tooling.**
