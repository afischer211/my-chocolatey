$ErrorActionPreference = 'Stop'
$packageName    = 'duplicati'
$version        = '2.4.1.104-canary'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = ''
$checksum       = ''
$url64          = 'https://github.com/duplicati/duplicati/releases/download/v2.4.1.104_canary_2026-11-28/duplicati-2.4.1.104_canary_2026-11-28-win-x64-gui.msi'
$checksum64     = 'BF028317E1EDAF952D52C89A1B419ECBEE4134BB4E09E49C29E961DF4CF00C26'

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

