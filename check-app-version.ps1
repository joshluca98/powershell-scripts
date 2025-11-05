function Get-ApplicationVersion {
    param (
        [string]$ApplicationName
    )
    $UninstallPaths = @(
        "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall",
        "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall",
        "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
    )
    foreach ($Path in $UninstallPaths) {
        if (Test-Path $Path) {
            Get-ChildItem -Path $Path | ForEach-Object {
                $Properties = Get-ItemProperty -Path $_.PSPath
                if ($Properties.DisplayName -like "*$ApplicationName*") {
                    [PSCustomObject]@{
                        DisplayName = $Properties.DisplayName
                        DisplayVersion = $Properties.DisplayVersion
                        RegistryPath = $_.PSPath
                    }
                }
            }
        }
    }
}
Get-ApplicationVersion -ApplicationName "Universal"