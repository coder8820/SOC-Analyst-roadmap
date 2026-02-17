# 🚨 Use Case 3: Impossible Travel Login

## 📌 Description
Detect login attempts from geographically impossible locations within a short timeframe.

## 📊 Log Source
- VPN Logs
- Cloud Authentication Logs (Azure AD, O365)

## 🔍 Detection Logic
IF:
- Same user logs in
- From two different countries
- Within 1 hour

THEN:
Trigger Impossible Travel Alert

## 🎯 MITRE ATT&CK Mapping
- T1078 – Valid Accounts

## 🛠 Response Actions
1. Contact user for verification.
2. Reset user password.
3. Enable MFA if not enabled.
4. Investigate suspicious IP.
