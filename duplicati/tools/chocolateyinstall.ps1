$ErrorActionPreference = 'Stop'
$packageName    = 'duplicati'
$version        = '2.4.1.1'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.4.1.1_stable_2026-11-25/duplicati-2.4.1.1_stable_2026-11-25-win-x86-gui.msi' 
$checksum       = '66A14D8A1FFA67C13580BAD84521B9F24F4418DEE9441DA8C37DA91A04A727FF'
$url64          = 'https://github.com/duplicati/duplicati/releases/download/v2.4.1.1_stable_2026-11-25/duplicati-2.4.1.1_stable_2026-11-25-win-x64-gui.msi' 
$checksum64     = '11F908CB3C52E50215B97217D06ECA752224AEB3010CECFE2E9ED867AF1E7D6A'

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
  
