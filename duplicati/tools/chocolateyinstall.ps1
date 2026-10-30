$ErrorActionPreference = 'Stop'
$packageName    = 'duplicati'
$version        = '2.4.1.0'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.4.1.0_stable_2026-10-29/duplicati-2.4.1.0_stable_2026-10-29-win-x86-gui.msi' 
$checksum       = 'F1161A039AC11A8ACFC563192A035115C0B3DA71AAD24E566AB00F33BEAF5B18'
$url64          = 'https://github.com/duplicati/duplicati/releases/download/v2.4.1.0_stable_2026-10-29/duplicati-2.4.1.0_stable_2026-10-29-win-x64-gui.msi' 
$checksum64     = 'B5574D08BAF9782F43B961741814A111C5DC3A19F4EBB3F49FB1556D0BAE8A0D'

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
  
