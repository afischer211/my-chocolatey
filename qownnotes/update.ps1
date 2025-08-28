Import-Module AU

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            '(.*url\s*=\s*).*$' = "`$`$1'$($Latest.URL32)'"
			'(?i)(.*checksum\s*=\s*).*$' = "`$`$1'$($Latest.Checksum32)'"
            '(?i)(.*version\s*=\s*).*$'  = "`$`$1'$($Latest.Version)'"
        }
        ".\legal\VERIFICATION.txt" = @{
            "(?i)(\s+x32:).*"            = "`$`$1 $($Latest.URL32)"
            "(?i)(checksum32:).*"        = "`$`$1 $($Latest.Checksum32)"
        }
        ".\qownnotes.nuspec" = @{
            '(?i)(<version>).*(<\/version>)' = "`$`$1$($Latest.Version)`$`$2"
        }
	}
}

function global:au_BeforeUpdate() {
	Get-RemoteFiles -Purge -NoSuffix 
}


function global:au_GetLatest {
	# Use GitHub API to get the latest release and its assets
	$releases_url = "https://api.github.com/repos/pbek/QOwnNotes/releases/latest"
	
	try {
		$release = Invoke-RestMethod -Uri $releases_url -UseBasicParsing
	} catch {
		Write-Warning "Failed to access GitHub API, falling back to web scraping"
		# Fallback to original method if API fails
		$download_page = Invoke-WebRequest -Uri https://github.com/pbek/QOwnNotes/releases/ -UseBasicParsing
		$tag_url = $download_page.links | ? href -match 'releases/tag/v' | % href | select -First 1
		
		if (-not $tag_url) {
			throw "No release tag found on the releases page"
		}
		
		$version = ($tag_url -split '/' | select -Last 1).trim('v')
		$modurl = "https://github.com/pbek/QOwnNotes/releases/download/v$version/QOwnNotes.zip"
		
		return @{ Version = $version; URL32 = $modurl; PackageName = 'qownnotes'}
	}
	
	$version = $release.tag_name.TrimStart('v')
	
	# Look for ZIP files in the assets
	$zipAsset = $release.assets | Where-Object { 
		$_.name -match "QOwnNotes.*\.zip$" -or 
		$_.name -eq "QOwnNotes.zip" -or
		$_.name -match ".*[Pp]ortable.*\.zip$" -or
		$_.name -match ".*[Ww]indows.*\.zip$"
	} | Select-Object -First 1
	
	if ($zipAsset) {
		$download_url = $zipAsset.browser_download_url
		Write-Host "Found ZIP asset: $($zipAsset.name)"
		Write-Host "Download URL: $download_url"
	} else {
		# Fallback: assume standard naming convention
		$download_url = "https://github.com/pbek/QOwnNotes/releases/download/v$version/QOwnNotes.zip"
		Write-Host "No ZIP asset found in API response, trying standard URL: $download_url"
	}
	
	return @{ Version = $version; URL32 = $download_url; PackageName = 'qownnotes'}
}

Update-Package -ChecksumFor 32