$ErrorActionPreference = 'Stop'
$packageName    = 'duplicati'
$version        = '2.4.1.102-canary'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = ''
$checksum       = ''
$url64          = 'https://github.com/duplicati/duplicati/releases/download/v2.4.1.102_canary_2026-11-14/duplicati-2.4.1.102_canary_2026-11-14-win-x64-gui.msi'
$checksum64     = '92330EEF189D098CC8ABF07B7EFCA9C9C066353808F3D70A276E44FC1B594C9E'

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

