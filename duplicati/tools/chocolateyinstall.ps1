$ErrorActionPreference = 'Stop'
$packageName    = 'duplicati'
$version        = '2.4.0.0'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.4.0.0_stable_2026-09-03/duplicati-2.4.0.0_stable_2026-09-03-win-x86-gui.msi' 
$checksum       = '79136B31D26AAA42BF5E5EA9AF526FE19E7804DFCF5837D9CA045CD02ADB3418'
$url64          = 'https://github.com/duplicati/duplicati/releases/download/v2.4.0.0_stable_2026-09-03/duplicati-2.4.0.0_stable_2026-09-03-win-x64-gui.msi' 
$checksum64     = 'F3DDD94FE4DAD667D918A6B604C708FBF39A6B77FF9E9291FE8DCC69CC2493A7'

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
  
