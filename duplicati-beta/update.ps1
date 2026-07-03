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
        ".\duplicati-beta.nuspec" = @{
            "(\<version\>).*?(\</version\>)" = "`${1}$($Latest.Version)`$2"
        }
	}
}

function global:au_BeforeUpdate() {
	Get-RemoteFiles -Purge -NoSuffix
}

function global:au_GetLatest {
	# Use GitHub API to get the release list and pick the newest beta-tagged release.
	# NOTE: intentionally NOT /releases/latest - that endpoint excludes prereleases
	# entirely, which is exactly how the stable duplicati package ignores beta/canary builds.
	$releases_url = "https://api.github.com/repos/duplicati/duplicati/releases"

	try {
		$releases = Invoke-RestMethod -Uri $releases_url -UseBasicParsing
		$betaRelease = $releases | Where-Object { $_.tag_name -match '_beta_' } | Select-Object -First 1

		if (-not $betaRelease) {
			throw "No beta release found in API response"
		}
	} catch {
		Write-Warning "Failed to access GitHub API, falling back to web scraping"
		# Fallback to web scraping if the API fails, filtered to beta tags only.
		$download_page = Invoke-WebRequest -Uri https://github.com/duplicati/duplicati/releases/ -UseBasicParsing
		$tag_url = $download_page.links | ? href -match 'releases/tag/v.*_beta_' | % href | select -First 1

		if (-not $tag_url) {
			throw "No beta release tag found on the releases page"
		}

		$version = ($tag_url -split '/' | select -Last 1).trim('v')
		$cleanVersion = ($version -replace '_beta.*') + '-beta'
		$modurl32 = "https://github.com/duplicati/duplicati/releases/download/v$version/duplicati-$version-win-x86-gui.msi"
		$modurl64 = "https://github.com/duplicati/duplicati/releases/download/v$version/duplicati-$version-win-x64-gui.msi"

		Write-Host "Version: $version"
        Write-Host "CleanVersion: $cleanVersion"
		return @{ Version = $cleanVersion; URL32 = $modurl32; URL64 = $modurl64; PackageName = 'duplicati'; ChecksumType32 = 'sha256'; ChecksumType64 = 'sha256'; LongVersion = $version}
	}

	$version = $betaRelease.tag_name.TrimStart('v')
	$cleanVersion = ($version -replace '_beta.*') + '-beta'

	# Look for MSI files in the assets
	$msiAsset = $betaRelease.assets | Where-Object {
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

	$download_url32 = "https://github.com/duplicati/duplicati/releases/download/v$version/duplicati-$version-win-x86-gui.msi"

	return @{ Version = $cleanVersion; URL32 = $download_url32; URL64 = $download_url; PackageName = 'duplicati'; ChecksumType32 = 'sha256'; ChecksumType64 = 'sha256'; LongVersion = $version}
}

Update-Package -ChecksumFor none -NoCheckChocoVersion
