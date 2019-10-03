$ErrorActionPreference = 'Stop'
$packageName    = 'duplicati'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.0.4.23-2.0.4.23_beta_2019-07-14/duplicati-2.0.4.23_beta_2019-07-14-x86.msi' 
$checksum       = '28B3C2FD400CED570EE48861B65BDC67A58CCE501D9A788218016F603AB2538A'
$url64          = 'https://github.com/duplicati/duplicati/releases/download/v2.0.4.23-2.0.4.23_beta_2019-07-14/duplicati-2.0.4.23_beta_2019-07-14-x64.msi' 
$checksum64     = '3436C565DD9B58DF96E867BD1198300C569AFF75D4D9425090851C5CBB75E568'

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
  
