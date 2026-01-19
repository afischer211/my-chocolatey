$ErrorActionPreference = 'Stop'
$packageName    = 'duplicati'
$version        = '2.2.0.3'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.2.0.3_stable_2026-01-06/duplicati-2.2.0.3_stable_2026-01-06-win-x86-gui.msi' 
$checksum       = 'D58FEA6FA7FA3918E7421CB98EAE2BDCE5C99167A6F94CA90EFC2C9A4FE0D43A'
$url64          = 'https://github.com/duplicati/duplicati/releases/download/v2.2.0.3_stable_2026-01-06/duplicati-2.2.0.3_stable_2026-01-06-win-x64-gui.msi' 
$checksum64     = '3B7B7A9B930D74D3E735E67CEA4032911B2D2DC10664F85862411D45390936AD'

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
  
