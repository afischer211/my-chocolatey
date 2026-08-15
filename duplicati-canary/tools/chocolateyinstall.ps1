$ErrorActionPreference = 'Stop'
$packageName    = 'duplicati'
$version        = '2.3.0.109-canary'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.3.0.109_canary_2026-08-14/duplicati-2.3.0.109_canary_2026-08-14-win-x86-gui.msi'
$checksum       = 'BC1280B60B9BD5578D7C49A22C64BEDE605CA5A83E5AAAC097A3240DB0784B64'
$url64          = 'https://github.com/duplicati/duplicati/releases/download/v2.3.0.109_canary_2026-08-14/duplicati-2.3.0.109_canary_2026-08-14-win-x64-gui.msi'
$checksum64     = 'A1C303B6BD9DEC002F7CD188EE86EEEF0391267A443E388866B3A11D997D6931'

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

