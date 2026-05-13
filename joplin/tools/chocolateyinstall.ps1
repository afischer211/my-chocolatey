$ErrorActionPreference = 'Stop'
$packageName  = 'joplin'
$version      = '3.6.13'
$url          = 'https://github.com/laurent22/joplin/releases/download/v3.6.13/Joplin-Setup-3.6.13.exe'
$checksum     = '4416D1B217FF483C1DE73C45D0958C6A3562B62ED1F0C7DAED51EDBE111C1672'
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
