$ErrorActionPreference = 'Stop'
$packageName    = 'duplicati'
$version        = '2.4.1.100-canary'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = ''
$checksum       = ''
$url64          = 'https://github.com/duplicati/duplicati/releases/download/v2.4.1.100_canary_2026-10-31/duplicati-2.4.1.100_canary_2026-10-31-win-x64-gui.msi'
$checksum64     = '6567ED253A62AD332202066436BE4844FE399A52A2BDF2F05286773F4F17725B'

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

