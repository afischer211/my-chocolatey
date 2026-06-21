$ErrorActionPreference = 'Stop'
$packageName  = 'joplin'
$version      = '3.6.15'
$url          = 'https://github.com/laurent22/joplin/releases/download/v3.6.15/Joplin-Setup-3.6.15.exe'
$checksum     = '99E0741977F82132A9BF6C6593A57AB9C686A1C8355338D0AC1E1EA622ECC96B'
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
