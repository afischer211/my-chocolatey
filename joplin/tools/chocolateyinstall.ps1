$ErrorActionPreference = 'Stop'
$packageName  = 'joplin'
$version      = '3.7.24'
$url          = 'https://github.com/laurent22/joplin/releases/download/v3.7.24/Joplin-Setup-3.7.24.exe'
$checksum     = '9B528527BF24C4657C35052309437D2798C2AB38F80E32B66F0DEDB8DAEB3EC9'
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
