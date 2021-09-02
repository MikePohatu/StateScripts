
Param (
    [string]$OutputPath = "C:\Temp\State", 
    [bool]$RemoveExisting = $true
)
#[Parameter(Mandatory=$true)]

#set a version so we can check against the last output if output
#has changed
$OutputFormatVersion = "1.0"
$OutDir = "$($OutputPath)\$($OutputFormatVersion)"

#cleanup existing ouptut
if (Test-Path -Path "$OutDir") {
    Remove-Item -Path "$OutDir" -Recurse -Force
}

New-Item -Path "$OutDir" -ItemType Directory


gpresult /f /h "$($OutDir)\GpResult.html"
gpresult /f /x "$($OutDir)\GpResult.xml"

Get-HotFix | Out-File -FilePath "$($OutDir)\Hotfixes.txt"
#Get-WindowsFeature | Out-File -FilePath "$($OutDir)\Features.txt"
Get-WindowsEdition -Online | Out-File -FilePath "$($OutDir)\Edition.txt"
Get-WindowsPackage -Online | Select-Object -Property PackageName, PackageState, ReleaseType | Format-List | Out-File -FilePath "$($OutDir)\Packages.txt"