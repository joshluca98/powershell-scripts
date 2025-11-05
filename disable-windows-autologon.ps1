$registryPath = 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon'
Remove-ItemProperty -Path $registryPath -Name 'AutoAdminLogon' -ErrorAction SilentlyContinue
Remove-ItemProperty -Path $registryPath -Name 'DefaultUsername' -ErrorAction SilentlyContinue
Remove-ItemProperty -Path $registryPath -Name 'DefaultPassword' -ErrorAction SilentlyContinue