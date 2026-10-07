$ErrorActionPreference = 'Stop'
$packageName    = 'duplicati'
$version        = '2.4.0.1'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.4.0.1_stable_2026-10-07/duplicati-2.4.0.1_stable_2026-10-07-win-x86-gui.msi' 
$checksum       = '46FA6276AFF7A8DDCCF4903FA537F9DFA2BD6F60D137BC68C761FC7D5F473D93'
$url64          = 'https://github.com/duplicati/duplicati/releases/download/v2.4.0.1_stable_2026-10-07/duplicati-2.4.0.1_stable_2026-10-07-win-x64-gui.msi' 
$checksum64     = '491B2CABEF0106CB7964A7CD2AE54A43CB2F2573D0B84C4AF00961D868E1B3B9'

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
  
