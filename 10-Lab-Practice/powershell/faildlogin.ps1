# ===============================
# loginfaild.ps1
# Count and display failed login attempts (EventId 4625) in the last 24 hours
# Export results to CSV
# ===============================

# Get current date and time
$now = Get-Date
$yesterday = $now.AddDays(-1)

# Filter failed login events in last 24 hours
$failed = Get-WinEvent -FilterHashtable @{LogName='Security'; Id=4625; StartTime=$yesterday} -ErrorAction SilentlyContinue

# Display total failed login count
Write-Output "Total failed login attempts in last 24 hours: $($failed.Count)"
Write-Output "-------------------------------------------"

# Prepare array for CSV export
$results = @()

# Loop through each failed login
foreach ($event in $failed) {
    $time = $event.TimeCreated
    $user = $event.Properties[5].Value
    $ip = $event.Properties[18].Value

    # Display on console
    Write-Output "Failed login: User = $user | Time = $time | IP = $ip"

    # Add to results array
    $results += [PSCustomObject]@{
        Time   = $time
        User   = $user
        IP     = $ip
    }
}

Write-Output "-------------------------------------------"

# Export to CSV (in same folder as script)
$csvPath = Join-Path -Path (Split-Path -Parent $MyInvocation.MyCommand.Path) -ChildPath "FailedLogins_Last24Hours.csv"
$results | Export-Csv -Path $csvPath -NoTypeInformation

Write-Output "Exported failed login details to: $csvPath"
Write-Output "==========================================="