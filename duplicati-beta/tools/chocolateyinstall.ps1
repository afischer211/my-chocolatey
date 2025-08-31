$ErrorActionPreference = 'Stop'
$packageName    = 'duplicati-beta'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.0.5.1-2.0.5.1_beta_2020-01-18/duplicati-2.0.5.1_beta_2020-01-18-x86.msi' 
$checksum       = 'BF533D5E196B985DFF5BE4C443FA97BE8A1594A8ABB0F9758A9329F39BF5686F'
$url64          = 'https://github.com/duplicati/duplicati/releases/download/v2.0.5.1-2.0.5.1_beta_2020-01-18/duplicati-2.0.5.1_beta_2020-01-18-x64.msi' 
$checksum64     = 'BCE96441B59350D6E49C75DBE227F26BE79A4B657BC3BC858D40AE55F10F0C0B'

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
  
