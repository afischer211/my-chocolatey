$ErrorActionPreference = 'Stop'
$packageName  = 'joplin'
$version      = '3.6.16'
$url          = 'https://github.com/laurent22/joplin/releases/download/v3.6.16/Joplin-Setup-3.6.16.exe'
$checksum     = 'BB26FA0BAB6905CF7A22F2D1DCB18EF7F7C0F62C2E10C84CD8E743F7CA962C50'
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
