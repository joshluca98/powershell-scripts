$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts\UserList"

New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts" -ItemType Directory -Force
New-Item -Path $registryPath -ItemType Directory -Force

New-ItemProperty -Path $registryPath -Name "SampleUser" -PropertyType DWord -Value 0 -Force