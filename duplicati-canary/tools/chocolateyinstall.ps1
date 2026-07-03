$ErrorActionPreference = 'Stop'
$packageName    = 'duplicati'
$version        = '2.3.0.106-canary'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.3.0.106_canary_2026-07-03/duplicati-2.3.0.106_canary_2026-07-03-win-x86-gui.msi'
$checksum       = 'CE5734588BF6AEA4F8E0EB4461D1CE879BCC5CF0EB2112FE7D05FFBA8DAD3CBA'
$url64          = 'https://github.com/duplicati/duplicati/releases/download/v2.3.0.106_canary_2026-07-03/duplicati-2.3.0.106_canary_2026-07-03-win-x64-gui.msi'
$checksum64     = '0108CFF0AA76984406F10247E9C5F66414EAC8113C072985845DAF1828254B6B'

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

