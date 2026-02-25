# 🐧 Linux Log Monitoring – SOC Simulation  
## SSH Brute Force Detection using Bash

---

# 📌 Project Overview

This project demonstrates real-world Linux security monitoring using Bash scripting to detect suspicious SSH login attempts.

It simulates how a SOC analyst monitors authentication logs on Linux servers.

---

# 🎯 Objective

To monitor:

- /var/log/auth.log
- Failed SSH login attempts
- Sudo abuse
- Privilege escalation attempts

---

# 🧰 Tools & Environment

- Ubuntu Linux
- Bash Scripting
- grep
- awk
- sort
- uniq
- auth.log

---

# 🔍 Detection Focus

### Indicators of Compromise (IOCs)

- Multiple failed SSH login attempts
- Repeated attempts from same IP
- Root login attempts
- Suspicious sudo activity

---

# ⚙️ Script Capabilities

✔ Parse auth.log  
✔ Count failed SSH attempts  
✔ Identify suspicious IP addresses  
✔ Generate summary report  
✔ Display top attacking IPs  

---

# 📊 Example Detection Output
Top Suspicious IP Addresses:

192.168.1.50 - 12 failed attempts
192.168.1.77 - 9 failed attempts

⚠ Potential SSH Brute Force Detected


---

# 🔐 Blue Team Relevance

This project demonstrates:

- Linux log analysis
- Real server monitoring
- Attack detection from authentication logs
- Defensive security operations

---

# 🧠 SOC Workflow Simulation

1. Detect anomaly
2. Validate repeated failures
3. Identify attacker IP
4. Recommend firewall block
5. Suggest SSH hardening

---

# 🛡️ Recommended Hardening

- Disable root SSH login
- Change default SSH port
- Enable Fail2Ban
- Implement key-based authentication
- Configure firewall rules
- Enable account lockout

---

# 📘 MITRE ATT&CK Mapping

| Tactic | Technique |
|--------|----------|
| Credential Access | Brute Force (T1110) |
| Initial Access | Valid Accounts (T1078) |

---

# 🎯 Skills Demonstrated

✔ Linux administration  
✔ Bash scripting  
✔ Security monitoring  
✔ Log analysis  
✔ Incident detection  
✔ Defensive mindset  

---

# 🚀 Future Enhancements

- Real-time monitoring with tail -f
- Email alert system
- Cron-based monitoring
- Integration with SIEM
- Dockerized monitoring lab

---

# 👨‍💻 Author

Kumail Abbas  
Linux Security | SOC Analyst Track | Blue Team