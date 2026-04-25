$ErrorActionPreference = 'Stop'
$packageName    = 'duplicati'
$version        = '2.3.0.1'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.3.0.1_stable_2026-04-24/duplicati-2.3.0.1_stable_2026-04-24-win-x86-gui.msi' 
$checksum       = '63A320B41A0514697EB80AD12DA0B0A3DB644E0ADBFC1106A154A7670A5125C1'
$url64          = 'https://github.com/duplicati/duplicati/releases/download/v2.3.0.1_stable_2026-04-24/duplicati-2.3.0.1_stable_2026-04-24-win-x64-gui.msi' 
$checksum64     = '17FF7B6C9110A81DE6470CDB64BF22DDCEBE1CA903C9022A60E5DEEBA4F541E2'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'MSI'
  url            = $url
  url64bit       = $url64
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/quiet /qn /norestart'
  softwareName   = 'Duplicati 2*'
  checksum       = $checksum 
  checksumType   = 'sha256' 
  checksum64     = $checksum64
  checksumType64 = 'sha256'
}

Install-ChocolateyPackage @packageArgs  
  
