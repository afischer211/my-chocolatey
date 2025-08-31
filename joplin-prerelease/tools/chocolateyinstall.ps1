# Joplin Notes and To-Do
# 2018 foo.li systeme + software, afischer211
$ErrorActionPreference = 'Stop';
$toolsDir              = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$version               = '3.4.7'
$packageSearch         = 'Joplin*'
$installerFileName     = 'Joplin-Setup-' + $version + '.exe'
$file          = Join-Path $toolsDir $installerFileName
$installerType = 'exe'
$packageName   = 'joplin-prerelease'
$url 		   = 'https://github.com/laurent22/joplin/releases/download/v3.4.7/Joplin-Setup-3.4.7.exe'
$checksum      = 'F9AF0752B60DD85D738625EF4C19477B63590C12CF1C32868F9396C5C286D6FD'
$checksumType  = 'sha256'

$packageArgs = @{
  packageName    = $packageName
  fileType       = $installerType
  softwareName   = $packageSearch
  silentArgs     = '/ALLUSERS=1 /S'
  validExitCodes = @(0)
  url           = $url
  url64bit      = $url
  checksum      = $checksum
  checksumType  = $checksumType
  checksum64    = $checksum
  checksumType64= $checksumType  
}

try {   
    $app = Get-ItemProperty -Path @('HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*',
                                    'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*') `
            -ErrorAction:SilentlyContinue | Where-Object { $_.DisplayName -like $packageSearch }
	
    if ($app -and ([version]$app.DisplayVersion -ge [version]$version)) {
        Write-Output $(
        'Joplin ' + $version + ' or greater is already installed. ' +
        'No need to download and install again. Otherwise uninstall first.'
        )
    } else {
        Install-ChocolateyPackage @packageArgs
    }           
} catch {
    throw $_.Exception
}
