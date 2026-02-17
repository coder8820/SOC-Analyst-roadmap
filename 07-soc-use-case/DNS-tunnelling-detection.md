# 🚨 Use Case 5: DNS Tunneling Detection

## 📌 Description
Detect abnormal DNS queries that may indicate data exfiltration via DNS tunneling.

## 📊 Log Source
- DNS Logs
- Firewall Logs

## 🔍 Detection Logic
Look for:
- High volume of DNS queries
- Long subdomain strings
- Random characters in domain

## 🎯 MITRE ATT&CK Mapping
- T1071.004 – DNS

## 🛠 Response Actions
1. Investigate suspicious domain.
2. Analyze endpoint traffic.
3. Block malicious domain.
4. Check for data exfiltration.
