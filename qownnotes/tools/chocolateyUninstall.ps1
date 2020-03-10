$programsDir = [System.Environment]::GetFolderPath('Programs')

if ((Test-Path -Path "$programsDir\QOwnNotes.lnk") -Or (Test-Path -Path "$programsDir\QOwnNotes (Portable).lnk")) {
  Remove-Item -Force -ea 0 "$programsDir\QOwnNotes.lnk"
  Remove-Item -Force -ea 0 "$programsDir\QOwnNotes (Portable).lnk"
}
