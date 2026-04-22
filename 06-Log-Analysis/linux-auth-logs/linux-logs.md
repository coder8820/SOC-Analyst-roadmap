# Linux Log Analysis Guide for SOC Analysts

A comprehensive reference for detecting cyber threats using Linux system logs, auditd, and detection rules.

---

## Table of Contents

1. [Introduction](#introduction)
2. [Linux Log Sources & Locations](#linux-log-sources--locations)
3. [Critical Log Events by Category](#critical-log-events-by-category)
4. [Auditd: The Linux Sysmon Equivalent](#auditd-the-linux-sysmon-equivalent)
5. [Log Analysis by Attack Phase](#log-analysis-by-attack-phase)
6. [Detection Rules (Sigma-style)](#detection-rules-sigma-style)
7. [Query Examples (KQL / Splunk)](#query-examples-kql--splunk)
8. [Common Linux Malware Indicators](#common-linux-malware-indicators)
9. [Tuning & False Positive Reduction](#tuning--false-positive-reduction)
10. [Cheat Sheet](#cheat-sheet)

---

## Introduction

Linux powers most servers, cloud workloads, and critical infrastructure. A SOC analyst must understand:

- **Syslog** – Central logging daemon (rsyslog, syslog-ng, systemd-journald)
- **Auditd** – Kernel-level event monitoring (similar to Sysmon)
- **Authentication logs** – SSH, sudo, login failures
- **Process accounting** – Process creation and command lines

**Best Practice:** Enable **auditd** on all production Linux systems and centralize logs to a SIEM.

---

## Linux Log Sources & Locations

### Primary Log Files

| Log File | Purpose | Attack Relevance |
|----------|---------|-------------------|
| `/var/log/auth.log` (Debian/Ubuntu) | Authentication attempts, sudo, SSH | Brute force, privilege escalation |
| `/var/log/secure` (RHEL/CentOS) | Authentication attempts, sudo, SSH | Brute force, privilege escalation |
| `/var/log/syslog` | General system messages | Service crashes, kernel errors |
| `/var/log/messages` | General system messages (RHEL) | System-wide events |
| `/var/log/kern.log` | Kernel messages | Kernel exploits, unusual drivers |
| `/var/log/cron` | Cron job execution | Persistence, scheduled malware |
| `/var/log/boot.log` | System boot messages | Bootkits, persistence |
| `/var/log/dpkg.log` / `/var/log/yum.log` | Package installations | Backdoor installation |
| `/var/log/audit/audit.log` | auditd events | Full system call monitoring |
| `/var/log/wtmp` | Login history (binary) | User login tracking |
| `/var/log/btmp` | Failed login attempts (binary) | Brute force |
| `/var/log/lastlog` | Last login per user | Unusual access |

### Systemd Journal (journalctl)

```bash
# View all logs since boot
journalctl -b

# Follow live logs
journalctl -f

# Filter by service
journalctl -u sshd
journalctl -u cron

# Filter by time
journalctl --since "1 hour ago"
journalctl --since "2025-01-01" --until "2025-01-02"

# Filter by priority
journalctl -p err -p crit

# Install auditd
sudo apt install auditd audispd-plugins   # Debian/Ubuntu
sudo yum install audit audit-libs         # RHEL/CentOS

# Start and enable
sudo systemctl enable auditd
sudo systemctl start auditd

# Verify
sudo auditctl -s



#--------------- Process Monitoring ---------------
# Monitor all process executions (execve syscall)
-a always,exit -F arch=b64 -S execve -k process_execution
-a always,exit -F arch=b32 -S execve -k process_execution

# Monitor process forking (fork, clone)
-a always,exit -F arch=b64 -S fork -S clone -k process_fork
-a always,exit -F arch=b32 -S fork -S clone -k process_fork

#--------------- Privilege Escalation ---------------
# Monitor setuid/setgid binaries usage
-a always,exit -F arch=b64 -S setuid -S setgid -S setreuid -S setregid -k priv_esc
-a always,exit -F arch=b32 -S setuid -S setgid -S setreuid -S setregid -k priv_esc

# Monitor sudo execution
-w /usr/bin/sudo -p x -k sudo_execution

#--------------- Credential Access ---------------
# Monitor /etc/shadow access
-w /etc/shadow -p rwa -k shadow_access

# Monitor /etc/passwd modifications
-w /etc/passwd -p wa -k passwd_modification

# Monitor SSH private keys
-w /root/.ssh/ -p rwa -k ssh_keys
-w /home/ -p rwa -k ssh_keys -F uid=0  # Only root access to user keys

#--------------- Persistence ---------------
# Monitor cron jobs
-w /etc/crontab -p wa -k cron_mod
-w /etc/cron.d/ -p wa -k cron_mod
-w /var/spool/cron/ -p wa -k cron_mod

# Monitor systemd services
-w /etc/systemd/system/ -p wa -k systemd_service
-w /lib/systemd/system/ -p wa -k systemd_service

# Monitor SSH authorized_keys
-w /root/.ssh/authorized_keys -p wa -k ssh_keys
-w /home/*/.ssh/authorized_keys -p wa -k ssh_keys

# Monitor shell startup files
-w /etc/profile -p wa -k shell_startup
-w /etc/bash.bashrc -p wa -k shell_startup
-w /root/.bashrc -p wa -k shell_startup
-w /home/*/.bashrc -p wa -k shell_startup

#--------------- File Integrity ---------------
# Monitor critical binaries
-w /usr/bin/ -p wa -k binary_mod
-w /bin/ -p wa -k binary_mod
-w /sbin/ -p wa -k binary_mod
-w /usr/sbin/ -p wa -k binary_mod

# Monitor library directories
-w /lib/ -p wa -k library_mod
-w /lib64/ -p wa -k library_mod
-w /usr/lib/ -p wa -k library_mod

#--------------- Lateral Movement ---------------
# Monitor SSH daemon config
-w /etc/ssh/sshd_config -p wa -k sshd_config

# Monitor known_hosts
-w /root/.ssh/known_hosts -p wa -k ssh_known_hosts

#--------------- Network Connections ---------------
# Monitor socket creation
-a always,exit -F arch=b64 -S socket -S connect -S bind -k network
-a always,exit -F arch=b32 -S socket -S connect -S bind -k network

#--------------- Data Exfiltration ---------------
# Monitor file reads in sensitive directories
-w /etc/ssl/private/ -p r -k private_key_read
-w /root/.aws/ -p r -k aws_creds
-w /home/*/.aws/ -p r -k aws_creds

#--------------- Kernel Modules ---------------
# Monitor module loading
-w /sbin/insmod -p x -k kernel_module
-a always,exit -F arch=b64 -S init_module -S finit_module -k kernel_module





# Example auditd execve log
type=SYSCALL msg=audit(1704067200.123:456): arch=c000003e syscall=59 success=yes exit=0 a0=7f8d2c4a3b10 a1=7f8d2c4a3c20 a2=7f8d2c4a3d30 a3=7f8d2c4a3e40 items=2 ppid=12344 pid=12345 auid=1000 uid=1000 gid=1000 euid=1000 suid=1000 fsuid=1000 egid=1000 sgid=1000 fsgid=1000 tty=pts0 ses=1 comm="bash" exe="/usr/bin/bash" key="process_execution"
type=EXECVE msg=audit(1704067200.123:456): argc=3 a0="sudo" a1="systemctl" a2="stop firewall"
type=CWD msg=audit(1704067200.123:456): cwd="/home/user"
type=PATH msg=audit(1704067200.123:456): item=0 name="/usr/bin/sudo" inode=1234567 dev=08:02 mode=0104755 ouid=0 ogid=0 rdev=00:00 nametype=NORMAL

