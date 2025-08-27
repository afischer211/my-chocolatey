Import-Module AU

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "\$url\s*=\s*'.*'" = "`$url         = '$($Latest.URL32)'"
            "\$checksum\s*=\s*'[0-9A-Fa-f]+'" = "`$checksum    = '$($Latest.Checksum32)'"
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
	
	# Look for release tag links instead of zip files
	$tag_url    = $download_page.links | ? href -match 'releases/tag/v' | % href | select -First 1
	
	if (-not $tag_url) {
		throw "No release tag found on the releases page"
	}
	
	$version    = ($tag_url -split '/' | select -Last 1).trim('v')
	$modurl     = "https://github.com/pbek/QOwnNotes/releases/download/v$version/QOwnNotes.zip"
	
	return @{ Version = $version; URL32 = $modurl; PackageName = 'qownnotes'}
}

Update-Package -ChecksumFor 32