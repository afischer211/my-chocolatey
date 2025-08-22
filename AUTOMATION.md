# Automated Chocolatey Package Updates

This repository now includes GitHub Actions automation for updating the QOwnNotes Chocolatey package.

## Overview

The automated workflow:
1. **Runs daily** at 6:00 AM UTC (can also be manually triggered)
2. **Checks for updates** using the existing AU (Automatic Updater) PowerShell module
3. **Updates package files** if a new version is found
4. **Builds and validates** the .nupkg file
5. **Publishes to Chocolatey.org** automatically
6. **Commits changes** back to the repository
7. **Creates version tags** for tracking

## Required Setup

### 1. Chocolatey API Key

You need to configure a GitHub repository secret for publishing to Chocolatey.org:

1. Go to your repository on GitHub
2. Navigate to Settings → Secrets and variables → Actions
3. Create a new repository secret named `CHOCOLATEY_API_KEY`
4. Set the value to your Chocolatey.org API key

To get your API key:
1. Log in to https://chocolatey.org/
2. Go to your account settings
3. Navigate to the API Keys section
4. Generate or copy your API key

### 2. Repository Permissions

Ensure the repository has the following permissions enabled:
- Actions: Read and write (for workflow execution)
- Contents: Write (for committing updates)
- Metadata: Read (for repository information)

## Manual Execution

You can manually trigger the workflow:

1. Go to the "Actions" tab in your GitHub repository
2. Select "Update QOwnNotes Package" workflow
3. Click "Run workflow" button
4. Choose the branch and click "Run workflow"

## Workflow Details

### Schedule
- **Daily at 6:00 AM UTC** (`0 6 * * *`)
- Can be modified in `.github/workflows/update-qownnotes.yml`

### Process
1. Checkout repository
2. Install AU PowerShell module and Chocolatey
3. Run the `update.ps1` script in the qownnotes folder
4. Check for changes in the package files
5. If changes detected:
   - Build the .nupkg file using `choco pack`
   - Validate the package
   - Push to Chocolatey.org
   - Commit changes to repository
   - Create a version tag (e.g., `qownnotes-v25.5.4`)

### Error Handling
- Workflow fails if API key is not configured
- Validation errors prevent publishing
- Git operations are properly configured with bot credentials

## Files Modified by Automation

The workflow updates these files automatically:
- `qownnotes/qownnotes.nuspec` - Version number
- `qownnotes/tools/chocolateyInstall.ps1` - Download URL and checksum
- `qownnotes/legal/VERIFICATION.txt` - Download URL and checksum

## Monitoring

You can monitor the automation:
- Check the Actions tab for workflow runs
- Review commit history for automatic updates
- Check tags for version releases
- Monitor Chocolatey.org for published packages

## Troubleshooting

Common issues and solutions:

1. **API Key errors**: Ensure `CHOCOLATEY_API_KEY` secret is properly configured
2. **Permission errors**: Check repository permissions in Settings
3. **Package validation errors**: Review the AU module configuration in `update.ps1`
4. **Network errors**: GitHub Actions may have temporary connectivity issues

For detailed logs, check the workflow run details in the Actions tab.