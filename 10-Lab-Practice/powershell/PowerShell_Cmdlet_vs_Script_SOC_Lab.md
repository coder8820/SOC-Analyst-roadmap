# 🛡️ PowerShell Cmdlet vs Script Lab (SOC Analyst Scenario)

## 🎯 Lab Objective

Is lab ka maqsad hai: - Cmdlet aur Script ka difference practically
samajhna - Windows Event Logs analyze karna - Suspicious activity detect
karna (SOC perspective) - Basic monitoring script banana

------------------------------------------------------------------------

# 🏢 Scenario

Aap ek SOC Analyst ho.

Security team ko alert mila hai ke: - Multiple failed login attempts ho
rahe hain - Unknown processes run ho rahe hain - System par suspicious
PowerShell activity ho sakti hai

Aapko PowerShell use karke investigation karni hai.

------------------------------------------------------------------------

# 🔹 Part 1: Cmdlet Practice

## Step 1: Running Processes Check karo

``` powershell
Get-Process
```

📌 Explanation: Ye cmdlet system ke sare running processes show karta
hai. SOC analyst yahan suspicious process names check karega.

------------------------------------------------------------------------

## Step 2: Failed Login Attempts Check karo

``` powershell
Get-EventLog -LogName Security -InstanceId 4625
```

📌 Explanation: 4625 = Failed Login Attempt\
Agar multiple entries ek hi IP se aa rahi hain, to brute force attack ho
sakta hai.

------------------------------------------------------------------------

## Step 3: Listening Ports Check karo

``` powershell
netstat -ano
```

📌 Explanation: Ye command batata hai: - Kaun se ports open hain - Kaun
si process kis port se linked hai

Agar unknown port open ho (jaise 4444), to reverse shell ho sakta hai.

------------------------------------------------------------------------

# 🔹 Part 2: Script Creation

Ab hum ek monitoring script banayenge.

## Step 1: Notepad open karo

    notepad monitor.ps1

## Step 2: Ye code paste karo:

``` powershell
Write-Host "===== SOC Quick Investigation Script ====="

Write-Host "`nCurrent Date & Time:"
Get-Date

Write-Host "`nFailed Login Attempts (4625):"
Get-EventLog -LogName Security -InstanceId 4625 -Newest 5

Write-Host "`nTop 5 Processes by CPU Usage:"
Get-Process | Sort-Object CPU -Descending | Select-Object -First 5

Write-Host "`nListening Ports:"
netstat -ano
```

Save karo.

------------------------------------------------------------------------

## Step 3: Script Run karo

``` powershell
.\monitor.ps1
```

📌 Explanation: Ye script ek mini SOC investigation tool hai jo: - Date
show karta hai - Recent failed logins show karta hai - High CPU
processes show karta hai - Listening ports show karta hai

------------------------------------------------------------------------

# 🔥 Cmdlet vs Script (Lab Understanding)

  Cmdlet           Script
  ---------------- -------------------------
  Single command   Multiple commands
  Built-in         Custom file (.ps1)
  Quick check      Automated investigation

------------------------------------------------------------------------

# 🔴 Advanced Task (Optional)

1.  Failed logins sirf last 24 hours ke show karo.
2.  Output ko file me save karo:

``` powershell
.\monitor.ps1 > report.txt
```

3.  Suspicious PowerShell activity check karo:

``` powershell
Get-WinEvent -LogName "Microsoft-Windows-PowerShell/Operational"
```

------------------------------------------------------------------------

# 🧠 Learning Outcome

Is lab ke baad aap:

✅ Cmdlet aur Script ka practical difference samajh jaoge\
✅ Event ID 4625 ka use kar sakte ho\
✅ Basic SOC investigation script bana sakte ho\
✅ Suspicious activity detect kar sakte ho

------------------------------------------------------------------------

# 🚨 SOC Tip

Attackers PowerShell ko: - Base64 encode karte hain - Hidden window me
chalate hain - Logs delete karne ki koshish karte hain

Isliye monitor karo: - Event ID 4688 (Process Creation) - Event ID 4104
(PowerShell Script Block Logging)

------------------------------------------------------------------------

# 🏁 End of Lab
