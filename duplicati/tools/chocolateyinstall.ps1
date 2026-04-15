$ErrorActionPreference = 'Stop'
$packageName    = 'duplicati'
$version        = '2.3.0.0'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.3.0.0_stable_2026-04-14/duplicati-2.3.0.0_stable_2026-04-14-win-x86-gui.msi' 
$checksum       = '95814143448EC9B853D32B3788D9DEF8F7D832F7134D3F44DE8C23F19C084A7A'
$url64          = 'https://github.com/duplicati/duplicati/releases/download/v2.3.0.0_stable_2026-04-14/duplicati-2.3.0.0_stable_2026-04-14-win-x64-gui.msi' 
$checksum64     = '10C5C7AE056E0635712D51C5A9B6CE806B0BE0C2493986A53B2B4DAE57ABAC66'

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
  
