$ErrorActionPreference = 'Stop'
$packageName = 'qownnotes'
$fileType    = 'exe'
$version     = '26.2.7'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://github.com/pbek/QOwnNotes/releases/download/v26.2.7/QOwnNotes.zip'
$checksum    = '9D3A094C36BDD5CC5CA7ABAF37AC5802B630FF062B7F4E44F3DB48931AE53EAB'
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
