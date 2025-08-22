# my-chocolatey
This repository contains misc install-packages for chocolatey (www.chocolatey.org).

## Automated Updates

This repository includes GitHub Actions workflows for automatically updating packages:

- **QOwnNotes**: Automatically checks for new releases daily and updates the package on Chocolatey.org

## Manual Updates

You can still manually update packages using the PowerShell AU (Automatic Updater) module:

```powershell
cd qownnotes
.\update.ps1
```

## Setup for Automation

To enable automatic publishing to Chocolatey.org, configure the `CHOCOLATEY_API_KEY` secret in your GitHub repository settings.
