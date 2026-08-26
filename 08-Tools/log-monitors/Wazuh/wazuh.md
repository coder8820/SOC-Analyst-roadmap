# Wazuh — Complete Cybersecurity & SOC Notes

> **Purpose:** Wazuh ko zero se practical SOC Analyst level tak samajhna. Is document mein architecture, agents, manager, rules, decoders, FIM, vulnerability detection, MITRE ATT&CK, alert investigation aur Incident Response ke saath Wazuh ka practical relationship cover kiya gaya hai.

---

# 1. What is Wazuh?

**Wazuh** ek open-source security monitoring platform hai jo endpoints, servers aur infrastructure se security-related data collect, analyze aur monitor karta hai.

Wazuh ka use commonly:

* Security monitoring
* Log analysis
* Threat detection
* Endpoint monitoring
* File Integrity Monitoring (FIM)
* Vulnerability detection
* Security Configuration Assessment
* Compliance monitoring
* Incident investigation
* Threat detection

ke liye hota hai.

### Simple Definition

> **Wazuh is an open-source security monitoring platform that helps organizations detect, investigate, and respond to security threats across endpoints and infrastructure.**

---

# 2. Wazuh as a SOC Tool

SOC mein Wazuh ko ek security monitoring platform ke taur par use kiya ja sakta hai.

Basic workflow:

```text
Endpoint
   ↓
Wazuh Agent
   ↓
Wazuh Manager
   ↓
Analysis / Rules
   ↓
Security Alert
   ↓
Wazuh Indexer
   ↓
Wazuh Dashboard
   ↓
SOC Analyst
```

Example:

```text
Linux Server
     ↓
Multiple SSH Login Failures
     ↓
Wazuh Agent
     ↓
Wazuh Manager
     ↓
Detection Rule
     ↓
Alert
     ↓
SOC Analyst
```

---

# 3. Why is Wazuh Important?

A security team ke paas hundreds ya thousands of systems ho sakte hain.

Har machine manually monitor karna practically possible nahi hota.

Wazuh centralized visibility provide karta hai.

Without centralized monitoring:

```text
100 Computers
     ↓
100 Different Logs
     ↓
Manual Investigation
     ↓
Very Difficult
```

With Wazuh:

```text
100 Computers
      ↓
Wazuh Agents
      ↓
Centralized Monitoring
      ↓
Wazuh Manager
      ↓
Alerts
      ↓
SOC Analyst
```

---

# 4. Wazuh Architecture

Wazuh environment ke important components:

```text
┌───────────────────────────┐
│       Endpoints           │
│                           │
│ Windows │ Linux │ Server  │
└─────────────┬─────────────┘
              │
              ▼
┌───────────────────────────┐
│       Wazuh Agents        │
└─────────────┬─────────────┘
              │
              ▼
┌───────────────────────────┐
│      Wazuh Manager        │
│                           │
│ Rules                     │
│ Decoders                  │
│ Analysis                  │
└─────────────┬─────────────┘
              │
              ▼
┌───────────────────────────┐
│      Wazuh Indexer        │
│                           │
│ Event / Alert Storage     │
└─────────────┬─────────────┘
              │
              ▼
┌───────────────────────────┐
│     Wazuh Dashboard       │
│                           │
│ SOC Analyst               │
└───────────────────────────┘
```

---

# 5. Main Wazuh Components

Wazuh environment ko primarily in components se samjho:

1. Wazuh Agent
2. Wazuh Manager
3. Wazuh Indexer
4. Wazuh Dashboard

---

# 6. Wazuh Agent

**Wazuh Agent** endpoint/server par install hota hai.

Example:

```text
Windows PC
    ↓
Wazuh Agent
```

Ya:

```text
Ubuntu Server
    ↓
Wazuh Agent
```

Agent endpoint se security-related information collect karta hai aur Wazuh server ko bhejta hai.

### Agent Can Monitor

* Logs
* Processes
* System information
* File changes
* Security events
* Configuration
* Installed software
* Authentication activity

---

# 7. Wazuh Manager

**Wazuh Manager** central analysis component hai.

Isko Wazuh environment ka **brain** samajh sakte ho.

Manager:

* Agent data receive karta hai
* Logs process karta hai
* Decoders apply karta hai
* Rules evaluate karta hai
* Alerts generate karta hai
* Security events analyze karta hai

Basic flow:

```text
Agent
  ↓
Event
  ↓
Manager
  ↓
Decoder
  ↓
Rule
  ↓
Alert
```

---

# 8. Wazuh Indexer

**Wazuh Indexer** events aur alerts ko store aur search karne ke liye use hota hai.

Example:

```text
Wazuh Manager
      ↓
Security Events
      ↓
Wazuh Indexer
      ↓
Stored Data
      ↓
Search / Analysis
```

Historical investigation mein ye important hota hai.

Example:

```text
"Last 7 days mein is user ne kin systems par login kiya?"
```

Is type ki investigation ke liye stored event data useful hota hai.

---

# 9. Wazuh Dashboard

**Wazuh Dashboard** graphical interface hai jahan security analysts:

* Alerts dekhte hain
* Events search karte hain
* Agents monitor karte hain
* Vulnerabilities check karte hain
* FIM events investigate karte hain
* Security configuration review karte hain
* Security trends visualize karte hain

Example:

```text
┌──────────────────────────────────────┐
│          WAZUH DASHBOARD             │
├──────────────────────────────────────┤
│ Agents:              25              │
│ High Alerts:         12              │
│ Critical Alerts:      3              │
│ Vulnerabilities:     87              │
│ FIM Events:         120              │
└──────────────────────────────────────┘
```

---

# 10. Event vs Alert

Wazuh samajhne se pehle ye distinction important hai.

## Event

System mein koi activity.

Example:

```text
User logged in.
```

Ye automatically malicious nahi hai.

---

## Alert

Security system ko activity suspicious lagti hai.

Example:

```text
20 failed login attempts
followed by
successful login
```

Wazuh detection logic is activity ko alert bana sakti hai.

---

# 11. Wazuh Detection Workflow

Basic detection process:

```text
System Activity
      ↓
Wazuh Agent
      ↓
Log / Event
      ↓
Wazuh Manager
      ↓
Decoder
      ↓
Detection Rule
      ↓
Alert
      ↓
SOC Analyst
```

---

# 12. Wazuh Rules

**Rules** Wazuh ke most important concepts mein se ek hain.

Rules security events ko evaluate karne mein help karti hain.

Conceptual example:

```text
IF:

Multiple authentication failures

THEN:

Generate security alert
```

Example:

```text
Failed Login
Failed Login
Failed Login
Failed Login
Failed Login
       ↓
Possible Brute Force
       ↓
Security Alert
```

---

# 13. Rule Severity

Wazuh alerts ko severity level diya ja sakta hai.

Common conceptual categories:

```text
Low
Medium
High
Critical
```

Example:

```text
Normal Activity
      ↓
Low

Suspicious Activity
      ↓
Medium

Confirmed Suspicious Activity
      ↓
High

Major Security Incident
      ↓
Critical
```

Actual severity configured detection rule aur environment par depend karti hai.

---

# 14. Decoders

Different applications aur operating systems logs ko different formats mein generate karte hain.

Example:

```text
Linux SSH Log
Windows Event Log
Apache Log
Firewall Log
```

Wazuh ko raw log se useful fields identify karni hoti hain.

**Decoder** log ko parse/interpret karne mein help karta hai.

Concept:

```text
Raw Log
   ↓
Decoder
   ↓
User
Source IP
Timestamp
Event
Status
```

---

# 15. Example — SSH Log

Suppose Linux server par:

```text
Failed password for root from 192.168.1.50
```

Wazuh is event se information identify kar sakta hai:

```text
User:
root

Source IP:
192.168.1.50

Event:
Failed Authentication
```

Phir detection rule evaluate kar sakti hai ke activity suspicious hai ya nahi.

---

# 16. Wazuh + Linux

Linux servers ke liye Wazuh particularly useful hai.

Possible monitoring areas:

```text
Authentication
SSH
System Logs
Processes
Services
File Changes
Configuration
Users
Cron Jobs
Network Activity
```

Example logs:

```text
/var/log/auth.log
/var/log/syslog
```

Distribution ke according log locations different ho sakti hain.

---

# 17. SSH Brute Force Example

Suppose attacker repeatedly SSH login attempt karta hai:

```text
Failed Login
Failed Login
Failed Login
Failed Login
Failed Login
Failed Login
```

Wazuh workflow:

```text
SSH
 ↓
Authentication Logs
 ↓
Wazuh Agent
 ↓
Wazuh Manager
 ↓
Rule Analysis
 ↓
Brute Force Alert
 ↓
SOC Analyst
```

Analyst check karega:

```text
Source IP
Username
Timestamp
Number of Attempts
Target Server
Related Events
```

---

# 18. Wazuh + Windows

Windows environments mein Wazuh Windows security events ko monitor karne mein help karta hai.

Examples:

```text
Login Events
Failed Login
Account Creation
Account Changes
Process Activity
Security Policy Changes
PowerShell Activity
System Events
```

Example:

```text
Multiple Failed Logins
        ↓
Successful Login
        ↓
New Device
        ↓
Suspicious Activity
```

Wazuh alert generate kar sakta hai.

---

# 19. File Integrity Monitoring — FIM

**FIM = File Integrity Monitoring**

FIM ka purpose important files mein unauthorized changes detect karna hai.

Example:

```text
/etc/passwd
/etc/ssh/sshd_config
Web Application Files
Configuration Files
```

Basic concept:

```text
Original File
     ↓
Baseline
     ↓
File Modified
     ↓
Wazuh Detects Change
     ↓
Alert
```

---

# 20. FIM Example

Suppose:

```text
/var/www/html/index.php
```

website ka important file hai.

Attacker file modify karta hai.

Wazuh:

```text
File Modified
      ↓
Hash Changed
      ↓
User Identified
      ↓
Timestamp
      ↓
Security Alert
```

SOC analyst investigate karega:

```text
Who modified the file?
When?
What process modified it?
What was the previous state?
What is the current state?
```

---

# 21. Why FIM is Important?

Attackers compromised system par:

* Web shells
* Backdoors
* Malicious scripts
* Persistence mechanisms
* Configuration modifications

create kar sakte hain.

FIM unauthorized changes ko detect karne mein help karta hai.

---

# 22. Vulnerability Detection

Wazuh vulnerability detection capabilities ke through endpoints par installed software ko known vulnerabilities ke against assess karne mein help karta hai.

Example:

```text
Server
  ↓
Installed Software
  ↓
Known Vulnerability
  ↓
Wazuh
  ↓
Vulnerability Finding
```

Example:

```text
Apache
Version: X.Y.Z
       ↓
Known CVE
       ↓
High Severity
```

SOC/security team remediation prioritize kar sakti hai.

---

# 23. CVE

**CVE = Common Vulnerabilities and Exposures**

CVE publicly identified vulnerabilities ko track karne ke liye standardized identifier system hai.

Example format:

```text
CVE-2026-XXXX
```

Wazuh vulnerability findings mein CVE information useful ho sakti hai.

---

# 24. Security Configuration Assessment

Wazuh systems ki security configuration assess karne mein bhi help karta hai.

Examples:

```text
Password Policy
Firewall Configuration
SSH Configuration
File Permissions
System Settings
Security Controls
```

Example:

```text
Required Password Length:
12

Actual:
6
```

Possible finding:

```text
Security Configuration Weak
```

---

# 25. Wazuh + MITRE ATT&CK

Wazuh security detections ko **MITRE ATT&CK** techniques ke context mein understand karne mein help kar sakta hai.

Example:

```text
Attacker Activity
       ↓
Credential Access
       ↓
MITRE ATT&CK Technique
       ↓
Wazuh Detection
       ↓
SOC Alert
```

MITRE ATT&CK SOC analysts ko attacker behavior understand aur classify karne mein help karta hai.

---

# 26. IOC

**IOC = Indicator of Compromise**

Examples:

```text
Malicious IP
Malicious Domain
File Hash
Suspicious File
Malicious URL
Suspicious Email Address
```

Example:

```text
Source IP:
185.x.x.x

Reputation:
Malicious

       ↓

Wazuh Investigation
```

---

# 27. IOA

**IOA = Indicator of Attack**

Ye attacker behavior ko represent karta hai.

Examples:

```text
Credential Dumping
Brute Force
Privilege Escalation
Lateral Movement
Suspicious PowerShell
Persistence
```

Simple difference:

```text
IOC
↓
What indicates compromise?

IOA
↓
What indicates attack behavior?
```

---

# 28. Wazuh + Incident Response

Wazuh ko Incident Response lifecycle ke saath connect karo:

```text
Preparation
     ↓
Detection
     ↓
Triage
     ↓
Investigation
     ↓
Containment
     ↓
Eradication
     ↓
Recovery
     ↓
Lessons Learned
```

Wazuh mainly visibility aur detection/investigation mein help karta hai.

Example:

```text
Attacker
   ↓
SSH Brute Force
   ↓
Wazuh Detection
   ↓
Alert
   ↓
SOC Analyst
   ↓
Investigation
   ↓
Containment
```

Response actions environment aur integrations ke according manually ya automated tools ke through perform kiye ja sakte hain.

---

# 29. Real-World Example — Account Compromise

Suppose employee account compromise ho gaya.

Attacker:

```text
Stolen Credentials
       ↓
VPN Login
       ↓
Internal Access
```

Wazuh detects:

```text
Unusual Authentication
```

SOC analyst checks:

```text
User
Source IP
Location
Time
Device
Previous Login
Related Events
```

Investigation:

```text
03:12 — VPN Login
03:15 — File Server Access
03:18 — Large Data Access
03:20 — Suspicious Activity
```

Possible incident:

```text
Credential Compromise
```

---

# 30. Containment

SOC team may perform actions such as:

```text
Disable Account
       ↓
Revoke Sessions
       ↓
Reset Password
       ↓
Revoke Tokens
       ↓
Isolate Endpoint
       ↓
Block Malicious Infrastructure
```

Important:

> Wazuh alert generate karna aur complete incident response karna do different cheezen hain.

---

# 31. Wazuh + Threat Hunting

Threat hunting ka matlab hai proactively suspicious activity search karna.

Example question:

> "Kya last 30 days mein kisi endpoint par unusual SSH activity hui?"

Search:

```text
SSH Events
      ↓
Source IPs
      ↓
Users
      ↓
Frequency
      ↓
Related Activity
```

Wazuh historical security data investigation mein help karta hai.

---

# 32. Wazuh + SIEM

Wazuh ko SIEM-like security monitoring solution ke taur par use kiya ja sakta hai.

Traditional SIEM workflow:

```text
Collect Logs
     ↓
Centralize
     ↓
Correlate
     ↓
Analyze
     ↓
Detect
     ↓
Alert
```

Wazuh bhi centralized security monitoring aur analysis capabilities provide karta hai, along with endpoint-focused features.

---

# 33. Wazuh vs Antivirus

### Antivirus

Primary focus:

```text
Malware Detection
Malware Prevention
Malware Removal
```

### Wazuh

Broader security monitoring:

```text
Logs
Events
FIM
Vulnerabilities
Configuration
Threat Detection
Endpoint Monitoring
Compliance
```

Therefore:

```text
Wazuh ≠ Traditional Antivirus
```

Wazuh ko antivirus ka direct replacement nahi samajhna chahiye.

---

# 34. Wazuh vs EDR

EDR ka primary focus endpoint detection and response hota hai.

Wazuh endpoint monitoring aur security detection capabilities provide karta hai, lekin commercial EDR products ke capabilities aur response depth product-to-product different hoti hain.

Conceptually:

```text
EDR
 ↓
Deep Endpoint Visibility
+
Detection
+
Response
```

Wazuh:

```text
Endpoint Monitoring
+
Log Analysis
+
FIM
+
Vulnerability Detection
+
Configuration Assessment
+
Security Detection
```

Wazuh ko apni capabilities aur deployment ke context mein evaluate karna chahiye.

---

# 35. Wazuh SOC Lab

Learning ke liye ek useful lab architecture:

```text
                Wazuh Server
                     │
          ┌──────────┴──────────┐
          │                     │
          ▼                     ▼
     Windows VM             Linux VM
     Wazuh Agent            Wazuh Agent
          │                     │
          └──────────┬──────────┘
                     ▼
              Wazuh Dashboard
                     │
                     ▼
                SOC Analyst
```

---

# 36. Lab 1 — SSH Monitoring

Linux VM par Wazuh Agent configure karo.

Lab environment mein failed SSH authentication events generate/test karo.

Example:

```text
Failed SSH Login
Failed SSH Login
Failed SSH Login
```

Then Wazuh dashboard par investigate karo.

Check:

```text
Source IP
Username
Timestamp
Number of Attempts
Target Host
```

Goal:

```text
Authentication Event
       ↓
Detection
       ↓
Alert
       ↓
Investigation
```

---

# 37. Lab 2 — File Integrity Monitoring

Test file:

```bash
echo "original" > test.txt
```

Phir modify:

```bash
echo "modified" > test.txt
```

Expected concept:

```text
File
 ↓
Modification
 ↓
FIM Detection
 ↓
Wazuh Alert
```

Investigation:

```text
Which file?
Who changed it?
When?
What changed?
```

---

# 38. Lab 3 — Windows Security Monitoring

Windows VM ko Wazuh Agent ke saath connect karo.

Authentication activity monitor karo.

Example investigation:

```text
Multiple Failed Logins
        ↓
Successful Login
        ↓
Unusual Source
        ↓
SOC Investigation
```

Goal:

> Authentication events ko read aur investigate karna seekhna.

---

# 39. Lab 4 — Vulnerability Monitoring

Linux/Windows VM par intentionally outdated software **sirf isolated lab environment mein** use karo.

Wazuh vulnerability findings check karo.

Understand:

```text
Software
   ↓
Version
   ↓
Known Vulnerability
   ↓
Severity
   ↓
Remediation
```

Production systems par deliberately vulnerable software use nahi karna chahiye.

---

# 40. Alert Investigation Method

Wazuh alert receive hone ke baad:

```text
1. Read Alert
      ↓
2. Identify Host
      ↓
3. Identify User
      ↓
4. Check Timestamp
      ↓
5. Check Source IP
      ↓
6. Check Related Events
      ↓
7. Determine Scope
      ↓
8. Determine Severity
      ↓
9. Investigate
      ↓
10. Respond / Escalate
      ↓
11. Document
```

---

# 41. Golden Questions for SOC Analyst

Har alert par ye questions poochho:

### Who?

```text
Which user?
```

### What?

```text
What happened?
```

### When?

```text
When did it happen?
```

### Where?

```text
Which host?
Which IP?
```

### How?

```text
How did the activity occur?
```

### Scope?

```text
One endpoint?
Multiple endpoints?
```

### Impact?

```text
Was data or infrastructure affected?
```

### Next Action?

```text
Close?
Monitor?
Escalate?
Contain?
```

---

# 42. False Positive

False positive ka matlab:

> Security alert generate hua, lekin actual malicious activity nahi thi.

Example:

```text
Wazuh Alert
     ↓
Suspicious Login
     ↓
Investigation
     ↓
User was using Corporate VPN
     ↓
Benign Activity
```

SOC analyst:

```text
Investigate
   ↓
Confirm
   ↓
Document
   ↓
Close / Tune Detection
```

---

# 43. False Negative

False negative:

> Malicious activity hui, lekin detection system ne alert generate nahi kiya.

Example:

```text
Attacker
   ↓
Account Compromise
   ↓
No Alert
   ↓
Attacker Remains Undetected
```

False negatives security monitoring ke liye serious problem hain.

---

# 44. Wazuh Custom Rules

Advanced Wazuh learning mein tum **custom detection rules** create karna seekh sakte ho.

Concept:

```text
Specific Event
      ↓
Custom Rule
      ↓
Detection
      ↓
Alert
```

Example requirement:

> Agar privileged account unusual location se login kare to high-priority alert generate karo.

Conceptual logic:

```text
Privileged User
+
Unusual Source
+
Successful Login
=
High-Risk Alert
```

Custom rules SOC environments mein detection engineering ka important part hain.

---

# 45. Wazuh Automation

Wazuh ko automation ke saath integrate kiya ja sakta hai.

Concept:

```text
Detection
   ↓
Alert
   ↓
Automated Response
   ↓
Action
```

Possible response examples:

```text
Block IP
Disable Account
Isolate Endpoint
Run Script
Send Notification
```

Automation carefully design karni chahiye.

> **High-impact automatic actions ko production environment mein blindly enable nahi karna chahiye**, warna false positive legitimate users/systems ko affect kar sakta hai.

---

# 46. Wazuh and MITRE ATT&CK Investigation

Suppose Wazuh alert suspicious PowerShell execution show karta hai.

Analyst:

```text
Alert
 ↓
Process Investigation
 ↓
Parent Process
 ↓
Command Line
 ↓
User
 ↓
Network Connection
 ↓
MITRE ATT&CK Mapping
```

This helps answer:

```text
What technique might the attacker be using?
```

---

# 47. Wazuh Data Flow

Complete mental model:

```text
                  ENDPOINT
                     │
                     ▼
               WAZUH AGENT
                     │
                     ▼
              SECURITY DATA
                     │
                     ▼
              WAZUH MANAGER
                     │
             ┌───────┴────────┐
             │                │
             ▼                ▼
          Decoder           Rules
             │                │
             └───────┬────────┘
                     ▼
                   ALERT
                     │
                     ▼
              WAZUH INDEXER
                     │
                     ▼
              WAZUH DASHBOARD
                     │
                     ▼
                SOC ANALYST
                     │
                     ▼
               INVESTIGATION
                     │
                     ▼
             INCIDENT RESPONSE
```

---

# 48. Wazuh Learning Roadmap

Wazuh ko is order mein learn karna best rahega:

```text
1. Linux Basics
       ↓
2. Windows Basics
       ↓
3. Networking
       ↓
4. Log Fundamentals
       ↓
5. SIEM Concepts
       ↓
6. Wazuh Architecture
       ↓
7. Wazuh Installation
       ↓
8. Agent Management
       ↓
9. Wazuh Dashboard
       ↓
10. Rules
       ↓
11. Decoders
       ↓
12. File Integrity Monitoring
       ↓
13. Vulnerability Detection
       ↓
14. Security Configuration
       ↓
15. MITRE ATT&CK
       ↓
16. Alert Investigation
       ↓
17. Custom Detection Rules
       ↓
18. Incident Response
       ↓
19. Threat Hunting
       ↓
20. Detection Engineering
```

---

# 49. Skills Required Before Wazuh

Wazuh ko properly samajhne ke liye ye fundamentals strong hone chahiye:

## Networking

```text
TCP/IP
DNS
HTTP/HTTPS
Ports
IP Addresses
Routing
Firewall
VPN
```

## Linux

```text
Filesystem
Permissions
Processes
Services
SSH
Logs
Bash
Cron
```

## Windows

```text
Event Logs
Processes
Services
PowerShell
Registry
Authentication
Active Directory Basics
```

## Cybersecurity

```text
CIA Triad
Authentication
Authorization
Malware
Phishing
Brute Force
Persistence
Privilege Escalation
Lateral Movement
MITRE ATT&CK
IOC
IOA
```

---

# 50. Important Commands for Wazuh Learning

Wazuh khud commands se zyada important **underlying OS investigation skills** require karta hai.

### Linux

```bash
whoami
id
who
w
last
ps aux
pstree
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

### Windows PowerShell

```powershell
whoami
ipconfig /all
Get-Process
Get-Service
Get-WinEvent
Get-NetTCPConnection
```

Ye commands tumhe Wazuh alerts ko independently validate karne mein help karti hain.

---

# 51. Practical SOC Scenario

## Scenario

Wazuh alert:

```text
Multiple Failed SSH Authentication Attempts
```

### Step 1 — Identify Target

```text
Server:
WEB-01
```

### Step 2 — Identify Source

```text
Source IP:
192.168.1.50
```

### Step 3 — Identify User

```text
User:
root
```

### Step 4 — Check Timeline

```text
10:01 Failed Login
10:02 Failed Login
10:02 Failed Login
10:03 Failed Login
10:03 Successful Login
```

### Step 5 — Investigate

Now ask:

```text
Who owns the source IP?
Was this expected?
Was root login allowed?
What happened after successful login?
```

### Step 6 — Determine Severity

If unauthorized:

```text
Potential Account Compromise
```

### Step 7 — Response

Depending on organizational procedure:

```text
Contain
Investigate
Preserve Evidence
Reset Credentials
Review Persistence
Escalate
```

---

# 52. Wazuh vs Other Security Platforms

Common security monitoring platforms/tools:

| Platform           | General Focus                   |
| ------------------ | ------------------------------- |
| Wazuh              | Open-source security monitoring |
| Splunk             | SIEM / Log Analytics            |
| Microsoft Sentinel | Cloud SIEM                      |
| Elastic Security   | SIEM / Security Analytics       |
| QRadar             | SIEM                            |
| CrowdStrike        | EDR/XDR                         |
| Microsoft Defender | Endpoint + Security Platform    |

Wazuh ka major learning advantage:

> **Open-source nature ki wajah se students aur security labs ke liye accessible hai.**

---

# 53. Common Beginner Mistakes

### Mistake 1

Sirf dashboard dekhna.

```text
Alert → "High"
```

Aur bas.

### Better

```text
Alert
 ↓
Evidence
 ↓
Context
 ↓
Investigation
 ↓
Decision
```

---

### Mistake 2

Har alert ko attack samajhna.

```text
Alert ≠ Confirmed Incident
```

Investigation required hai.

---

### Mistake 3

Sirf Wazuh par depend karna.

Real SOC mein Wazuh ke saath:

```text
Networking
Linux
Windows
EDR
Firewall
Threat Intelligence
Packet Analysis
Digital Forensics
```

ki understanding bhi important hai.

---

### Mistake 4

Commands memorize karna without understanding.

Goal:

> Command kya karta hai aur investigation mein kyun use ho raha hai?

---

# 54. Wazuh + Incident Response Mental Model

Wazuh ko apni Incident Response knowledge ke saath connect karo:

```text
                SECURITY EVENT
                       ↓
                  WAZUH DETECTS
                       ↓
                     ALERT
                       ↓
                    TRIAGE
                       ↓
                 INVESTIGATION
                       ↓
              ┌────────┴────────┐
              ↓                 ↓
           Benign            Malicious
              ↓                 ↓
            Close            Contain
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

# 55. Final Mental Model

Wazuh ko ek **security monitoring ecosystem** samjho:

```text
                    WAZUH
                      │
        ┌─────────────┼─────────────┐
        │             │             │
        ▼             ▼             ▼
      Agents       Detection       Storage
        │             │             │
        ▼             ▼             ▼
    Endpoints       Rules         Indexer
        │             │             │
        └─────────────┼─────────────┘
                      ▼
                  Dashboard
                      │
                      ▼
                 SOC Analyst
                      │
                      ▼
                Investigation
                      │
                      ▼
              Incident Response
```

---

# 56. Final Takeaway

> **Wazuh sirf ek dashboard ya log viewer nahi hai. Ye ek security monitoring platform hai jo endpoints aur infrastructure se security data collect karke detection, alerting, investigation, vulnerability visibility, file integrity monitoring aur security assessment mein help karta hai.**

SOC Analyst ke perspective se sabse important workflow:

```text
Wazuh Alert
     ↓
What happened?
     ↓
Who was affected?
     ↓
Which system?
     ↓
When?
     ↓
Where did it come from?
     ↓
Is it malicious?
     ↓
What is the scope?
     ↓
What evidence supports it?
     ↓
What action is required?
     ↓
Document
```

### Core Skills

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
Wazuh
    +
MITRE ATT&CK
    +
Threat Detection
    +
Incident Response
    +
Digital Forensics
```

> **Golden Rule:** Wazuh ko professionally seekhne ka goal ye nahi hona chahiye ke tum sirf alerts dekh sako. Goal ye hona chahiye ke tum **alert ko evidence mein convert karo, evidence ko investigation mein use karo, aur investigation se accurate security decision le sako.**
