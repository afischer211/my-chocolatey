# my-chocolatey
This repository contains misc install-packages for chocolatey (www.chocolatey.org).

## Packages

| Package | Source |
|---|---|
| [Duplicati](duplicati/) | [duplicati/duplicati](https://github.com/duplicati/duplicati) |
| [Duplicati (canary)](duplicati-canary/) | [duplicati/duplicati](https://github.com/duplicati/duplicati) — publishes prerelease versions of the `duplicati` package id; install with `choco install duplicati --pre` |
| [Joplin](joplin/) | [laurent22/joplin](https://github.com/laurent22/joplin) |
| [QOwnNotes](qownnotes/) | [pbek/QOwnNotes](https://github.com/pbek/QOwnNotes) |

## Automated Updates

Every package above is checked daily by a GitHub Actions workflow that looks for a new
upstream release and, if found, builds and publishes the updated Chocolatey package
automatically. See [AUTOMATION.md](AUTOMATION.md) for the full schedule and how it works.

## Manual Updates

You can still manually update any package using the PowerShell AU (Automatic Updater) module:

```powershell
cd duplicati   # or duplicati-canary, joplin, or qownnotes
.\update.ps1
```

## Setup for Automation

To enable automatic publishing to Chocolatey.org, configure the `CHOCOLATEY_API_KEY` secret in your GitHub repository settings.
