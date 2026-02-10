$ErrorActionPreference = 'Stop'
$packageName = 'qownnotes'
$fileType    = 'exe'
$version     = '26.2.1'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://github.com/pbek/QOwnNotes/releases/download/v26.2.1/QOwnNotes.zip'
$checksum    = '7AB75202F5226BDB9BD7971F0DBB6FE5B6CD4D0E3D504D43419DA8C0CA443C10'
$checksumType = 'sha256'

# First, download the ZIP file
$zipPath = Join-Path $toolsDir 'QOwnNotes.zip'

$downloadArgs = @{
    PackageName   = $packageName
    FileFullPath  = $zipPath
    Url           = $url
    Checksum      = $checksum
    ChecksumType  = $checksumType
}

Get-ChocolateyWebFile @downloadArgs

# Then extract the ZIP file
$packageArgs = @{
    PackageName  = $packageName
    Destination  = $toolsDir
    FileFullPath = $zipPath
}

Get-ChocolateyUnzip @packageArgs

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
