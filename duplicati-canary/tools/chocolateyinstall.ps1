$ErrorActionPreference = 'Stop'
$packageName    = 'duplicati'
$version        = '2.3.0.107-canary'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.3.0.107_canary_2026-07-13/duplicati-2.3.0.107_canary_2026-07-13-win-x86-gui.msi'
$checksum       = '4A6D1E060D48DF50D58F7D5964A69D99CD711E577054BE66A2288D70B14D20C2'
$url64          = 'https://github.com/duplicati/duplicati/releases/download/v2.3.0.107_canary_2026-07-13/duplicati-2.3.0.107_canary_2026-07-13-win-x64-gui.msi'
$checksum64     = '09527C547B7AA93DE43754774FE10AFBEED9246BEF6AB95ECF67A67BE275D572'

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

