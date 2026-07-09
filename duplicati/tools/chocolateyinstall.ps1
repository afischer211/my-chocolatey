$ErrorActionPreference = 'Stop'
$packageName    = 'duplicati'
$version        = '2.3.0.4'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.3.0.4_stable_2026-07-09/duplicati-2.3.0.4_stable_2026-07-09-win-x86-gui.msi' 
$checksum       = '2E2559756EF363B5B8F82AD06075BF07B2F9F63B003CD48620966BA6577CFD11'
$url64          = 'https://github.com/duplicati/duplicati/releases/download/v2.3.0.4_stable_2026-07-09/duplicati-2.3.0.4_stable_2026-07-09-win-x64-gui.msi' 
$checksum64     = 'E098B2E9CD6435D239B266CC1370F5F5DF43490E215B8A1CC25B39A474BEFBD0'

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
  
