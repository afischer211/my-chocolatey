# Automated Package Updates

This directory contains GitHub Actions workflows for automatically updating Chocolatey packages in this repository.

## QOwnNotes Update Workflow

The `update-qownnotes.yml` workflow automatically checks for new versions of QOwnNotes and updates the Chocolatey package accordingly.

### Features

- **Scheduled Updates**: Runs daily at 6:00 AM UTC
- **Manual Triggering**: Can be manually triggered via GitHub Actions UI
- **Automatic Version Detection**: Uses the existing `update.ps1` script with AU module
- **Package Validation**: Builds and validates the package before pushing
- **Chocolatey.org Publishing**: Automatically pushes updated packages to Chocolatey.org
- **Git Integration**: Commits changes and creates version tags

### Setup Requirements

To use this workflow, you need to configure the following GitHub repository secret:

- `CHOCOLATEY_API_KEY`: Your Chocolatey.org API key for pushing packages

### How it Works

1. The workflow runs on a schedule or manual trigger
2. It installs the AU (Automatic Updater) PowerShell module
3. Runs the existing `update.ps1` script in the qownnotes folder
4. If changes are detected:
   - Builds the .nupkg file using `choco pack`
   - Validates the package
   - Pushes to Chocolatey.org using the API key
   - Commits changes to the repository
   - Creates a version tag

### Manual Execution

You can manually trigger the workflow from the GitHub Actions tab in your repository by clicking "Run workflow" on the "Update QOwnNotes Package" workflow.