$ErrorActionPreference = 'Stop'
$packageName  = 'joplin'
$version      = '3.7.18'
$url          = 'https://github.com/laurent22/joplin/releases/download/v3.7.18/Joplin-Setup-3.7.18.exe'
$checksum     = '88631FA78E352245BC5770573A0905D83876E530D97F222817177D7C9A6CAE7F'
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
