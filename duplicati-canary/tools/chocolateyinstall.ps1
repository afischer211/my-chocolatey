$ErrorActionPreference = 'Stop'
$packageName    = 'duplicati'
$version        = '2.4.0.103-canary'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.4.0.103_canary_2026-10-02/duplicati-2.4.0.103_canary_2026-10-02-win-x86-gui.msi'
$checksum       = 'DE56AA3CF8A563522C4B539A9044ED011A4822192BB856F8DF5550688389E600'
$url64          = 'https://github.com/duplicati/duplicati/releases/download/v2.4.0.103_canary_2026-10-02/duplicati-2.4.0.103_canary_2026-10-02-win-x64-gui.msi'
$checksum64     = 'F27E118B217CFA63925C765AB89C1C20A8E69B293D16120CFF4820425056B312'

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

