# Adding a new package

This repo has three packages (`duplicati/`, `joplin/`, `qownnotes/`), each with an
AU-based (`update.ps1`) auto-updater and a near-identical GitHub Actions workflow that
runs it daily. Use an existing package as your template rather than starting from
scratch — pick the one closest to what you're packaging.

## 1. Package folder

Create `<package>/` with:
- `<package>.nuspec` — metadata; base it on an existing one (see `duplicati/duplicati.nuspec` for a minimal example, `qownnotes/qownnotes.nuspec` for one with a longer description).
- `tools/chocolateyinstall.ps1` (and `chocolateyuninstall.ps1` if the app needs explicit uninstall logic) — note the casing of `chocolateyinstall.ps1` isn't consistent across existing packages (`duplicati`/`joplin` use lowercase, `qownnotes` uses `chocolateyInstall.ps1`); match whichever convention, just be consistent within your package and make sure the `git add` line in your new workflow's "Commit changes" step uses the exact filename you chose.
- `legal/LICENSE.txt` and `legal/VERIFICATION.txt`.
- `update.ps1` — the AU update script that checks upstream for a new version and rewrites the files above.
- `readme.md` (optional but recommended) — package-specific notes, maintainer credit, links. See `duplicati/readme.md`, `joplin/readme.md`, or `qownnotes/readme.md` for the format.

## 2. Workflow

Copy an existing workflow (e.g. `.github/workflows/update-qownnotes.yml`) to
`.github/workflows/update-<package>.yml` and adjust:
- `name:`, job id, and `cron:` schedule — pick a time that doesn't collide with the existing three (`0 6`, `30 6`, `0 7` UTC); leave a gap of at least 15–30 minutes.
- `working-directory:` and file paths (`.nuspec`, install script) in every step.
- The `git add` line in "Commit changes and create tag" — list the exact metadata files your package's `update.ps1` modifies.
- Keep the `Install-WithRetry` wrapper around `Install-PackageProvider` / `Install-Module -Name Chocolatey-AU` as-is — it exists to absorb transient PowerShell Gallery failures (see [AUTOMATION.md](AUTOMATION.md#transient-powershell-gallery-failures)). Don't drop it when copying.
- Pick a tagging strategy (delete-and-recreate like Duplicati, or force-move like Joplin/QOwnNotes) — either is fine, but know that force-pushing a tag rewrites history if reused. See [AUTOMATION.md](AUTOMATION.md#tagging-behavior-differs-slightly-between-workflows).

## 3. Docs to update

- `README.md` — add a row to the Packages table.
- `AUTOMATION.md` — add a row to the Schedule table and a row to the Files Modified by Automation table.
- `.github/workflows/README.md` — add a row to the workflow table.

## 4. Verify

- Validate the workflow YAML (`ruby -ryaml -e "YAML.load_file('.github/workflows/update-<package>.yml')"` or any YAML linter).
- Trigger the workflow manually (`workflow_dispatch`) once and confirm it either publishes correctly or exits cleanly with "No updates available" — don't wait for the schedule to find out it's broken.

## Exception: `duplicati-canary/` shares a package id with `duplicati/`

Every other package folder in this repo maps one-to-one to a distinct Chocolatey package id
matching the folder name. `duplicati-canary/` is a deliberate exception: its nuspec declares
`<id>duplicati</id>` (the same id as the stable `duplicati/` package), and it publishes
prerelease *versions* of that id (e.g. `2.3.0.106-canary`) rather than a separate
`duplicati-canary` id.

This is required, not a shortcut — see
[`docs/superpowers/specs/2026-07-03-duplicati-canary-design.md`](docs/superpowers/specs/2026-07-03-duplicati-canary-design.md)
for the full reasoning. In short: Chocolatey moderation rule CPMR0024 forbids channel names
in package ids, and Duplicati's canary/stable Windows installers share an MSI upgrade code
and cannot be installed side by side anyway, so a separate package id would be both
non-compliant and misleading.

If you're adding a similar prerelease-channel package for another piece of software in this
repo, check whether the same constraints apply (does the vendor's installer actually support
side-by-side install of the two channels?) before copying this pattern or defaulting to a
separate package id.
