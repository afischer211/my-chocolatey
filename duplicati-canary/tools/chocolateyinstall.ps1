$ErrorActionPreference = 'Stop'
$packageName    = 'duplicati'
$version        = '2.3.0.108-canary'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.3.0.108_canary_2026-07-20/duplicati-2.3.0.108_canary_2026-07-20-win-x86-gui.msi'
$checksum       = '21A4263DB1488A1980BDF238BBFF8DF16BF6F4F224CA1DA3F8A24C9C4F8F471B'
$url64          = 'https://github.com/duplicati/duplicati/releases/download/v2.3.0.108_canary_2026-07-20/duplicati-2.3.0.108_canary_2026-07-20-win-x64-gui.msi'
$checksum64     = 'C9D59F768753EAC920EB9FACF84C84B8B61276986FCCFF2F5A51E15A049BB638'

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

