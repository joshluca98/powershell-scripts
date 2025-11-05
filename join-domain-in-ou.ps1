$User = "sample.domain\sampleUser"
$PWord = ConvertTo-SecureString -String "samplePassword" -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $PWord

Add-Computer -DomainName "sample.domain" -OUPath "OU=SampleOU Devices,OU=Devces,OU=Computers,DC=sample,DC=domain" -Credential $Credential -Force