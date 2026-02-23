# ===============================
# loginfaild.ps1
# Count and display failed login attempts (EventId 4625)
# ===============================

# Ensure script can handle spaces in paths
# Filter failed login events
$failed = Get-WinEvent -FilterHashtable @{LogName='Security'; Id=4625} -ErrorAction SilentlyContinue

# Display total failed login count
Write-Output "Total failed Login: $($failed.Count)"
Write-Output "-----------------------------"

# Display details of each failed login
foreach ($event in $failed) {
    $time = $event.TimeCreated
    # Account name is usually in the 6th property
    $user = $event.Properties[5].Value  
    $ip = $event.Properties[18].Value  # Source IP for failed login (if available)
    
    Write-Output "Failed login: User = $user | Time = $time | IP = $ip"
}

Write-Output "==============================="