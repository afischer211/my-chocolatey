**AFISCHER211'S PACKAGE NOTES (BETA CHANNEL):**

* This package tracks Duplicati's **beta** channel: builds promoted from canary for wider
  testing before they become the next stable release. See the main
  [Duplicati package](../duplicati/) for stable, or [Duplicati (canary)](../duplicati-canary/)
  for the more frequent, less-tested canary channel.
* This package publishes **prerelease versions of the same `duplicati` package id** used by
  the stable and canary packages - it is not a separate package id. Install with
  `choco install duplicati --pre`, or pin an exact version with
  `choco install duplicati --version <version>-beta`.
* Installing this **replaces** any existing stable or canary Duplicati install: all Duplicati
  Windows builds share the same MSI upgrade code and cannot be installed side by side.
* Why no separate `duplicati-beta` package id? See
  [CONTRIBUTING.md](../CONTRIBUTING.md#exception-duplicati-canary-and-duplicati-beta-share-a-package-id-with-duplicati)
  (the same reasoning applies to beta as to canary).

***

If applicable, please always consider donating or purchasing the software you installed - including [Chocolatey's licensed editions](https://chocolatey.org/pricing).

<h3>TIA,</h3>

<h3>Alexander</h3>
