$folderPath = "C:\GENCHAIN"
if (-not (Test-Path -Path $folderPath)) {
    New-Item -Path $folderPath -ItemType Directory
}

$deviceName = $env:COMPUTERNAME

$filePath = Join-Path -Path $folderPath -ChildPath "$deviceName - BitLocker Recovery Password.txt"

manage-bde -on C: -recoverypassword > $filePath -skiphardwaretest