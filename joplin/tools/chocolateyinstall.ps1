$ErrorActionPreference = 'Stop'
$packageName  = 'joplin'
$version      = '3.6.14'
$url          = 'https://github.com/laurent22/joplin/releases/download/v3.6.14/Joplin-Setup-3.6.14.exe'
$checksum     = '4AC91174220D28A93538ACA8FEFD87F4D9F358D98388A5A001432D506898E650'
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
