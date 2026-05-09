$ErrorActionPreference = 'Stop'
$packageName  = 'joplin'
$version      = '3.6.11'
$url          = 'https://github.com/laurent22/joplin/releases/download/v3.6.11/Joplin-Setup-3.6.11.exe'
$checksum     = '961AAF5C7D008C1546BE227816AA2712595F1EF4B95FE459EFB802119C168DED'
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
