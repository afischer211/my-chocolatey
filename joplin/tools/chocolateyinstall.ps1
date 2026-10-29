$ErrorActionPreference = 'Stop'
$packageName  = 'joplin'
$version      = '3.7.22'
$url          = 'https://github.com/laurent22/joplin/releases/download/v3.7.22/Joplin-Setup-3.7.22.exe'
$checksum     = 'EE11551239E7D680F76C6A4DDBC2362DDA850981904FDB365298E4D43BF1DF4D'
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
