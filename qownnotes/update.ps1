Import-Module AU

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(\\`$url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
            "(?i)(\\`$checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }
        ".\legal\VERIFICATION.txt" = @{
            "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
            "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
        }
        ".\qownnotes.nuspec" = @{
            "(?i)(^\s*<version>).*(<\/version>)" = "`$1$($Latest.Version)`$2"
        }
	}
}

function global:au_BeforeUpdate() {
	Get-RemoteFiles -Purge -NoSuffix 
}


function global:au_GetLatest {
	$download_page = Invoke-WebRequest -Uri https://github.com/pbek/QOwnNotes/releases/ -UseBasicParsing
	
	$url        = $download_page.links | ? href -match '.zip$'| % href | select -First 1
	$version    = ($url -split '/' | select -Last 1 -Skip 1).trim('v')
	$modurl     = 'https://github.com' + $url 
	
	return @{ Version = $version; URL32 = $modurl; PackageName = 'qownnotes'}
}

Update-Package -ChecksumFor 32