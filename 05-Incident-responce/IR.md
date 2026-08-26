# Incident Response Fundamentals

> **Purpose:** A practical, cybersecurity-focused guide to Incident Response (IR), covering the incident lifecycle, detection, triage, investigation, containment, eradication, recovery, evidence handling, documentation, and realistic SOC/Blue Team examples.

---

# 1. What is Incident Response?

**Incident Response (IR)** is the structured process used by an organization to:

* Detect security incidents
* Analyze what happened
* Contain the threat
* Remove the attacker's access
* Recover affected systems
* Preserve evidence
* Document lessons learned
* Prevent similar incidents in the future

A simplified model:

```text
Detect
  ↓
Triage
  ↓
Investigate
  ↓
Contain
  ↓
Eradicate
  ↓
Recover
  ↓
Lessons Learned
```

### Simple Example

An employee receives a phishing email.

The employee clicks a malicious link.

The attacker obtains credentials.

The attacker logs into the company's VPN.

The SOC detects an unusual login.

Incident Response begins.

```text
Phishing
   ↓
Credential Theft
   ↓
Suspicious Login
   ↓
SOC Alert
   ↓
Investigation
   ↓
Account Disabled
   ↓
Sessions Revoked
   ↓
Password Reset
   ↓
MFA Enabled
   ↓
Recovery
   ↓
Lessons Learned
```

---

# 2. What is a Security Incident?

A **security incident** is an event that threatens or violates the confidentiality, integrity, or availability of information or systems.

Examples:

* Malware infection
* Phishing
* Credential theft
* Ransomware
* Unauthorized login
* Data breach
* Web application compromise
* Insider threat
* DDoS
* Privilege escalation
* Suspicious PowerShell activity
* Unauthorized cloud access

---

# 3. Event vs Alert vs Incident

These terms are often confused.

## Event

Any observable activity.

Example:

```text
User logged into VPN.
```

This is not necessarily malicious.

---

## Alert

A security tool detects something potentially suspicious.

Example:

```text
SIEM:
Multiple failed logins followed by a successful login.
```

---

## Incident

After investigation, the activity is determined to be a real security threat.

Example:

```text
The successful VPN login came from an unusual
country and was followed by suspicious internal activity.
```

Therefore:

```text
Event
  ↓
Alert
  ↓
Investigation
  ↓
Incident
```

Not every event becomes an incident.

---

# 4. CIA Triad

Incident Response is strongly connected to the CIA Triad.

## Confidentiality

Protect information from unauthorized access.

Example:

```text
Attacker steals customer database.
```

Confidentiality is compromised.

---

## Integrity

Protect information from unauthorized modification.

Example:

```text
Attacker modifies financial records.
```

Integrity is compromised.

---

## Availability

Keep systems and services available.

Example:

```text
Ransomware encrypts production servers.
```

Availability is compromised.

---

# 5. Incident Response Lifecycle

A practical Incident Response lifecycle:

```text
┌───────────────────────┐
│ Preparation            │
└──────────┬────────────┘
           ↓
┌───────────────────────┐
│ Detection & Analysis   │
└──────────┬────────────┘
           ↓
┌───────────────────────┐
│ Containment            │
└──────────┬────────────┘
           ↓
┌───────────────────────┐
│ Eradication            │
└──────────┬────────────┘
           ↓
┌───────────────────────┐
│ Recovery               │
└──────────┬────────────┘
           ↓
┌───────────────────────┐
│ Lessons Learned        │
└───────────────────────┘
```

The exact terminology varies between organizations and frameworks, but the core activities are broadly similar.

---

# 6. Phase 1 — Preparation

Preparation happens **before an incident**.

The organization prepares people, processes, and technology.

## Technical Preparation

Organizations should have:

* SIEM
* EDR/XDR
* Firewall
* IDS/IPS
* Email security
* Endpoint logging
* Centralized authentication logs
* Backups
* Network monitoring
* Vulnerability management

---

## Documentation

Maintain:

* Incident Response Plan
* Escalation Matrix
* Contact List
* Asset Inventory
* Network Diagram
* Data Classification
* Backup Strategy
* Evidence Handling Procedure

---

## People

Define responsibilities for:

```text
SOC Analyst
Incident Responder
Security Engineer
System Administrator
Network Administrator
Management
Legal
HR
Communications
```

---

# 7. Example — Preparation

Imagine a company has:

```text
500 Employees
50 Servers
200 Workstations
Cloud Infrastructure
VPN
Email System
SIEM
EDR
Firewall
```

Before an incident, the security team should know:

```text
Who owns each system?
        ↓
Where are the logs?
        ↓
How long are logs retained?
        ↓
Who can isolate an endpoint?
        ↓
Who can disable an account?
        ↓
Where are backups?
        ↓
Who must be contacted?
```

Without preparation, incident response becomes slow and chaotic.

---

# 8. Phase 2 — Detection & Analysis

This is where a potential incident is discovered.

Sources can include:

* SIEM
* EDR
* Firewall
* IDS/IPS
* Antivirus
* Cloud logs
* Authentication logs
* Users
* Threat intelligence
* Network monitoring

Example alert:

```text
ALERT

User: john.smith
Source IP: 185.x.x.x
Location: Unusual
Event: Successful VPN Login
Time: 02:13 AM
Risk: High
```

The SOC analyst begins investigation.

---

# 9. Initial Triage

Triage determines:

> **Is this actually suspicious, and how serious is it?**

Ask:

```text
Who?
What?
When?
Where?
How?
Why?
```

### Who?

Which account or system is involved?

### What?

What activity occurred?

### When?

When did it happen?

### Where?

Which host/IP/location?

### How?

How did the attacker gain access?

### Why?

What was the likely objective?

---

# 10. Incident Severity

Organizations usually classify incidents by severity.

Example:

| Severity      | Description                          |
| ------------- | ------------------------------------ |
| Critical      | Major compromise / widespread impact |
| High          | Significant security impact          |
| Medium        | Limited impact                       |
| Low           | Minor suspicious activity            |
| Informational | No confirmed security impact         |

Example:

```text
Single failed login
→ Informational

Repeated brute-force attempts
→ Medium

Successful unauthorized login
→ High

Ransomware across production
→ Critical
```

Severity criteria should be defined by the organization's own incident-response policy.

---

# 11. Incident Prioritization

Consider:

```text
Impact
+
Scope
+
Confidence
+
Asset Criticality
+
Threat Level
```

Example:

```text
Compromised employee laptop
        ↓
Medium

Compromised Domain Controller
        ↓
Critical
```

The same attacker behavior can have very different severity depending on the affected asset.

---

# 12. Example: Suspicious Login Investigation

Suppose the SIEM generates:

```text
User: ali
Source IP: 185.44.x.x
Country: Unknown
Time: 03:17 AM
Authentication: SUCCESS
MFA: Not completed
```

The analyst investigates:

### Step 1

Check whether Ali normally works at this time.

```text
Normal working hours:
09:00 - 18:00
```

### Step 2

Check previous logins.

```text
Normal locations:
Pakistan

New location:
Unknown
```

### Step 3

Check source IP reputation.

```text
Threat Intelligence:
Suspicious
```

### Step 4

Check activity after login.

```text
VPN Login
   ↓
Internal Server Access
   ↓
File Share Access
   ↓
Large Data Transfer
```

This strongly suggests compromise.

---

# 13. Evidence Collection

Evidence must be collected carefully.

Possible evidence:

* Authentication logs
* Firewall logs
* DNS logs
* Proxy logs
* EDR telemetry
* Process information
* Network connections
* Memory
* Disk images
* Suspicious files
* Browser artifacts
* Shell history
* Cloud audit logs

---

# 14. Volatile vs Non-Volatile Evidence

## Volatile Evidence

Information that may disappear when a system shuts down.

Examples:

```text
RAM
Running processes
Network connections
Logged-in users
Temporary data
```

## Non-Volatile Evidence

Persists after shutdown.

Examples:

```text
Disk files
Logs
Configuration
Database records
Backups
```

Important principle:

> **Collect volatile evidence when appropriate before shutting down or isolating a system in a way that destroys useful state.**

The exact collection order depends on the incident and organizational procedures.

---

# 15. Chain of Custody

Chain of custody documents who handled evidence.

Example:

```text
Evidence ID: EV-001

Collected by: SOC Analyst
Date: 2026-08-26
Time: 10:32
Source: SERVER-02
Type: Disk Image
Hash: SHA-256
Transferred to: Incident Response Team
```

The purpose is to maintain evidence integrity and accountability.

---

# 16. Hashing Evidence

Hashes help verify that evidence has not changed.

Example:

```bash
sha256sum evidence.img
```

Output:

```text
a8f5f167f44f4964e6c998dee827110c
```

For real investigations, record the complete SHA-256 value.

Concept:

```text
Original Evidence
       ↓
SHA-256
       ↓
Hash Recorded
       ↓
Evidence Preserved
```

If the hash later changes, investigate why.

---

# 17. Phase 3 — Containment

Containment limits the attacker's ability to continue.

There are usually two conceptual stages:

```text
Short-Term Containment
          ↓
Long-Term Containment
```

---

# 18. Short-Term Containment

Immediate actions may include:

* Isolate endpoint
* Disable compromised account
* Block malicious IP/domain
* Revoke active sessions
* Block malicious hash
* Disconnect affected server
* Restrict network access

Example:

```text
Compromised Laptop
       ↓
EDR Isolation
       ↓
Attacker loses network access
```

---

# 19. Long-Term Containment

Long-term containment may include:

* Network segmentation
* Temporary firewall restrictions
* Additional monitoring
* Account restrictions
* Service isolation
* Temporary access policies

The goal is to stop the threat while preserving the ability to investigate and recover.

---

# 20. Example — Account Compromise

Suppose:

```text
Employee: Ahmed
Account: ahmed@company.com

Attacker:
Successful VPN login
```

Immediate containment:

```text
1. Disable account
2. Revoke active sessions
3. Revoke suspicious tokens
4. Reset password
5. Require MFA reauthentication
6. Investigate affected systems
```

Do not stop at simply changing the password if the attacker may still possess valid sessions or tokens.

---

# 21. Phase 4 — Eradication

Eradication means removing the root cause and attacker foothold.

Possible actions:

* Remove malware
* Delete persistence
* Remove unauthorized accounts
* Remove malicious scheduled tasks
* Patch vulnerability
* Rotate compromised credentials
* Remove malicious SSH keys
* Rebuild compromised systems
* Fix security misconfigurations

Example:

```text
Attacker
   ↓
Web Server Vulnerability
   ↓
Web Shell
   ↓
Persistence
```

Eradication:

```text
Patch Vulnerability
       ↓
Remove Web Shell
       ↓
Remove Persistence
       ↓
Rotate Credentials
       ↓
Verify System
```

---

# 22. Example — Linux Compromise

Suppose a Linux server has been compromised.

Investigation finds:

```text
Suspicious User
      ↓
SSH Key Added
      ↓
Cron Job
      ↓
Malicious Script
      ↓
Outbound Connection
```

Eradication should address **all persistence mechanisms**, not just delete the malicious script.

Example investigation commands:

```bash
who
```

```bash
last
```

```bash
cat ~/.ssh/authorized_keys
```

```bash
crontab -l
```

```bash
systemctl list-unit-files
```

```bash
ss -tulnp
```

---

# 23. Phase 5 — Recovery

Recovery returns systems to normal operation safely.

Steps may include:

```text
Clean System
    ↓
Restore Data
    ↓
Patch System
    ↓
Change Credentials
    ↓
Verify Security Controls
    ↓
Reconnect Network
    ↓
Monitor Closely
```

Do not immediately return a compromised system to production without verification.

---

# 24. Recovery Example

Suppose:

```text
Web Server
     ↓
Compromised
```

Recovery:

```text
1. Preserve required evidence
2. Rebuild from trusted image
3. Apply security patches
4. Harden configuration
5. Rotate credentials
6. Restore verified data
7. Test application
8. Monitor logs
9. Return to production
```

In some cases, rebuilding is safer than trying to clean an extensively compromised system.

---

# 25. Phase 6 — Lessons Learned

After the incident, conduct a post-incident review.

Questions:

```text
What happened?
Why did it happen?
How was it detected?
How long was the attacker present?
What controls failed?
What worked?
What should change?
```

---

# 26. Example Lessons Learned

Incident:

```text
Phishing
   ↓
Credential Theft
   ↓
VPN Access
   ↓
Data Access
```

Findings:

```text
MFA was not enabled
Email filtering was weak
User clicked malicious link
VPN allowed broad access
Monitoring detected login late
```

Improvements:

```text
Enable MFA
Improve email security
User awareness training
Network segmentation
Improve SIEM detection
Reduce VPN privileges
```

---

# 27. Incident Response Documentation

Every significant incident should be documented.

A basic incident record:

```text
Incident ID:
IR-2026-001

Title:
Suspicious VPN Account Compromise

Severity:
High

Status:
Contained

Affected User:
user@example.com

Affected Assets:
VPN
Laptop-042
FileServer-01

Detection Time:
02:13

Incident Start:
01:58

Containment:
02:35

Root Cause:
Credential phishing

Current Status:
Recovered
```

---

# 28. Incident Timeline

A timeline is one of the most important investigation artifacts.

Example:

```text
01:42  Phishing email delivered
01:48  User clicked malicious link
01:51  Credentials submitted
01:58  Attacker attempted VPN login
02:01  VPN authentication succeeded
02:07  Internal server accessed
02:13  SIEM generated alert
02:18  SOC began investigation
02:25  Account disabled
02:30  Sessions revoked
02:35  Endpoint isolated
03:10  Investigation confirmed compromise
04:20  Persistence removed
06:00  Credentials rotated
09:00  Recovery completed
```

Timeline helps answer:

> **What happened, in what order?**

---

# 29. Indicators of Compromise — IOC

An IOC is an observable indicator associated with malicious activity.

Examples:

### IP Address

```text
185.x.x.x
```

### Domain

```text
malicious-example.com
```

### File Hash

```text
SHA256: <hash>
```

### File Path

```text
/tmp/suspicious.sh
```

### Email Address

```text
attacker@example.com
```

### Registry Key

Commonly relevant to Windows investigations.

### URL

```text
https://malicious-example.com/payload
```

---

# 30. IOC vs IOA

## IOC — Indicator of Compromise

Evidence that compromise may have occurred.

Examples:

```text
Malicious IP
Malware hash
Suspicious domain
Unexpected file
```

## IOA — Indicator of Attack

Behavior suggesting an attack is occurring.

Examples:

```text
Credential dumping
Mass authentication failures
Suspicious PowerShell execution
Privilege escalation
Lateral movement
```

Simple distinction:

```text
IOC → What indicates compromise?

IOA → What behavior indicates an attack?
```

---

# 31. TTPs

TTP stands for:

```text
Tactics
Techniques
Procedures
```

Attackers use TTPs to achieve objectives.

Example:

```text
Tactic:
Credential Access

Technique:
Phishing

Procedure:
Fake Microsoft 365 login page
```

MITRE ATT&CK is widely used to map adversary behavior.

---

# 32. MITRE ATT&CK in Incident Response

During an investigation, analysts can map observed behavior to ATT&CK techniques.

Example:

```text
Phishing
   ↓
Credential Access
   ↓
Valid Accounts
   ↓
Remote Services
   ↓
Lateral Movement
```

This helps analysts:

* Understand attacker behavior
* Improve detections
* Communicate findings
* Identify defensive gaps

---

# 33. Root Cause Analysis

Do not stop at:

> "Malware infected the computer."

Ask:

> **Why was the malware able to execute?**

Example:

```text
Malware executed
      ↓
User opened attachment
      ↓
Email filter failed
      ↓
Attachment reached user
      ↓
User had excessive privileges
      ↓
Endpoint controls failed
```

Possible root causes:

* Weak email security
* Missing security awareness
* Excessive privileges
* Missing application controls
* Outdated endpoint protection

---

# 34. Attack Chain Example

A realistic attack may look like:

```text
Reconnaissance
      ↓
Phishing
      ↓
Credential Theft
      ↓
Initial Access
      ↓
Execution
      ↓
Persistence
      ↓
Privilege Escalation
      ↓
Credential Access
      ↓
Lateral Movement
      ↓
Collection
      ↓
Exfiltration
```

Incident Response attempts to detect and disrupt this chain.

---

# 35. Complete Example — Phishing to Account Compromise

## Scenario

An employee receives:

```text
Subject:
Your Microsoft 365 password expires today
```

The email contains a malicious link.

---

## Step 1 — Initial Access

Employee clicks:

```text
Email
  ↓
Fake Login Page
```

Employee enters credentials.

Attacker receives them.

---

## Step 2 — Attacker Login

Attacker attempts:

```text
VPN Login
```

SIEM detects:

```text
Unusual Country
+
Unusual Time
+
New IP
```

Alert generated.

---

## Step 3 — Triage

SOC checks:

```text
User
IP
Time
Location
Device
MFA
Previous Login
```

Findings:

```text
User: Ahmed
Location: Pakistan
New Login: Foreign IP
Time: 03:12 AM
Device: Unknown
```

Severity:

```text
HIGH
```

---

## Step 4 — Investigation

SOC checks:

```text
VPN logs
SIEM
EDR
Firewall
Cloud audit logs
```

Finds:

```text
03:12 VPN login
03:16 File server accessed
03:18 2GB data accessed
03:21 New mailbox forwarding rule created
```

This indicates likely account compromise and possible data access.

---

# 36. Containment

SOC performs:

```text
Disable account
      ↓
Revoke sessions
      ↓
Reset password
      ↓
Revoke tokens
      ↓
Isolate affected endpoint
      ↓
Block malicious IP/domain
```

---

# 37. Eradication

Investigation finds:

```text
Malicious browser extension
```

Actions:

```text
Remove extension
      ↓
Scan endpoint
      ↓
Remove persistence
      ↓
Patch browser
      ↓
Rotate credentials
```

---

# 38. Recovery

The user is restored after:

```text
Endpoint verified clean
       ↓
Password changed
       ↓
MFA enabled
       ↓
Sessions revoked
       ↓
Access reviewed
       ↓
Monitoring enabled
```

---

# 39. Lessons Learned

Security team identifies:

```text
MFA not enforced
Email filtering insufficient
VPN access too broad
No alert for mailbox forwarding rule
```

Improvements:

```text
Enforce MFA
Improve phishing detection
Restrict VPN access
Create SIEM detection for suspicious forwarding rules
Conduct awareness training
```

---

# 40. Example — Ransomware Incident

## Scenario

A workstation begins encrypting files.

EDR detects:

```text
Mass File Modification
+
Suspicious Process
```

SOC receives:

```text
CRITICAL ALERT
```

---

## Detection

```text
EDR
 ↓
Mass Encryption Detected
 ↓
SOC Alert
```

---

## Triage

Check:

```text
Affected User
Affected Host
Process
Parent Process
File Changes
Network Connections
Other Hosts
```

---

## Containment

Immediately:

```text
Isolate Endpoint
       ↓
Disable compromised account if necessary
       ↓
Block malicious infrastructure
       ↓
Check lateral movement
```

---

## Investigation

Determine:

```text
Initial Access
    ↓
Execution
    ↓
Persistence
    ↓
Privilege Escalation
    ↓
Lateral Movement
    ↓
Encryption
```

---

## Eradication

Actions may include:

```text
Remove malware
Remove persistence
Patch vulnerability
Rotate credentials
Rebuild affected systems
```

---

## Recovery

```text
Restore from verified backups
       ↓
Validate systems
       ↓
Reconnect carefully
       ↓
Monitor
```

---

# 41. Example — Linux Web Server Compromise

## Alert

SOC receives:

```text
Outbound Connection
Server: WEB-01
Destination: Suspicious IP
Port: 443
```

---

## Investigation

Check:

```bash
ss -tulnp
```

Find suspicious process.

```bash
ps aux
```

Investigate process:

```bash
ls -l /proc/<PID>/exe
```

Search web directory:

```bash
find /var/www -type f -mtime -2
```

Search suspicious commands/content:

```bash
grep -R "base64_decode" /var/www 2>/dev/null
```

Check cron:

```bash
crontab -l
```

Check SSH keys:

```bash
cat ~/.ssh/authorized_keys
```

---

## Findings

Suppose the investigation finds:

```text
Vulnerable Web Application
        ↓
Web Shell
        ↓
Attacker Execution
        ↓
Persistence
        ↓
Outbound C2 Connection
```

---

## Containment

```text
Remove server from load balancer
        ↓
Restrict network access
        ↓
Preserve evidence
```

---

## Eradication

```text
Patch application
      ↓
Remove malicious files
      ↓
Remove persistence
      ↓
Rotate credentials
      ↓
Rebuild server if required
```

---

## Recovery

```text
Deploy clean server
      ↓
Restore trusted application
      ↓
Validate configuration
      ↓
Monitor traffic
      ↓
Return to production
```

---

# 42. SOC Analyst's First Response Checklist

When an alert arrives:

```text
- [ ] Read the complete alert
- [ ] Identify affected user
- [ ] Identify affected host
- [ ] Identify source IP
- [ ] Identify destination IP
- [ ] Identify timestamp
- [ ] Identify process/service
- [ ] Check related alerts
- [ ] Check authentication activity
- [ ] Check network activity
- [ ] Check endpoint telemetry
- [ ] Determine severity
- [ ] Decide whether escalation is required
- [ ] Document findings
```

---

# 43. Incident Response Command Cheat Sheet

## Linux

```bash
whoami
id
who
w
last
ps aux
pstree
top
ss -tulnp
ip addr
ip route
journalctl
systemctl
crontab -l
find
grep
sha256sum
```

## Windows

```powershell
whoami
ipconfig /all
netstat -ano
tasklist
Get-Process
Get-Service
Get-WinEvent
Get-NetTCPConnection
```

---

# 44. Important Windows IR Locations

For Windows investigations, commonly relevant artifacts include:

```text
Windows Event Logs
PowerShell logs
Security logs
Sysmon logs
Registry
Prefetch
Scheduled Tasks
Services
Browser artifacts
EDR telemetry
Windows Defender logs
```

Important Event IDs vary by environment, but analysts commonly investigate events related to:

* Logons
* Process creation
* Account changes
* Service installation
* PowerShell activity
* Scheduled tasks

---

# 45. SIEM in Incident Response

A SIEM centralizes security logs and provides detection and investigation capabilities.

Example:

```text
Firewall
   \
EDR ----\
DNS ----- > SIEM → Detection → Analyst
VPN -----/
Cloud ---/
```

SOC analysts use SIEM to:

* Search events
* Correlate logs
* Detect attacks
* Investigate incidents
* Create alerts
* Build timelines

---

# 46. Example SIEM Investigation

Search:

```text
User = ahmed
```

Find:

```text
VPN Login
     ↓
Cloud Login
     ↓
File Server Access
     ↓
Large Download
```

Then search:

```text
Source IP = suspicious IP
```

Find:

```text
Multiple users targeted
```

This may indicate:

```text
Credential Attack
```

---

# 47. Detection Engineering

Incident Response should improve detection capabilities.

Example:

Incident:

```text
Attacker created suspicious mailbox forwarding rule.
```

After incident:

Create detection:

```text
New External Mail Forwarding Rule
+
Unusual User
+
New Location
=
High Risk Alert
```

The incident therefore improves future defenses.

---

# 48. False Positive

A false positive occurs when a security system reports malicious activity that is actually legitimate.

Example:

```text
SOC Alert:
Impossible Travel

Reality:
User was using corporate VPN.
```

Analyst should:

```text
Investigate
↓
Confirm legitimate activity
↓
Document
↓
Tune detection if necessary
```

---

# 49. False Negative

A false negative occurs when malicious activity is not detected.

Example:

```text
Attacker compromises account.
       ↓
No SIEM alert.
       ↓
Attacker remains undetected.
```

False negatives are particularly dangerous because the organization may not know the attack is happening.

---

# 50. Mean Time Metrics

Important security metrics include:

### MTTD

**Mean Time to Detect**

How long it takes to detect an incident.

### MTTR

**Mean Time to Respond/Recover**

How long it takes to respond or restore operations, depending on the organization's definition.

Example:

```text
Attack starts:
01:00

Detected:
01:20

MTTD:
20 minutes
```

---

# 51. Incident Communication

Communication should be:

* Accurate
* Concise
* Evidence-based
* Timely
* Controlled

Avoid saying:

> "We definitely know the attacker stole everything."

unless evidence supports that conclusion.

Prefer:

> "Investigation identified unauthorized access to the file server. The scope of data accessed is currently being determined."

---

# 52. Incident Report Template

```text
# Incident Report

## Incident ID
IR-2026-001

## Title
Suspicious Account Compromise

## Severity
High

## Status
Closed

## Detection
SIEM Alert

## Affected Assets
VPN
User Laptop
File Server

## Timeline
[Insert timeline]

## Initial Access
Phishing

## Indicators of Compromise
[Insert IOCs]

## Investigation
[Insert findings]

## Containment
[Insert actions]

## Eradication
[Insert actions]

## Recovery
[Insert actions]

## Root Cause
[Insert root cause]

## Business Impact
[Insert impact]

## Lessons Learned
[Insert lessons]

## Recommendations
[Insert recommendations]
```

---

# 53. Incident Response Mindset

A strong incident responder does not immediately jump to conclusions.

Use:

```text
Observe
   ↓
Collect Evidence
   ↓
Validate
   ↓
Correlate
   ↓
Form Hypothesis
   ↓
Test Hypothesis
   ↓
Take Action
   ↓
Document
```

### Bad Approach

```text
Alert
 ↓
"Probably malware."
 ↓
Delete everything
```

### Better Approach

```text
Alert
 ↓
Validate
 ↓
Collect evidence
 ↓
Understand scope
 ↓
Contain
 ↓
Eradicate
 ↓
Recover
```

---

# 54. Incident Response Golden Questions

During almost every investigation, ask:

### 1. What happened?

```text
What security event occurred?
```

### 2. When did it happen?

```text
First known activity?
Last known activity?
```

### 3. How did it happen?

```text
Phishing?
Vulnerability?
Stolen credentials?
Misconfiguration?
```

### 4. What was affected?

```text
Users
Endpoints
Servers
Applications
Cloud
Data
```

### 5. Is the attacker still present?

```text
Active sessions?
Processes?
Persistence?
Network connections?
```

### 6. What is the scope?

```text
One system?
Multiple systems?
Entire environment?
```

### 7. What must be done immediately?

```text
Containment
```

### 8. How do we prevent recurrence?

```text
Remediation
+
Hardening
+
Detection improvements
```

---

# 55. Incident Response Workflow

A complete practical workflow:

```text
                 ALERT
                   ↓
               TRIAGE
                   ↓
        ┌──────────┴──────────┐
        │                     │
     Benign                 Suspicious
        │                     │
      Close              Investigate
                              ↓
                         Confirmed?
                              ↓
                             YES
                              ↓
                         Classify
                              ↓
                         Contain
                              ↓
                         Preserve
                         Evidence
                              ↓
                         Investigate
                              ↓
                         Eradicate
                              ↓
                          Recover
                              ↓
                      Lessons Learned
                              ↓
                     Improve Detection
```

---

# 56. Practical Skills to Master

For a SOC/Blue Team Incident Responder, focus on:

## Networking

```text
TCP/IP
DNS
HTTP/HTTPS
Ports
Routing
Firewalls
VPN
Packet Analysis
```

## Linux

```text
Processes
Permissions
Logs
SSH
Services
Bash
Filesystem
Persistence
```

## Windows

```text
Event Logs
PowerShell
Processes
Services
Registry
Active Directory
Sysmon
```

## Security

```text
MITRE ATT&CK
IOC
IOA
Threat Intelligence
Malware Basics
Phishing
Credential Attacks
Lateral Movement
Persistence
```

## Tools

```text
SIEM
EDR/XDR
Wireshark
tcpdump
Nmap
Velociraptor
Autopsy
Volatility
YARA
CyberChef
```

---

# 57. Incident Response Learning Roadmap

```text
Cybersecurity Fundamentals
          ↓
Networking
          ↓
Linux
          ↓
Windows
          ↓
Security Logs
          ↓
SIEM
          ↓
Detection Engineering
          ↓
Incident Triage
          ↓
Digital Forensics
          ↓
Malware Analysis Basics
          ↓
Threat Intelligence
          ↓
Incident Response
          ↓
Threat Hunting
          ↓
Advanced Blue Team
```

---

# 58. Final Incident Response Checklist

Before considering yourself comfortable with Incident Response, you should understand:

* [ ] Event vs Alert vs Incident
* [ ] CIA Triad
* [ ] Incident Response Lifecycle
* [ ] Preparation
* [ ] Detection
* [ ] Triage
* [ ] Severity
* [ ] Investigation
* [ ] Evidence Collection
* [ ] Volatile Evidence
* [ ] Chain of Custody
* [ ] Hashing
* [ ] Containment
* [ ] Eradication
* [ ] Recovery
* [ ] Lessons Learned
* [ ] IOC
* [ ] IOA
* [ ] TTP
* [ ] MITRE ATT&CK
* [ ] Timeline Creation
* [ ] Root Cause Analysis
* [ ] SIEM Investigation
* [ ] EDR Investigation
* [ ] Linux Investigation
* [ ] Windows Investigation
* [ ] Network Investigation
* [ ] Phishing Investigation
* [ ] Account Compromise
* [ ] Malware Incident
* [ ] Ransomware Response
* [ ] Web Server Compromise
* [ ] Incident Documentation
* [ ] Detection Improvement

---

# 59. Final Mental Model

When you receive a security alert, think:

```text
                ALERT
                  ↓
            Is it real?
                  ↓
              What happened?
                  ↓
              Who is affected?
                  ↓
             Which systems?
                  ↓
             How did it happen?
                  ↓
          Is attacker still active?
                  ↓
              What is the scope?
                  ↓
              CONTAIN
                  ↓
            PRESERVE EVIDENCE
                  ↓
             INVESTIGATE
                  ↓
              ERADICATE
                  ↓
               RECOVER
                  ↓
          LESSONS LEARNED
                  ↓
          IMPROVE SECURITY
```

---

# 60. Final Takeaway

> **Incident Response is not simply "removing malware." It is the disciplined process of understanding what happened, determining the scope and impact, containing the threat, preserving evidence, removing the attacker's foothold, safely restoring operations, and improving defenses so the same incident is less likely to happen again.**

A strong Incident Responder combines:

```text
Networking
    +
Linux
    +
Windows
    +
Logs
    +
SIEM
    +
EDR
    +
Threat Intelligence
    +
Digital Forensics
    +
MITRE ATT&CK
    +
Critical Thinking
    +
Documentation
```

The most important skill is not memorizing commands.

It is learning to answer:

> **What happened, how do I know, what is affected, what is the attacker doing, what should I do next, and how can I prove my conclusion?**
