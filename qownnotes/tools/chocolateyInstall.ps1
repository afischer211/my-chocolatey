$ErrorActionPreference = 'Stop'
$packageName    = 'qownnotes'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/pbek/QOwnNotes/releases/download/v23.2.1/QOwnNotes.zip'
$checksum       = '2D9AD74BB906388D72F3AFB0E3035C653876D47BF809F62280FA9C2E741F288A'


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
