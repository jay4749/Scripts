########################################################################################
# Version of Software Script
# Author:	Matt Soteros
# Version:	v1.1
########################################################################################
##VARIABLES#############################################################################
Set-Location c:\
# Set base path to prefix all installation paths.
$sPath = "C:\Admin\Software"
# Get Computer Name  this will be used for Licensing infomation
$sComputerName = $env:COMPUTERNAME
# Set The Log Location
$sFile = "C:\Admin\SoftwareInstallation.TXT"
# Set base bath for Registry uninstallation Paths
$rPathX64 = "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall"
$rPathX86 = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
$sComputerModel = (Get-WmiObject -Query "SELECT * FROM Win32_ComputerSystem").Model
$sComputerMake = (Get-WmiObject -Query "SELECT * FROM Win32_ComputerSystem").Manufacturer
$sChassisType = (Get-WmiObject -Query "SELECT * FROM Win32_SystemEnclosure").ChassisTypes
Write-Host $sComputerModel $sComputerMake $sChassisType