$ErrorActionPreference = 'Stop'
$packageName  = 'joplin'
$version      = '3.7.21'
$url          = 'https://github.com/laurent22/joplin/releases/download/v3.7.21/Joplin-Setup-3.7.21.exe'
$checksum     = '4222536C69360A30A566627B35C2E1CD8D38D0C79735EBDE4E39EDBCDDD750CD'
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
