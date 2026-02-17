# 🚨 Use Case 2: Suspicious PowerShell Execution

## 📌 Description
Detect encoded or suspicious PowerShell commands executed on endpoints.

## 📊 Log Source
- Sysmon Logs (Event ID 1)
- Windows Event Logs (Event ID 4688)

## 🔍 Detection Logic
Look for:
- powershell.exe with -enc
- Base64 encoded commands

Example Query:
index=sysmon EventCode=1
CommandLine="*powershell* -enc*"

## 🎯 MITRE ATT&CK Mapping
- T1059.001 – PowerShell

## 🛠 Response Actions
1. Identify affected machine.
2. Decode Base64 command.
3. Check if payload is malicious.
4. Isolate endpoint if needed.
5. Perform malware scan.
