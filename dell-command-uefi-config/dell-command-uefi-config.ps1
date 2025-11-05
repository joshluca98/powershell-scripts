$sourcePath = ".\DellBIOSProvider" 
$modulePath = "$env:ProgramFiles\WindowsPowerShell\Modules\DellBIOSProvider"
if (!(Test-Path $modulePath)) {
	New-Item -Type Container -Force -path $modulePath
}

Copy-Item -Path "$sourcePath\*" -Destination $modulePath -Recurse -Force
Import-Module "DellBIOSProvider"

$secureBootStatus = (Get-Item DellSMBIOS:\SecureBoot\SecureBoot).CurrentValue
if ($secureBootStatus -eq "Disabled") {
    Set-Item -Path DellSmbios:\SecureBoot\SecureBoot -Value "Enabled"
}

$uefiNetworkStackStatus = (Get-Item DellSMBIOS:\SystemConfiguration\UefiNwStack).CurrentValue
if ($uefiNetworkStackStatus -eq "Enabled") {
	Set-Item DellSMBIOS:\SystemConfiguration\UefiNwStack -Value "Disabled" 
}

$biosAssetTag = $null
$biosAssetTag = (Get-Item DellSMBIOS:\SystemInformation\Asset).CurrentValue
if (!$biosAssetTag){
	Clear-Host
	Write-Host "BIOS asset tag NOT detected, manual device name change IS required..`n"
	$manualName = Read-Host -Prompt "Enter the new computer name (Ex. MY-PC)"
	Set-Item DellSMBIOS:\SystemInformation\Asset -Value $manualName
	Rename-Computer -NewName $manualName
}
else {
	Write-Host "BIOS asset tag detected, auto naming device..`n"
	Rename-Computer -NewName $biosAssetTag
}