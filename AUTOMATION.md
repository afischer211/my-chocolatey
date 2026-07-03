# Automated Chocolatey Package Updates

This repository uses GitHub Actions to automatically check for new upstream releases and
publish updated Chocolatey packages. All four packages follow the same workflow pattern;
this doc covers that shared pattern plus anything package-specific.

## Schedule

| Package | Workflow file | Cron (UTC) |
|---|---|---|
| Duplicati | `.github/workflows/update-duplicati.yml` | `0 7 * * *` (7:00 AM) |
| Duplicati (canary) | `.github/workflows/update-duplicati-canary.yml` | `30 7 * * *` (7:30 AM) |
| Joplin | `.github/workflows/update-joplin.yml` | `30 6 * * *` (6:30 AM) |
| QOwnNotes | `.github/workflows/update-qownnotes.yml` | `0 6 * * *` (6:00 AM) |

Schedules are staggered so the four jobs don't compete for the same shared PowerShell
Gallery / Chocolatey.org resources at once. Each workflow can also be triggered manually
(see below).

## How it works

Each workflow:
1. Checks out the repository.
2. Installs the NuGet package provider and the `Chocolatey-AU` PowerShell module, then installs Chocolatey if it isn't already present on the runner. This step retries (up to 5 attempts, with backoff) — see [Transient PowerShell Gallery failures](#transient-powershell-gallery-failures) below.
3. Runs the package's `update.ps1` script (the AU module), which checks the upstream project for a newer version and, if found, rewrites the package's `.nuspec`, `chocolateyinstall.ps1`, and `VERIFICATION.txt` with the new version/URL/checksum.
4. Checks `git status --porcelain` to see if step 3 actually changed anything. If not, the rest of the job is skipped and it exits cleanly — this is the common case on any given day.
5. If there are changes:
   - Configures a `github-actions[bot]` git identity.
   - Builds the package with `choco pack`, validates it with `choco install --what-if`, then pushes it to `https://push.chocolatey.org/` using the `CHOCOLATEY_API_KEY` secret.
   - Commits the updated metadata files and creates/updates a version tag (`<package>-v<version>`).

### Tagging behavior differs slightly between workflows

- **Duplicati** deletes the tag both locally and on the remote before recreating it (`git tag -d`, `git push --delete origin`, then `git tag` + `git push origin $tagName`). If the tag doesn't already exist remotely, `git push --delete` will fail — this is only safe because in practice the tag from the previous version always exists once the package has shipped once.
- **Duplicati (canary)** uses the same delete-and-recreate strategy as stable Duplicati, tagging as `duplicati-canary-v<version>` (distinct from stable's `duplicati-v<version>` tags) so the two are never confused.
- **Joplin** and **QOwnNotes** instead force-move the tag (`git tag -f $tagName`, `git push origin $tagName --force`), which works whether or not the tag previously existed.

Neither approach is more "correct" than the other, but be aware of the difference before copying one workflow as a template for a new package — a force-push to a tag is a rewriting operation and will silently overwrite history if the tag is ever reused for something else.

### Transient PowerShell Gallery failures

The module-install step wraps `Install-PackageProvider` and `Install-Module -Name Chocolatey-AU`
in a retry loop (`Install-WithRetry`, 5 attempts, exponential-ish backoff). This exists because
these calls have occasionally failed with a misleading `No match was found for the specified
search criteria` error even though the module exists and the identical call succeeds moments
later — a transient PowerShell Gallery / shared-runner-IP issue, not a real configuration
problem. Seeing `Attempt 2/5 to install Chocolatey-AU module failed: ...` in the logs is
expected occasional noise, not a failure, as long as a later attempt succeeds. If all 5
attempts fail, the step (and job) fails for real and is worth investigating.

## Required Setup

### 1. Chocolatey API Key

You need to configure a GitHub repository secret for publishing to Chocolatey.org:

1. Go to your repository on GitHub.
2. Navigate to Settings → Secrets and variables → Actions.
3. Create a new repository secret named `CHOCOLATEY_API_KEY`.
4. Set the value to your Chocolatey.org API key.

To get your API key:
1. Log in to https://chocolatey.org/.
2. Go to your account settings.
3. Navigate to the API Keys section.
4. Generate or copy your API key.

### 2. Repository Permissions

Ensure the repository has the following permissions enabled:
- Actions: Read and write (for workflow execution)
- Contents: Write (for committing updates and pushing tags)
- Metadata: Read (for repository information)

## Manual Execution

You can manually trigger any of the four workflows:

1. Go to the "Actions" tab in your GitHub repository.
2. Select "Update Duplicati Package", "Update Duplicati Canary Package", "Update Joplin Package", or "Update QOwnNotes Package".
3. Click "Run workflow".
4. Choose the branch and click "Run workflow".

## Files Modified by Automation

| Package | Files |
|---|---|
| Duplicati | `duplicati/duplicati.nuspec`, `duplicati/tools/chocolateyinstall.ps1`, `duplicati/legal/VERIFICATION.txt` |
| Duplicati (canary) | `duplicati-canary/duplicati-canary.nuspec`, `duplicati-canary/tools/chocolateyinstall.ps1`, `duplicati-canary/legal/VERIFICATION.txt` |
| Joplin | `joplin/joplin.nuspec`, `joplin/tools/chocolateyinstall.ps1`, `joplin/legal/VERIFICATION.txt` |
| QOwnNotes | `qownnotes/qownnotes.nuspec`, `qownnotes/tools/chocolateyInstall.ps1`, `qownnotes/legal/VERIFICATION.txt` |

## Monitoring

You can monitor the automation:
- Check the Actions tab for workflow runs.
- Review commit history for automatic updates.
- Check tags for version releases.
- Monitor Chocolatey.org for published packages.

## Troubleshooting

Common issues and solutions:

1. **API Key errors**: Ensure `CHOCOLATEY_API_KEY` secret is properly configured.
2. **Permission errors**: Check repository permissions in Settings.
3. **Package validation errors**: Review the AU module configuration in `update.ps1`.
4. **Module install failures**: See [Transient PowerShell Gallery failures](#transient-powershell-gallery-failures) above — usually self-resolves via retry; only investigate further if all 5 attempts fail.
5. **Network errors**: GitHub Actions may have temporary connectivity issues.

For detailed logs, check the workflow run details in the Actions tab.

## Adding a new package's automation

See [CONTRIBUTING.md](CONTRIBUTING.md) for a checklist covering the package folder layout,
the workflow template, and the docs that need updating (this file and the tables above).
