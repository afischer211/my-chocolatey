$ErrorActionPreference = 'Stop'
$packageName  = 'joplin'
$version      = '3.5.13'
$url          = 'https://github.com/laurent22/joplin/releases/download/v3.5.13/Joplin-Setup-3.5.13.exe'
$checksum     = '808C5155861AFCAA69264C87EBE9F718D5229ED0DD7D937C1FFA7E9B907DCA89'
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
