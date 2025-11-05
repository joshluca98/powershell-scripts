$regFiles = Get-ChildItem -Path $PSScriptRoot -Filter *.reg

foreach ($regFile in $regFiles) {
    Start-Process -FilePath "reg.exe" -ArgumentList "import `"$($regFile.FullName)`"" -Wait -NoNewWindow
}