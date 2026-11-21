$ErrorActionPreference = 'Stop'
$packageName    = 'duplicati'
$version        = '2.4.1.103-canary'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = ''
$checksum       = ''
$url64          = 'https://github.com/duplicati/duplicati/releases/download/v2.4.1.103_canary_2026-11-20/duplicati-2.4.1.103_canary_2026-11-20-win-x64-gui.msi'
$checksum64     = '5303DC2CD780635DC2B1F7CD9705076BDA19F8A9AFAB7C83796C5E90E19E0F04'

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

