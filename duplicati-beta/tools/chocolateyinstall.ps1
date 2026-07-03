$ErrorActionPreference = 'Stop'
$packageName    = 'duplicati'
$version        = '2.2.1.0-beta'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.2.1.0_beta_2026-03-05/duplicati-2.2.1.0_beta_2026-03-05-win-x86-gui.msi'
$checksum       = 'A3188EACA286FF6B456E108C3C49C5B3CBBA0BDA1D051B89A7E7133797299447'
$url64          = 'https://github.com/duplicati/duplicati/releases/download/v2.2.1.0_beta_2026-03-05/duplicati-2.2.1.0_beta_2026-03-05-win-x64-gui.msi'
$checksum64     = 'E5ED711A5EC41B512512DD2EE9F55D719CA8E48FA8B3C42D79D0C81D8E2CE35A'

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

