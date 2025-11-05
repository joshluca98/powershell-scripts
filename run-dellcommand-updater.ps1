# run dell command cli
$dcuPath = "C:\Program Files\Dell\CommandUpdate\dcu-cli.exe"

& "$dcuPath" /configure -defaultSourceLocation=enable -scheduleManual -userConsent=disable
& "$dcuPath" /applyUpdates -reboot=enable -forceUpdate=enable