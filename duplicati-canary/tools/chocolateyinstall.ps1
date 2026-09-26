$ErrorActionPreference = 'Stop'
$packageName    = 'duplicati'
$version        = '2.4.0.102-canary'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.4.0.102_canary_2026-09-25/duplicati-2.4.0.102_canary_2026-09-25-win-x86-gui.msi'
$checksum       = '757A729C1B1E642CD6AC7BFC2756C352BFD19FD68A96D599D6FB60052F8AED18'
$url64          = 'https://github.com/duplicati/duplicati/releases/download/v2.4.0.102_canary_2026-09-25/duplicati-2.4.0.102_canary_2026-09-25-win-x64-gui.msi'
$checksum64     = '6A8813FDFAD8F6D3476DDB3DB40D1FBACF31AA80EFB87D81D982A7589FD83A47'

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

