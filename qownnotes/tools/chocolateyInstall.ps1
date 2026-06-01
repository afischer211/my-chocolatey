$ErrorActionPreference = 'Stop'
$packageName = 'qownnotes'
$version     = '26.6.1'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://github.com/pbek/QOwnNotes/releases/download/v26.6.1/QOwnNotes.zip'
$checksum    = 'E0243BEA58894E794E3794BB5AD81581F6218FDCB850A72A5517F29699B1F49E'
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
