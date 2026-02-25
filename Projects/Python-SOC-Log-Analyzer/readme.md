# 🐍 Python SOC Log Analyzer  
## Automated Brute-Force Detection Tool

---

# 📌 Project Overview

This project is a Python-based log analysis tool designed to simulate basic SIEM detection logic for identifying brute-force login attempts.

The goal is to demonstrate:

- Log parsing
- Threat detection logic
- Automation scripting
- Defensive security mindset
- SOC alert simulation

---

# 🎯 Objectives

The tool:

- Reads log files
- Extracts failed login attempts
- Counts failed attempts per IP
- Detects threshold violations
- Generates alert report
- Identifies suspicious IP addresses

---

# 🧰 Technologies Used

- Python 3
- Regex
- File Handling
- Dictionary Data Structures
- Basic Threat Detection Logic

---

# 📂 Sample Log Format

Example log entries:
Failed login from 192.168.1.10
Failed login from 192.168.1.10
Failed login from 192.168.1.10
Successful login from 192.168.1.10


---

# 🔍 Detection Logic

1. Parse each line
2. Identify failed login entries
3. Count failed attempts per IP
4. If failures > threshold (e.g., 5):
   - Mark IP as suspicious
   - Generate alert

---

# ⚙️ Features

✔ Brute-force detection  
✔ Threshold-based alerting  
✔ IP aggregation  
✔ Report generation  
✔ Clean structured output  

---

# 📊 Sample Output
⚠ ALERT: Suspicious Activity Detected

IP Address: 192.168.1.10
Failed Attempts: 8
Status: Potential Brute Force Attack


---

# 📘 SOC Relevance

This project simulates how SIEM systems:

- Aggregate logs
- Detect patterns
- Trigger alerts
- Support SOC analysts in investigation

---

# 🔐 Defensive Value

Helps detect:

- Password guessing attacks
- Account compromise attempts
- Unauthorized access attempts

---

# 🚀 Future Enhancements

- Add CSV export
- Add JSON output
- Integrate with ELK stack
- Email alert automation
- Real-time monitoring mode
- Add MITRE ATT&CK mapping

---

# 🎯 Skills Demonstrated

✔ Python scripting  
✔ Automation  
✔ Log analysis  
✔ Security detection logic  
✔ Blue Team mindset  

---

# 👨‍💻 Author

Kumail Abbas  
Aspiring SOC Analyst | Python Automation | Blue Team