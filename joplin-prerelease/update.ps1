Import-Module Chocolatey-AU

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
#            "(?i)(^\s*file\s*=\s*)(.*)" = "`$1Join-Path `$toolsDir '$($Latest.FileName32)'"
            "(?i)(^.*version\s*=\s*)('.*')"  = "`$1'$($Latest.Version)'"
			"(?i)(^.*checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }
        ".\legal\VERIFICATION.txt" = @{
            "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
            "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
        }
        ".\joplin.nuspec" = @{
            "(?i)(<version>).*?(</version>)" = "`${1}$($Latest.Version)`${2}"
            "(?i)(<releaseNotes>https://github.com/laurent22/joplin/releases/tag/v).*?(</releaseNotes>)" = "`${1}$($Latest.Version)`${2}"
        }
	}
}

function global:au_BeforeUpdate() {
	Get-RemoteFiles -Purge -NoSuffix
}


function global:au_GetLatest {
    $repo = 'laurent22/joplin'
    
    $release = Get-GitHubRelease -Repo $repo -Prerelease
    @{
        URL32   = $release.assets[0].browser_download_url
        Version = $release.tag_name.TrimStart('v')
    }
}

Update-Package -ChecksumFor none
