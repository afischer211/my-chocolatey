$ErrorActionPreference = 'Stop'
$packageName    = 'duplicati'
$version        = '2.3.1.0-beta'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.3.1.0_beta_2026-07-28/duplicati-2.3.1.0_beta_2026-07-28-win-x86-gui.msi'
$checksum       = '6B7C8BB77CEF05100280ED8E37BF95D6C3C20865A271A5C0B4AF4A67040DDDB5'
$url64          = 'https://github.com/duplicati/duplicati/releases/download/v2.3.1.0_beta_2026-07-28/duplicati-2.3.1.0_beta_2026-07-28-win-x64-gui.msi'
$checksum64     = '2ED51F0BDA0581CD0AEB6595A6E1AB5627370034AF0FBCA9D5293BA314BB88C3'

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

