Import-Module Chocolatey-AU

$NoCheckChocoVersion = $true

function global:au_SearchReplace {
	$cleanVersion = $($Latest.Version) -replace '\.'
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(\s*url\s*=\s*)'.*'" = "`${1}'$($Latest.URL32)'"
            "(?i)(\s*url64\s*=\s*)'.*'" = "`${1}'$($Latest.URL64)'"
            "(?i)(\s*checksumType\s*=\s*)'.*'" = "`${1}'$($Latest.ChecksumType32)'"
            "(?i)(\s*checksumType64\s*=\s*)'.*'" = "`${1}'$($Latest.ChecksumType64)'"
			"(?i)(\s*checksum\s*=\s*)'.*'" = "`${1}'$($Latest.Checksum32)'"
			"(?i)(\s*checksum64\s*=\s*)'.*'" = "`${1}'$($Latest.Checksum64)'"
            "(?i)(\s*version\s*=\s*)'.*'"  = "`${1}'$($Latest.Version)'"
        }
		".\legal\VERIFICATION.txt" = @{
            "(?i)(\s+x64:).*"            = "`${1} $($Latest.URL64)"
			"(?i)(checksum64:).*"        = "`${1} $($Latest.Checksum64)"
        }
        ".\duplicati.nuspec" = @{
            "(\<version\>).*?(\</version\>)" = "`${1}$($Latest.Version)`$2"
        }
	}
}

function global:au_BeforeUpdate() {
	Get-RemoteFiles -Purge -NoSuffix 
}

# Duplicati no longer publishes x86 MSIs for every release. Return the URL if it exists,
# or $null on HTTP 404 so the package can fall back to 64-bit only. Other errors rethrow.
function Get-OptionalUrl([string]$Url) {
	try {
		Invoke-WebRequest -Uri $Url -Method Head -UseBasicParsing | Out-Null
		return $Url
	} catch {
		if ($_.Exception.Response -and [int]$_.Exception.Response.StatusCode -eq 404) {
			Write-Warning "Optional 32-bit installer not found, building 64-bit only: $Url"
			return $null
		}
		throw
	}
}

function global:au_GetLatest {
	# Use GitHub API to get the latest release and its assets.
	# Authenticate when a token is available (GitHub Actions) so we don't hit the
	# 60 req/hr unauthenticated rate limit on the shared runner IPs, which forces
	# the fragile web-scraping fallback below.
	$releases_url = "https://api.github.com/repos/duplicati/duplicati/releases/latest"
	$headers = @{}
	if ($env:GH_API_TOKEN) { $headers['Authorization'] = "Bearer $env:GH_API_TOKEN" }

	try {
		$release = Invoke-RestMethod -Uri $releases_url -UseBasicParsing -Headers $headers
	} catch {
		Write-Warning "Failed to access GitHub API, falling back to web scraping"
		# Fallback to web scraping if the API fails. Exclude prerelease tags
		# (_beta_/_canary_/_experimental_) so a newer beta isn't mistaken for the
		# latest stable - the API's /releases/latest already skips prereleases.
		$download_page = Invoke-WebRequest -Uri https://github.com/duplicati/duplicati/releases/ -UseBasicParsing
		$tag_url = $download_page.links | ? href -match 'releases/tag/v' | ? href -notmatch '_beta_|_canary_|_experimental_' | % href | select -First 1

		if (-not $tag_url) {
			throw "No stable release tag found on the releases page"
		}

		$version = ($tag_url -split '/' | select -Last 1).trim('v')
		$modurl32 = Get-OptionalUrl "https://github.com/duplicati/duplicati/releases/download/v$version/duplicati-$version-win-x86-gui.msi"
		$modurl64 = "https://github.com/duplicati/duplicati/releases/download/v$version/duplicati-$version-win-x64-gui.msi"
		
		$cleanVersion = $version -replace '_stable.*'
		
		Write-Host "Version: $version"
        Write-Host "CleanVersion: $cleanVersion"	
		$latest = @{ Version = $cleanVersion; URL32 = $modurl32; URL64 = $modurl64; PackageName = 'duplicati'; ChecksumType32 = 'sha256'; ChecksumType64 = 'sha256'; LongVersion = $version}
		if (-not $modurl32) { $latest.Remove('URL32') }
		return $latest
	}
	
	$version = $release.tag_name.TrimStart('v')
	$cleanVersion = $version -replace '_stable.*'
	
	# Look for MSI files in the assets
	$msiAsset = $release.assets | Where-Object { 
		$_.name -match "duplicati.*\-win\-x64\-gui\.msi$" -or 
		$_.name -match ".*win-x64-gui\.msi$"
	} | Select-Object -First 1
	
	if ($msiAsset) {
		$download_url = $msiAsset.browser_download_url
		Write-Host "Found MSI asset: $($msiAsset.name)"
		Write-Host "Download URL: $download_url"
        Write-Host "Version: $version"
        Write-Host "CleanVersion: $cleanVersion"		
	} else {
		# Fallback: assume standard naming convention
		$download_url = "https://github.com/duplicati/duplicati/releases/download/v$version/duplicati-$version-win-x64-gui.msi"
		Write-Host "No MSI asset found in API response, trying standard URL: $download_url"
	}
	
	$msiAsset32 = $release.assets | Where-Object { $_.name -match "win-x86-gui\.msi$" } | Select-Object -First 1
	$download_url32 = if ($msiAsset32) { $msiAsset32.browser_download_url } else { Write-Warning "No 32-bit MSI in this release, building 64-bit only"; $null }

	$latest = @{ Version = $cleanVersion; URL32 = $download_url32; URL64 = $download_url; PackageName = 'duplicati'; ChecksumType32 = 'sha256'; ChecksumType64 = 'sha256'; LongVersion = $version}
	if (-not $download_url32) { $latest.Remove('URL32') }
	return $latest
}

Update-Package -ChecksumFor none -NoCheckChocoVersion