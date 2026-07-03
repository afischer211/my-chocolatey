**AFISCHER211'S PACKAGE NOTES (CANARY CHANNEL):**

* This package tracks Duplicati's **canary** channel: frequent, less-tested builds published
  between stable releases. See the main [Duplicati package](../duplicati/) for the stable
  channel.
* This package publishes **prerelease versions of the same `duplicati` package id** used by
  the stable package - it is not a separate package id. Install with
  `choco install duplicati --pre`, or pin an exact version with
  `choco install duplicati --version <version>-canary`.
* Installing this **replaces** any existing stable Duplicati install: canary and stable
  builds share the same MSI upgrade code and cannot be installed side by side.
* Why no separate `duplicati-canary` package id? See
  [CONTRIBUTING.md](../CONTRIBUTING.md#exception-duplicati-canary-and-duplicati-beta-share-a-package-id-with-duplicati).

***

If applicable, please always consider donating or purchasing the software you installed - including [Chocolatey's licensed editions](https://chocolatey.org/pricing).

<h3>TIA,</h3>

<h3>Alexander</h3>
