# count failed login attempts(EventId 4625)
$failed = Get-WinEvent -FilterHashtable @{LogName='Security'; Id=4624
Write-Output 'Total failed Login: $(failed.Count)'