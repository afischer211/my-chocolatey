# my-chocolatey
This repository contains Chocolatey packages (www.chocolatey.org) that I maintain, each
kept up to date automatically. See a package's own folder for its `readme.md` with
package-specific notes.

## Packages

| Package | What it is | Install |
|---|---|---|
| [Duplicati](duplicati/) | Backup software with encrypted, incremental backups ([source](https://github.com/duplicati/duplicati)) | `choco install duplicati` |
| [Duplicati (canary)](duplicati-canary/) | Duplicati's most frequent, least-tested prerelease channel | `choco install duplicati --pre` |
| [Duplicati (beta)](duplicati-beta/) | Duplicati's beta channel, promoted from canary for wider testing | `choco install duplicati --pre` |
| [Joplin](joplin/) | Open-source note-taking and to-do app with sync ([source](https://github.com/laurent22/joplin)) | `choco install joplin` |
| [QOwnNotes](qownnotes/) | Plain-text markdown notepad and to-do list manager ([source](https://github.com/pbek/QOwnNotes)) | `choco install qownnotes` |

Duplicati (canary) and (beta) publish prerelease *versions* of the same `duplicati`
package id — not separate packages — so `--pre` is what selects them; see
[CONTRIBUTING.md](CONTRIBUTING.md#exception-duplicati-canary-and-duplicati-beta-share-a-package-id-with-duplicati)
for why.

## Automated Updates

Every package above is checked daily by a GitHub Actions workflow that looks for a new
upstream release and, if found, builds and publishes the updated Chocolatey package
automatically. See [AUTOMATION.md](AUTOMATION.md) for the full schedule and how it works.

## Manual Updates

You can still manually update any package using the PowerShell AU (Automatic Updater) module:

```powershell
cd duplicati   # or duplicati-canary, duplicati-beta, joplin, or qownnotes
.\update.ps1
```

## Setup for Automation

To enable automatic publishing to Chocolatey.org, configure the `CHOCOLATEY_API_KEY` secret in your GitHub repository settings.
