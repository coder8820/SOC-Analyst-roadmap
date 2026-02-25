# 🛡️ SIEM – Complete Guide for SOC / Blue Team

## Security Information and Event Management

---

# 📌 What is SIEM?

SIEM stands for:

> **Security Information and Event Management**

SIEM is a centralized security platform that collects, stores, analyzes, and correlates logs from multiple systems across an organization to detect cyber threats and security incidents.

For a SOC (Security Operations Center) or Blue Team professional, SIEM is one of the most important tools used for threat detection and incident response.

---

# 🧠 SIEM in Simple Terms

Imagine an organization has:

- 200 Employee Computers  
- 20 Servers  
- Firewalls  
- Routers & Switches  
- Antivirus Solutions  
- Active Directory  
- Cloud Services (AWS/Azure)  

Each system continuously generates log files.

### 🚨 The Problem:
Manually monitoring thousands or millions of logs daily is impossible.

### ✅ The Solution:
SIEM collects all logs into one central platform and automatically analyzes them to detect suspicious activity.

---

# 🔹 The Two Core Components of SIEM

SIEM consists of two major parts:

---

## 1️⃣ SIM – Security Information Management

Responsible for:

- Log collection
- Log storage
- Long-term retention
- Compliance reporting (ISO 27001, PCI-DSS, etc.)

SIM focuses on **data storage and compliance management**.

---

## 2️⃣ SEM – Security Event Management

Responsible for:

- Real-time monitoring
- Event correlation
- Suspicious activity detection
- Alert generation

SEM focuses on **real-time security monitoring and detection**.

---

### 👉 SIM + SEM = SIEM

---

# 🔄 SIEM Workflow (Step-by-Step)

---

## 1️⃣ Log Collection

SIEM collects logs from multiple sources such as:

- Windows Event Logs
- Linux Syslogs
- Firewalls
- IDS/IPS
- Antivirus systems
- Active Directory
- Web Servers
- Database Servers
- Cloud platforms (AWS, Azure)

All logs are forwarded to the SIEM via agents or log collectors.

---

## 2️⃣ Log Normalization

Different systems generate logs in different formats.

Example:

Firewall Log:
src=192.168.1.5 dst=10.0.0.2

---


Windows Log:
Source Address: 192.168.1.5

---


SIEM converts all logs into a standardized format.  
This process is called:

> **Log Normalization**

It ensures consistent analysis across different devices.

---

## 3️⃣ Correlation Engine (Most Critical Component)

This is the intelligence layer of SIEM.

SIEM does not just look at single events — it correlates multiple events together.

### Example Scenario:

- 5 failed login attempts  
- Followed by 1 successful login  
- Then a new admin account is created  

SIEM correlates these events and triggers:

🚨 **Possible Brute Force + Privilege Escalation**

This process is called:

> **Event Correlation**

---

## 4️⃣ Alert Generation

Once suspicious behavior is detected, SIEM generates alerts categorized by severity:

- 🔴 High
- 🟠 Medium
- 🟡 Low

The SOC Analyst then:

- Investigates the alert
- Determines if it is a false positive
- Confirms whether it is a real attack
- Takes appropriate action

---

# 🔎 What Can SIEM Detect?

SIEM can detect:

✔ Brute-force attacks  
✔ Malware infections  
✔ Suspicious IP activity  
✔ Data exfiltration  
✔ Privilege escalation  
✔ Insider threats  
✔ Lateral movement  
✔ Account compromise  
✔ Policy violations  

---

# 🧪 Real Interview Scenario Example

### Scenario:

A user account shows:

- 20 failed login attempts  
- Login from foreign country IP  
- Successful login after failures  
- Password changed immediately  

### SIEM Alert:

> "Suspicious Login Activity Detected"

### SOC Analyst Response:

1. Validate logs (Event ID 4625, 4624)
2. Check IP geolocation
3. Contact user for verification
4. Reset password
5. Terminate active sessions
6. Block malicious IP
7. Enable MFA (if not enabled)
8. Document incident

---

# 🏗️ Basic SIEM Architecture
Log Sources → Log Collector → SIEM Engine → Correlation → Alert → SOC Analyst


Components:

- Log Sources (Endpoints, Servers, Network Devices)
- Log Collector / Forwarder
- SIEM Processing Engine
- Correlation Rules
- Alert Dashboard
- SOC Investigation Workflow

---

# 🔄 SIEM vs SOAR

| SIEM | SOAR |
|------|------|
| Detects threats | Responds automatically |
| Generates alerts | Executes automated actions |
| Used for monitoring | Used for orchestration |

Example:

- SIEM detects brute force
- SOAR automatically blocks IP

---

# 🛠️ Popular SIEM Tools

## Enterprise-Level

- Splunk
- IBM QRadar
- ArcSight
- LogRhythm
- Microsoft Sentinel

## Open-Source

- Wazuh
- ELK Stack (Elasticsearch, Logstash, Kibana)
- Security Onion

---

# 🎯 Benefits of SIEM

✔ Centralized log monitoring  
✔ Faster threat detection  
✔ Compliance support  
✔ Incident investigation support  
✔ Log retention & auditing  
✔ Improved visibility  

---

# ⚠️ SIEM Challenges

❌ Alert fatigue (too many alerts)  
❌ False positives  
❌ High storage cost  
❌ Expensive licensing  
❌ Complex rule tuning  
❌ Requires skilled analysts  

---

# 🧠 Skills Required for SOC Analysts (SIEM-Focused)

If you are applying for a SOC role, you should know:

- Log reading & interpretation
- Event correlation
- Use-case creation
- Query writing (SPL, KQL)
- Incident handling process
- MITRE ATT&CK mapping
- Alert triage
- Basic networking knowledge
- Windows & Linux log analysis

---

# 🛡️ Conclusion

SIEM is the backbone of any modern SOC.

It provides:

- Visibility
- Detection
- Investigation support
- Compliance management

For a Blue Team professional, mastering SIEM is essential for building a successful cybersecurity career.

---

# 👨‍💻 Author

Kumail Abbas  
BS Computer Science  
Aspiring SOC Analyst | Blue Team | Cybersecurity Enthusiast