$ErrorActionPreference = 'Stop'
$packageName    = 'duplicati'
$version        = '2.4.0.104-canary'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.4.0.104_canary_2026-10-11/duplicati-2.4.0.104_canary_2026-10-11-win-x86-gui.msi'
$checksum       = 'AA72BECA160013D3E3B790129686C01841A09902D7B4F4C159F748CE4836E716'
$url64          = 'https://github.com/duplicati/duplicati/releases/download/v2.4.0.104_canary_2026-10-11/duplicati-2.4.0.104_canary_2026-10-11-win-x64-gui.msi'
$checksum64     = '0EBE2663BA245FB73DDE0AF07E1879B2C4953A8A652184C953017B233CB730ED'

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

