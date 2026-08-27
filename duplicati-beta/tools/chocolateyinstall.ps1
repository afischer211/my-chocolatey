$ErrorActionPreference = 'Stop'
$packageName    = 'duplicati'
$version        = '2.3.1.1-beta'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.3.1.1_beta_2026-08-26/duplicati-2.3.1.1_beta_2026-08-26-win-x86-gui.msi'
$checksum       = '4B7AAA0818EB92DCED772AFEFCBA8F391765B8F7046E56D8052EA2910ABAD922'
$url64          = 'https://github.com/duplicati/duplicati/releases/download/v2.3.1.1_beta_2026-08-26/duplicati-2.3.1.1_beta_2026-08-26-win-x64-gui.msi'
$checksum64     = '09081123558367E511655345E83B2E18A542785B63810D337E37881795F74486'

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

