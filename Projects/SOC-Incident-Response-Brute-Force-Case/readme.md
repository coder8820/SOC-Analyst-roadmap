# 🛡️ SOC Incident Response Case Study  
## Brute Force Attack Detection & Investigation

---

# 📌 Project Overview

This project simulates a real-world Security Operations Center (SOC) investigation involving a suspected brute-force attack on a Windows system.

The objective of this case study is to demonstrate:

- Log analysis skills
- Alert triage process
- Event correlation
- Incident documentation
- Blue Team investigation methodology
- Reporting & remediation recommendations

This project follows a realistic SOC workflow:

> Alert → Triage → Investigation → Analysis → Containment → Reporting

---

# 🚨 Scenario

The SOC received an alert from monitoring systems indicating multiple failed login attempts on a Windows server.

The objective was to determine:

- Was this normal user behavior?
- Was this a brute-force attack?
- Did the attacker successfully log in?
- What was the impact?
- What actions should be taken?

---

# 🧰 Environment

- Windows 10 Lab Machine
- Event Viewer Logs
- Security Log Events
- Manual Log Extraction (.evtx)
- Offline Log Analysis

---

# 🔍 Log Analysis Focus

### Key Windows Event IDs Investigated

| Event ID | Description |
|----------|------------|
| 4625 | Failed Logon Attempt |
| 4624 | Successful Logon |
| 4672 | Special Privileges Assigned |
| 4634 | Logoff Event |

---

# 🧠 Investigation Process

## 1️⃣ Alert Validation

- Observed spike in Event ID 4625
- Identified repeated login failures
- Noted common Source IP Address

---

## 2️⃣ Pattern Identification

- 35+ failed attempts within 3 minutes
- Same username targeted
- Same source IP address
- Logon Type 10 (Remote Interactive – RDP)

Indicators strongly suggested brute-force activity.

---

## 3️⃣ Correlation Analysis

Correlated:
- Failed logins (4625)
- Followed by successful login (4624)
- Checked privilege escalation (4672)

Result:
- Successful login detected after multiple failures
- Elevated privileges assigned

This confirmed account compromise.

---

## 📊 Timeline Reconstruction

| Time | Event |
|------|------|
| 10:14:22 | Multiple 4625 failures begin |
| 10:16:48 | 4624 successful login |
| 10:16:49 | 4672 admin privileges assigned |

---

# 🎯 Root Cause

Brute-force attack via exposed RDP service.

Weak password policy enabled compromise.

---

# 🛑 Impact Assessment

- Unauthorized remote access gained
- Privileged account accessed
- Potential data exposure risk

---

# 🔐 Containment Actions

- Disabled compromised account
- Reset password
- Blocked malicious IP
- Enabled account lockout policy
- Enforced strong password policy
- Recommended MFA for RDP

---

# 📘 MITRE ATT&CK Mapping

| Tactic | Technique |
|--------|----------|
| Credential Access | Brute Force (T1110) |
| Initial Access | Valid Accounts (T1078) |

---

# 📄 Deliverables

- Incident Summary
- Timeline
- Root Cause Analysis
- Impact Assessment
- Remediation Plan

---

# 🎯 Skills Demonstrated

✔ Windows Event Log Analysis  
✔ Incident Response Workflow  
✔ Threat Detection  
✔ Event Correlation  
✔ Documentation & Reporting  
✔ Blue Team Defensive Thinking  

---

# 🚀 Future Improvements

- Automate log parsing using Python
- Integrate with SIEM (Splunk / ELK)
- Create detection rule for brute-force threshold
- Implement automated alert generation

---

# 👨‍💻 Author

Kumail Abbas  
BS Computer Science – Cybersecurity Focus  
Blue Team / SOC Enthusiast