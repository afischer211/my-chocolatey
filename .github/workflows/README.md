# Workflows

Each workflow in this directory checks a package's upstream project daily for a new release
and, if found, builds and publishes the updated Chocolatey package automatically.

| Workflow | Package |
|---|---|
| `update-duplicati.yml` | [Duplicati](../../duplicati/) |
| `update-duplicati-canary.yml` | [Duplicati canary](../../duplicati-canary/) — publishes prerelease versions of the `duplicati` package id |
| `update-joplin.yml` | [Joplin](../../joplin/) |
| `update-qownnotes.yml` | [QOwnNotes](../../qownnotes/) |

All four follow the same steps and share the same setup requirements (a `CHOCOLATEY_API_KEY`
repository secret). See [AUTOMATION.md](../../AUTOMATION.md) at the repository root for the
full schedule, process details, and troubleshooting.
