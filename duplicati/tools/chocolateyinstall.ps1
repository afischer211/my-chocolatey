$ErrorActionPreference = 'Stop'
$packageName    = 'duplicati'
$version        = '2.3.0.3'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.3.0.3_stable_2026-06-10/duplicati-2.3.0.3_stable_2026-06-10-win-x86-gui.msi' 
$checksum       = '6D404601A0B6CE6333A3C1F9E0D842CA3C6B0CCF241A6D5C620C97FF26121688'
$url64          = 'https://github.com/duplicati/duplicati/releases/download/v2.3.0.3_stable_2026-06-10/duplicati-2.3.0.3_stable_2026-06-10-win-x64-gui.msi' 
$checksum64     = '0BE12F9056E8C5FDD30E2BF71EFEB5EB74A0BAC03005B4AD7AFA28BB51CA534B'

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
  
