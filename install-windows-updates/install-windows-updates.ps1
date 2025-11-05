$pendingReboot = Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\RebootPending"
if ($pendingReboot) {
    Restart-Computer -Force
}

$modulePath = "C:\Program Files\WindowsPowerShell\Modules\PSWindowsUpdate\2.2.1.5"
Expand-Archive -Path ".\pswindowsupdate.2.2.1.5.zip" -DestinationPath $modulePath -Force
Import-Module PSWindowsUpdate -Force

Restart-Service wuauserv -Force

Get-WindowsUpdate -AcceptAll -IgnoreReboot -Verbose
Install-WindowsUpdate -AcceptAll -IgnoreReboot -AutoReboot -Confirm:$false -Verbose