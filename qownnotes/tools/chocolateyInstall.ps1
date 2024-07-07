$ErrorActionPreference = 'Stop'
$packageName    = 'qownnotes'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/pbek/QOwnNotes/releases/download/v24.7.0/QOwnNotes.zip'
$checksum       = 'A253F432E24248747CA809C956ECEE1389A1B8AF927FD5625A63DADB933D4A55'


$packageArgs = @{
    PackageName  = $packageName
    Destination  = $toolsDir
    FileFullPath = Join-Path $toolsDir 'QOwnNotes.zip'
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
