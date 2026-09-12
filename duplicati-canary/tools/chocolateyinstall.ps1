$ErrorActionPreference = 'Stop'
$packageName    = 'duplicati'
$version        = '2.4.0.101-canary'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.4.0.101_canary_2026-09-11/duplicati-2.4.0.101_canary_2026-09-11-win-x86-gui.msi'
$checksum       = '6153DDDD6591A63F349F6B995F4D2E1E339353485B0DF1AF0D3888FBEB9EE601'
$url64          = 'https://github.com/duplicati/duplicati/releases/download/v2.4.0.101_canary_2026-09-11/duplicati-2.4.0.101_canary_2026-09-11-win-x64-gui.msi'
$checksum64     = 'B8D2557317D7B595C9A0491A391B6EB620512EC824F690B4B8C790526B4842A8'

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

