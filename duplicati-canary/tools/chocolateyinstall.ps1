$ErrorActionPreference = 'Stop'
$packageName    = 'duplicati'
$version        = '2.4.1.101-canary'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = ''
$checksum       = ''
$url64          = 'https://github.com/duplicati/duplicati/releases/download/v2.4.1.101_canary_2026-11-07/duplicati-2.4.1.101_canary_2026-11-07-win-x64-gui.msi'
$checksum64     = '4F99C1E802903467508BF858F99AD9001C79D3B1A82BDB7909B5E0F53933A137'

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

