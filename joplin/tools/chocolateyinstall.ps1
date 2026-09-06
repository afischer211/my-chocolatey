$ErrorActionPreference = 'Stop'
$packageName  = 'joplin'
$version      = '3.7.16'
$url          = 'https://github.com/laurent22/joplin/releases/download/v3.7.16/Joplin-Setup-3.7.16.exe'
$checksum     = 'FE1BBD9A0540BA961945E7FB74E795FB495D62421ABA0C7323875376221BC253'
$checksumType = 'sha256'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  softwareName   = 'Joplin*'
  silentArgs     = '/ALLUSERS=1 /S'
  validExitCodes = @(0)
  url            = $url
  url64bit       = $url
  checksum       = $checksum
  checksumType   = $checksumType
  checksum64     = $checksum
  checksumType64 = $checksumType
}

Install-ChocolateyPackage @packageArgs
