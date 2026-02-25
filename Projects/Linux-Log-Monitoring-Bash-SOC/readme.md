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
