$ErrorActionPreference = 'Stop'
$packageName    = 'qownnotes'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/pbek/QOwnNotes/releases/download/v20.11.8/QOwnNotes.zip' 
$checksum       = 'A8E1E1D4B222F2CC7F17FBB9C62D28115728C4ADEFF96E78427CA227372C9471'
$url64          = $url
$checksum64     = $checksum
$checksumType   = 'sha256' 
$checksumType64 = $checksumType

$packageArgs = @{
    #packageName = $env:ChocolateyPackageName
    packageName    = $packageName
    unzipLocation = "$toolsDir"
    url            = $url
    url64bit       = $url64
    checksum       = $checksum 
    checksumType   = 'sha256' 
    checksum64     = $checksum64
    checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Remove-Item $toolsDir\*.zip -ea 0

$files = Get-ChildItem $toolsDir -include *.exe -recurse

foreach ($file in $files) {
  if (!($file.Name.Contains("QOwnNotes.exe"))) {
    New-Item "$file.ignore" -type file -force | Out-Null
  }
}

$programsDir  = [System.Environment]::GetFolderPath('Programs')
$exePath      = Get-ChildItem "$toolsDir" -Filter "QOwnNotes.exe" -Recurse | select -First 1 -expand FullName

Install-ChocolateyShortcut -ShortcutFilePath "$programsDir\QOwnNotes.lnk" -TargetPath "$exePath"
Install-ChocolateyShortcut -ShortcutFilePath "$programsDir\QOwnNotes (Portable).lnk" -TargetPath "$exePath" -Arguments "--portable"
