$ErrorActionPreference = 'Stop'
$packageName    = 'duplicati'
$version        = '2.4.0.100-canary'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.4.0.100_canary_2026-09-04/duplicati-2.4.0.100_canary_2026-09-04-win-x86-gui.msi'
$checksum       = '1DBF2BA5E81D659FEB4B3D82354E5D134C6DA41EE3B68EE82AB96BBBFC4791F3'
$url64          = 'https://github.com/duplicati/duplicati/releases/download/v2.4.0.100_canary_2026-09-04/duplicati-2.4.0.100_canary_2026-09-04-win-x64-gui.msi'
$checksum64     = '8DABBF215B80CB651ED8283ACC1B4A0C454C0B3BD512F1B39FEE85AD0A34AB2C'

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

