function Get-FirefoxUsersList {
    $firefoxUsers = @()
    Get-ChildItem -Path 'C:\Users' -Directory | ForEach-Object {
        $firefoxPath = Join-Path $_.FullName 'AppData\Local\Mozilla Firefox\uninstall\'
        if (Test-Path $firefoxPath) {
            $firefoxUsers += $_.Name
        }
    }
    return $firefoxUsers
}
$firefoxUserList = Get-FirefoxUsersList

$firefoxPath64 = "$env:ProgramFiles\Mozilla Firefox\uninstall\helper.exe"
$firefoxPath32 = "${env:ProgramFiles(x86)}\Mozilla Firefox\uninstall\helper.exe"

# this will uninstall firefox from each user's local install folder
foreach ($username in $firefoxUserList) {
    $uninstallerPath = "C:\Users\$username\AppData\Local\Mozilla Firefox\uninstall\helper.exe"
    if (Test-Path $uninstallerPath) {
		Write-Output "Uninstall started for: $username"
        Start-Process -FilePath $uninstallerPath -ArgumentList "/S" -Wait -NoNewWindow
		Remove-Item -Path "C:\Users\$username\AppData\Local\Mozilla" -Recurse -Force
    }
    
}
# this will uninstall 64-bit version of firefox from the program files directory
if (Test-Path $firefoxPath64) {
    Start-Process -FilePath $firefoxPath64 -ArgumentList "/S" -Wait -NoNewWindow
}
# this will uninstall 32-bit version of firefox from the program files x86 directory
if (Test-Path $firefoxPath32) {
    Start-Process -FilePath $firefoxPath32 -ArgumentList "/S" -Wait -NoNewWindow
}

# Launch this script as follows from an elevated command line:
# powershell.exe -ExecutionPolicy Bypass -WindowStyle Hidden -File ".\firefox-uninstall.ps1"
