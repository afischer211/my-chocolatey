$ErrorActionPreference = 'Stop'
$packageName    = 'duplicati'
$version        = '2.3.0.110-canary'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.3.0.110_canary_2026-08-25/duplicati-2.3.0.110_canary_2026-08-25-win-x86-gui.msi'
$checksum       = '9A4B3FCBBC1ECC3EFA5901F9C13AA98ACFA151481A46D6891052B80A2945B96E'
$url64          = 'https://github.com/duplicati/duplicati/releases/download/v2.3.0.110_canary_2026-08-25/duplicati-2.3.0.110_canary_2026-08-25-win-x64-gui.msi'
$checksum64     = '37D9A3FE50353CFF8D4DC335FD3445B1FF6F0108ABD9911F9503DA8B145E1D6D'

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

