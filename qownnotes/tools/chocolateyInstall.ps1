$ErrorActionPreference = 'Stop'
$packageName = 'qownnotes'
$fileType    = 'exe'
$version     = '26.3.13'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://github.com/pbek/QOwnNotes/releases/download/v26.3.13/QOwnNotes.zip'
$checksum    = 'C1A493CFD953F2FEE39FFAD3D778CE2C0ABE2B825C382EA4C11460C36ED0B05E'
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
