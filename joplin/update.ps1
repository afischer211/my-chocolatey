Import-Module Chocolatey-AU

$NoCheckChocoVersion = $true

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
#            "(?i)(^\s*file\s*=\s*)(.*)" = "`$1Join-Path `$toolsDir '$($Latest.FileName32)'"
            "(?i)(\s*version\s*=\s*)('.*')"  = "`$1'$($Latest.Version)'"
			"(?i)(\s*checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
            "(?i)(\s*url\s*=\s*)('.*')"   = "`$1'$($Latest.URL64)'"
        }
        ".\legal\VERIFICATION.txt" = @{
            "(?i)(\s+x64:).*"            = "`${1} $($Latest.URL64)"
            "(?i)(checksum64:).*"        = "`${1} $($Latest.Checksum64)"
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

# --- Helper: fetch a GitHub release (pre-release or stable) via Invoke-WebRequest ---
function Get-GHRelease {
    param(
        [Parameter(Mandatory=$true)][string]$Repo,      # "owner/repo"
        [switch]$Prerelease,                            # latest prerelease if set
        [string]$Token,                                 # optional: $env:GITHUB_TOKEN
        [int]$MaxPages = 3                              # paginate just in case
    )

    $headers = @{
        "User-Agent"           = "choco-au-script"
        "Accept"               = "application/vnd.github+json"
        "X-GitHub-Api-Version" = "2022-11-28"
    }
    if ($Token) { $headers["Authorization"] = "token $Token" }

    if (-not $Prerelease) {
        $u = "https://api.github.com/repos/$Repo/releases/latest"
        $resp = Invoke-WebRequest -Uri $u -Headers $headers		
        return ($resp.Content | ConvertFrom-Json)
    }

    for ($page=1; $page -le $MaxPages; $page++) {
        $u = "https://api.github.com/repos/$Repo/releases?per_page=100&page=$page"
        $resp = Invoke-WebRequest -Uri $u -Headers $headers
        $releases = $resp.Content | ConvertFrom-Json
        if (-not $releases) { break }

        $cand = $releases |
            Where-Object { $_.prerelease -eq $true -and $_.draft -eq $false } |
            Sort-Object {[datetime]$_.published_at} -Descending

        if ($cand) { return $cand[0] }
    }
    return $null
}

# --- AU hook: build Latest from GH prerelease (fallback to stable if none) ---
function global:au_GetLatest {
    $repo = 'laurent22/joplin'
    $token = $env:GITHUB_TOKEN      # set to avoid rate limits (recommended)

    $r = Get-GHRelease -Repo $repo -Token $token
    if (-not $r) { $r = Get-GHRelease -Repo $repo -Token $token }  # fallback to stable
    if (-not $r) { throw "No release found for $repo." }

    $version = $r.tag_name.TrimStart('v')
    # Choose assets by regex (adjust to your project):
    $re64 = 'Joplin-Setup.*\.(exe)$'
    #$re32 = 'Joplin-Setup.*(x86|ia32|32).*\.(msi|exe|zip)$'

    $asset64 = $r.assets | Where-Object name -match $re64 | Select-Object -First 1
    #$asset32 = $r.assets | Where-Object name -match $re32 | Select-Object -First 1

    # Fallback: if only one universal asset exists, use it for URL64
    if (-not $asset64) { $asset64 = $r.assets | Where-Object { $_.browser_download_url -match '\.(exe)$' } | Select-Object -First 1 }

	$download_url=$asset64.browser_download_url
	Write-Host "url: $download_url"
	Write-Host "version: $version"
	
    @{
        Version      = $version
        URL64        = $asset64.browser_download_url
        ReleaseNotes = $r.html_url
    }
	
    return @{ Version = $version; URL64 = $download_url; PackageName = 'joplin'; ChecksumType64 = 'sha256'; }
}

Update-Package -ChecksumFor none

