# 🚨 Use Case 1: Brute Force Attack Detection

## 📌 Description
Detect multiple failed login attempts from a single IP address targeting a user account within a short time period.

## 📊 Log Source
- Windows Security Logs (Event ID 4625)
- Firewall Logs
- VPN Logs

## 🔍 Detection Logic
IF:
- More than 5 failed login attempts
- From same source IP
- Within 5 minutes

THEN:
Trigger Brute Force Alert

Example Splunk Query:
index=windows EventCode=4625
| stats count by src_ip, user
| where count > 5

## 🎯 MITRE ATT&CK Mapping
- T1110 – Brute Force

## 🛠 Response Actions
1. Verify source IP reputation.
2. Check if account is locked.
3. Contact user for confirmation.
4. Block IP if malicious.
5. Escalate if attack continues.
