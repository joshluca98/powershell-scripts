#Clear-Host

$allXML = ".\xml\o365+proj+visio.xml"; $o365projXML = ".\xml\o365+proj.xml.xml"; $o365visioXML = ".\xml\o365+visio.xml"; $o365XML = ".\xml\o365.xml"

Function Get-MC2RBitness{
[cmdletbinding()]
	$Configuration = get-itemproperty HKLM:\SOFTWARE\Microsoft\Office\ClickToRun\Configuration -ErrorAction SilentlyContinue
    If(!($Configuration)){
		return 0
    }
Return $Configuration.Platform
}
Function Get-MC2RProducts{
[cmdletbinding()]
	$Configuration = get-itemproperty HKLM:\SOFTWARE\Microsoft\Office\ClickToRun\Configuration -ErrorAction SilentlyContinue
    If(!($Configuration)){
		return 0
    }
Return $Configuration.ProductReleaseIds -split ','
}

Function CheckStatus {
    Write-Host "--Current Status--"
    Write-Host "Bitness:"
    Get-MC2RBitness
    Write-Host "Product(s):"
    Get-MC2RProducts
}

Function LaunchSpecificXML{
    $MC2RBitness = Get-MC2RBitness
    $MC2RProducts = Get-MC2RProducts
	if ($MC2RBitness -eq "x86") {
        #Write-Host "`nx86 products detected..launching ODT with proper XML..`n"		
        if ($MC2RProducts -contains "O365ProPlusRetail" -and $MC2RProducts -contains "ProjectProRetail" -and $MC2RProducts -contains "VisioProRetail") {
            #Write-Host $allXML
			Start-Process -FilePath ".\setup.exe" -ArgumentList "/configure $allXML" -Wait -NoNewWindow
        }
        elseif ($MC2RProducts -contains "O365ProPlusRetail" -and $MC2RProducts -contains "ProjectProRetail") {
            #Write-Host $o365projXML
			Start-Process -FilePath ".\setup.exe" -ArgumentList "/configure $o365projXML" -Wait -NoNewWindow
        }
        elseif ($MC2RProducts -contains "O365ProPlusRetail" -and $MC2RProducts -contains "VisioProRetail") {
            #Write-Host $o365visioXML
			Start-Process -FilePath ".\setup.exe" -ArgumentList "/configure $o365visioXML" -Wait -NoNewWindow
        }
        elseif ($MC2RProducts -contains "O365ProPlusRetail") {
            #Write-Host $o365XML
			Start-Process -FilePath ".\setup.exe" -ArgumentList "/configure $o365XML" -Wait -NoNewWindow
        }
        else {
            #Write-Host "`nNo matching products detected, aborting.."
			return 0
        }
    }
    elseif ($MC2RBitness -eq "x64") {
        #Write-Host "`nx64 products detected..`n"
        return 0
    }
    else {
        #Write-Host "`nPlatform detection error. No XML will run.."
		return 0
    }
    return 1
}


CheckStatus
if(!(LaunchSpecificXML)){
    Write-Host "Aborting, no work to do.."
}
else {
    Write-Host "System has been updated.."
    CheckStatus
}

<#
Read-Host -Prompt "`nAll done. Press ENTER to exit.."
#>