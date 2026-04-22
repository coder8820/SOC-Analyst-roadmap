# Windows Log Analysis Guide for SOC Analysts

A comprehensive reference for detecting cyber threats using Windows Event Logs, Sysmon, and detection rules.

---

## Table of Contents

1. [Introduction](#introduction)
2. [Critical Windows Event IDs](#critical-windows-event-ids)
3. [Sysmon Event IDs](#sysmon-event-ids)
4. [Log Analysis by Attack Phase](#log-analysis-by-attack-phase)
5. [Detection Rules (Sigma-style)](#detection-rules-sigma-style)
6. [Query Examples (KQL / Splunk)](#query-examples-kql--splunk)
7. [Tuning & False Positive Reduction](#tuning--false-positive-reduction)
8. [Cheat Sheet](#cheat-sheet)

---

## Introduction

Windows Event Logs are the primary source of host-based forensic data. A SOC analyst must understand:

- **Event ID** – Identifies the type of activity
- **Event Level** – Information, Warning, Error, Critical
- **Provider** – Security, System, Application, PowerShell, Sysmon
- **XML Details** – Contains the richest data (User, Process, IP, etc.)

**Best Practice:** Always enable **Command Line Logging** (Event 4688 with command line) and **PowerShell ScriptBlock Logging**.

---

## Critical Windows Event IDs

### Authentication & Logon

| Event ID | Description | Attack Relevance |
|----------|-------------|------------------|
| 4624 | Successful logon | Normal activity; Anomaly = unusual time/location |
| 4625 | Failed logon | Brute force, password spray |
| 4648 | Logon using explicit credentials | RunAs, lateral movement (Pass-the-Hash) |
| 4672 | Special privileges assigned | Admin logon – monitor for non-admins |
| 4776 | Domain controller validated credential | NTLM authentication (Pass-the-Hash) |
| 4768 | Kerberos TGT requested | Golden ticket detection |
| 4769 | Kerberos service ticket requested | Silver ticket, RC4 usage |

### Process Creation

| Event ID | Description | Attack Relevance |
|----------|-------------|------------------|
| 4688 | Process creation | Primary source for process tracking |
| 4689 | Process termination | End of execution |
| 1 (Sysmon) | Process creation (detailed) | Includes parent process, hash, command line |

### File & Registry

| Event ID | Description | Attack Relevance |
|----------|-------------|------------------|
| 4656 | Handle to object requested | Potential file access to sensitive files |
| 4663 | File access attempted | Read/write to critical files (SAM, NTDS.dit) |
| 4657 | Registry value modified | Persistence, defense evasion |
| 13 (Sysmon) | Registry value set | Detailed registry changes |

### Scheduled Tasks & Services

| Event ID | Description | Attack Relevance |
|----------|-------------|------------------|
| 4698 | Scheduled task created | Persistence, execution |
| 4702 | Scheduled task updated | Modification of existing task |
| 7045 | Service installed | Persistence (often malicious) |

### Network Connections

| Event ID | Description | Attack Relevance |
|----------|-------------|------------------|
| 3 (Sysmon) | Network connection | Outbound C2, data exfiltration |
| 5156 | Windows Filtering Platform allowed connection | Network connection logging |

### Account Management

| Event ID | Description | Attack Relevance |
|----------|-------------|------------------|
| 4720 | User account created | Persistence, backdoor |
| 4722 | User account enabled | Re-activating disabled account |
| 4728 | User added to security-enabled global group | Privilege escalation |
| 4732 | User added to security-enabled local group | Local admin grant |

---

## Sysmon Event IDs

Sysmon (System Monitor) provides deeper telemetry than standard Windows logs. **Install and configure Sysmon in every SOC environment.**

| Event ID | Description | Detection Value |
|----------|-------------|-----------------|
| 1 | Process creation | Full command line, parent process, hash (SHA256) |
| 2 | File creation time changed | Timestomping (anti-forensics) |
| 3 | Network connection | Source/dest IP, port, process |
| 4 | Sysmon service state | Health monitoring |
| 5 | Process terminated | End of execution |
| 6 | Driver loaded | Kernel-mode rootkits |
| 7 | Image loaded | DLL injection, sideloading |
| 8 | CreateRemoteThread | Process injection |
| 9 | RawAccessRead | Direct disk read (credential dumping) |
| 10 | ProcessAccess | LSASS access (Mimikatz) |
| 11 | FileCreate | Dropped malware, ransomware |
| 12 | Registry create/delete | Persistence |
| 13 | Registry value set | Malware configuration |
| 14 | Registry key/name change | Tactic modification |
| 15 | FileCreateStreamHash | Alternate Data Streams (ADS) |
| 16 | Sysmon configuration change | Tuning or evasion |
| 17 | Named pipe created | C2 channel |
| 18 | Named pipe connected | Lateral movement (PsExec, SMB) |
| 22 | DNS query | DNS tunneling, DGA |

---

## Log Analysis by Attack Phase

### Phase 1: Initial Access (Phishing, Drive-by)

**What to look for:**
- Office/PDF spawning `cmd.exe`, `powershell.exe`, `wscript.exe`
- Scripts downloaded via `IEX (New-Object Net.WebClient).DownloadString()`
- Macros enabled from external source

**Key Events:**