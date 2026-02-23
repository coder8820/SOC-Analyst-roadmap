# PowerShell SOC Detection Lab (Advanced Scenario)

## Lab Title:

Detecting Suspicious PowerShell Activity (Blue Team Focus)

------------------------------------------------------------------------

## Lab Objective

Is lab ka maqsad hai:

-   PowerShell based attack detect karna
-   Event ID 4688 (Process Creation) analyze karna
-   Event ID 4104 (Script Block Logging) check karna
-   Encoded PowerShell commands identify karna
-   Investigation report banana

------------------------------------------------------------------------

# Scenario

Aap SOC Analyst ho.

SIEM ne alert generate kiya:

"Suspicious PowerShell execution detected on endpoint WIN-01"

Security team ko shak hai ke attacker ne:

-   Encoded PowerShell command run ki
-   Hidden window use ki
-   Credentials dump karne ki koshish ki

Aapko investigation karni hai.

------------------------------------------------------------------------

# Part 1 -- Process Creation Investigation

## Step 1: Event ID 4688 Check karo

``` powershell
Get-WinEvent -FilterHashtable @{LogName='Security'; Id=4688} | Select-Object -First 10
```

4688 = New process created

Check karo: - Process name powershell.exe? - Command line suspicious? -
"-enc" parameter use hua?

------------------------------------------------------------------------

## Step 2: Encoded Commands Detect karo

``` powershell
Get-WinEvent -FilterHashtable @{LogName='Security'; Id=4688} | 
Where-Object {$_.Message -like "*powershell*"} | 
Select-Object -First 5
```

Red Flags: - powershell -enc - powershell -nop -w hidden - powershell
-executionpolicy bypass

------------------------------------------------------------------------

# Part 2 -- Script Block Logging (4104)

## Step 3: PowerShell Operational Log Check karo

``` powershell
Get-WinEvent -LogName "Microsoft-Windows-PowerShell/Operational" | 
Where-Object {$_.Id -eq 4104} | 
Select-Object -First 5
```

4104 = Script Block Logging

Yahan executed script ka content milta hai.

Check karo: - Base64 decoding? - Invoke-Expression? - Suspicious
download commands?

------------------------------------------------------------------------

# Part 3 -- Decode Suspicious Base64 Command

Example encoded string:

``` powershell
SQBFAFgAIAAoAE4AZQB3AC0ATwBiAGoAZQBjAHQAIABXAGUAYgBDAGwAaQBlAG4AdAApAA==
```

Decode:

``` powershell
[System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String("ENCODED_STRING"))
```

------------------------------------------------------------------------

# Part 4 -- Detection Script

Create file: detect.ps1

``` powershell
Write-Host "=== Suspicious PowerShell Detection Script ==="

Write-Host "`nRecent PowerShell Processes (4688):"
Get-WinEvent -FilterHashtable @{LogName='Security'; Id=4688} |
Where-Object {$_.Message -like "*powershell*"} |
Select-Object -First 5

Write-Host "`nRecent Script Block Logs (4104):"
Get-WinEvent -LogName "Microsoft-Windows-PowerShell/Operational" |
Where-Object {$_.Id -eq 4104} |
Select-Object -First 5
```

Run:

``` powershell
.\detect.ps1
```

------------------------------------------------------------------------

# Expected Learning Outcome

Is lab ke baad aap:

-   Encoded PowerShell detect kar sakte ho
-   4688 aur 4104 ka difference samajh jaoge
-   Script Block Logging ka importance samajh jaoge
-   Basic detection script bana sakte ho

------------------------------------------------------------------------

# SOC Analyst Report Template

## Incident Summary:

Suspicious PowerShell execution detected.

## Indicators Found:

-   Encoded command usage
-   Hidden execution flags
-   Script block evidence

## Risk Level:

High

## Recommended Action:

-   Isolate endpoint
-   Reset credentials
-   Full malware scan
-   Review lateral movement logs

------------------------------------------------------------------------

# End of Lab
