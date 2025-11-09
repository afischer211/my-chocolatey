$ErrorActionPreference = 'Stop'
$packageName    = 'duplicati'
$version        = '2.2.0.1'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.2.0.1_stable_2025-11-09/duplicati-2.2.0.1_stable_2025-11-09-win-x86-gui.zip' 
$checksum       = '66498B960083110BDD821A2C6297AFE92D226B7E0B4A95426B1120A5041BB89C'
$url64          = 'https://github.com/duplicati/duplicati/releases/download/v2.2.0.1_stable_2025-11-09/duplicati-2.2.0.1_stable_2025-11-09-win-x64-gui.zip' 
$checksum64     = 'C3BCBAB07E8FB052CBE0D23B7ED54BCCF1DE78FBA4A49987D92E4228D9EA56B1'

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
  
