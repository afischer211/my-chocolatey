$ErrorActionPreference = 'Stop'
$packageName    = 'duplicati'
$version        = '2.2.0.3'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.2.0.3_stable_2026-01-06/duplicati-2.2.0.3_stable_2026-01-06-win-x86-gui.zip' 
$checksum       = 'EDBCDB9BC13D7FE915AA61670EE3D67AFD468DD4675741D53828ECD7A51AAD6A'
$url64          = 'https://github.com/duplicati/duplicati/releases/download/v2.2.0.3_stable_2026-01-06/duplicati-2.2.0.3_stable_2026-01-06-win-x64-gui.zip' 
$checksum64     = '162C63F111C7AC4FF57DED6A2D67FBE7B127BB173FBF589013A01A7C13A9587F'

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
  
