Import-Module Chocolatey-AU


function global:au_BeforeUpdate() {
	Get-RemoteFiles -Purge -NoSuffix 
}

function global:au_GetLatest {
	# Use GitHub API to get the latest release and its assets
	$releases_url = "https://api.github.com/repos/duplicati/duplicati/releases/latest"
	
	try {
		$release = Invoke-RestMethod -Uri $releases_url -UseBasicParsing
	} catch {
		Write-Warning "Failed to access GitHub API, falling back to web scraping"
		# Fallback to original method if API fails
		$download_page = Invoke-WebRequest -Uri https://github.com/duplicati/duplicati/releases/ -UseBasicParsing
		$tag_url = $download_page.links | ? href -match 'releases/tag/v' | % href | select -First 1
		
		if (-not $tag_url) {
			throw "No release tag found on the releases page"
		}
		
		$version = ($tag_url -split '/' | select -Last 1).trim('v')
		$modurl = "https://github.com/duplicati/duplicati/releases/download/v$version/duplicati-$version-win-x64-gui.zip"
		
		$cleanVersion = $version -replace '_stable.*'
		
		Write-Host "Version: $version"
        Write-Host "CleanVersion: $cleanVersion"	
		return @{ Version = $cleanVersion; URL32 = $modurl; PackageName = 'duplicati'; ChecksumType32 = 'sha256'; LongVersion = $version}
	}
	
	$version = $release.tag_name.TrimStart('v')
	$cleanVersion = $version -replace '_stable.*'
	
	# Look for ZIP files in the assets
	$zipAsset = $release.assets | Where-Object { 
		$_.name -match "duplicati.*\-win\-x64\-gui\.zip$" -or 
		$_.name -match ".*win-x64-gui\.zip$"
	} | Select-Object -First 1
	
	if ($zipAsset) {
		$download_url = $zipAsset.browser_download_url
		Write-Host "Found ZIP asset: $($zipAsset.name)"
		Write-Host "Download URL: $download_url"
        Write-Host "Version: $version"
        Write-Host "CleanVersion: $cleanVersion"		
	} else {
		# Fallback: assume standard naming convention
		$download_url = "https://github.com/duplicati/duplicati/releases/download/v$version/duplicati-$version-win-x64-gui.zip"
		Write-Host "No ZIP asset found in API response, trying standard URL: $download_url"
	}
	
	return @{ Version = $cleanVersion; URL32 = $download_url; PackageName = 'duplicati'; ChecksumType32 = 'sha256'; LongVersion = $version}
}

Update-Package -ChecksumFor none