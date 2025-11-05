$chrome = Get-Process -Name chrome -ErrorAction SilentlyContinue
if ($chrome) {
    $chrome | Stop-Process -Force
}

$edge = Get-Process -Name msedge -ErrorAction SilentlyContinue
if ($edge) {
    $edge | Stop-Process -Force
}

$regFile = ".\browser-config.reg"
Start-Process -FilePath "reg.exe" -ArgumentList "import `"$($regFile)`"" -Wait -NoNewWindow

$chromeUserDataPath = "C:\Users\ALL\AppData\Local\Google\Chrome\User Data"
if (Test-Path $chromeUserDataPath) {
	Remove-Item -Path $chromeUserDataPath -Recurse -Force
}

$edgeUserDataPath = "C:\Users\ALL\AppData\Local\Microsoft\Edge\User Data"
if (Test-Path $edgeUserDataPath) {
	Remove-Item -Path $edgeUserDataPath -Recurse -Force
}

$chromeInstallPath = "C:\Program Files\Google\Chrome\Application"
$chromePrefFile = ".\chrome\initial_preferences"
Copy-Item -Path "$chromePrefFile" -Destination $chromeInstallPath -Force

$edgeInstallPath = "C:\Program Files (x86)\Microsoft\Edge\Application"
$edgePrefFile = ".\edge\initial_preferences"
Copy-Item -Path "$edgePrefFile" -Destination $edgeInstallPath -Force