# install dependency
winget install Microsoft.DotNet.DesktopRuntime.8 --accept-package-agreements --accept-source-agreements

# install dell command update 5.4.0
$installerPath = Join-Path -Path $PSScriptRoot -ChildPath "Dell-Command-Update-Windows-Universal-Application_9M35M_WIN_5.4.0_A00.EXE"
if (-not (Test-Path "C:\Program Files\Dell\CommandUpdate")) {
	Start-Process -FilePath $installerPath -ArgumentList "/s" -Wait
}

# run dell command cli
$dcuPath = "C:\Program Files\Dell\CommandUpdate\dcu-cli.exe"

& "$dcuPath" /configure -defaultSourceLocation=enable -scheduleManual -userConsent=disable
& "$dcuPath" /applyUpdates -reboot=enable -forceUpdate=enable