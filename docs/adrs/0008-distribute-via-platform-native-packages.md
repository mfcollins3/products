# Distribute via Platform-Native Packages

* Status: Proposed
* Date: 2026-04-20

## Context and Problem Statement

Naked Products is a developer tool that must be easy to install on macOS,
Linux, and Windows. The installation experience should feel native to each
platform, require no manual Node.js installation, and integrate with the
platform's package management tools (Homebrew, WinGet) for easy updates.

The distribution strategy defines how users discover, install, update, and
remove the application on each supported platform.

## Decision Drivers

* Users should be able to install Naked Products without first installing
  Node.js; the Node.js runtime should be bundled.
* Installation must integrate with native package managers (Homebrew,
  WinGet, apt/dnf) where possible for seamless updates.
* All packages must support both x64 and ARM64 architectures on each
  platform.
* Package artifacts must be published to GitHub Releases with SHA-256
  checksums for verification.
* The distribution method must be automatable via GitHub Actions.

## Considered Options

* Platform-native packages (.msi, .pkg, .deb, .rpm) + Homebrew + WinGet
* npm global install (`npm install -g @mfcollins/products`)
* Single universal installer script
* Container only

## Decision Outcome

Chosen option: "Platform-native packages (.msi, .pkg, .deb, .rpm) +
Homebrew + WinGet", because native packages provide the best per-platform
experience, bundle the Node.js runtime so users do not need to manage it,
and integrate with the package managers developers already use for updates.

### Consequences

* Good, because users can install with familiar tools: `brew install`,
  `winget install`, `apt install`, or `rpm -i`.
* Good, because the bundled Node.js runtime ensures version consistency
  and eliminates runtime version conflicts.
* Good, because SHA-256 checksums on GitHub Releases enable installation
  verification.
* Neutral, because maintaining packaging scripts for four package formats
  (`.msi`, `.pkg`, `.deb`, `.rpm`) plus Homebrew and WinGet manifests
  adds build complexity.
* Bad, because each package format requires platform-specific tooling
  (WiX Toolset, pkgbuild, fpm/dpkg-deb), which increases the CI/CD
  pipeline complexity.

## Pros and Cons of the Options

### Platform-native packages + Homebrew + WinGet

* Good, because it provides the best installation experience on each
  platform.
* Good, because bundling the runtime avoids Node.js version conflicts.
* Good, because Homebrew and WinGet support `upgrade` commands, enabling
  simple updates.
* Bad, because it requires maintaining multiple packaging configurations
  and CI/CD pipeline steps.
* Bad, because native package code signing (Authenticode for Windows,
  Apple Developer ID for macOS) may be required to avoid security
  warnings.

### npm global install

* Good, because it is the simplest distribution mechanism for a Node.js
  tool.
* Good, because it works on all platforms where Node.js is installed.
* Bad, because it requires the user to have Node.js installed and
  managed separately.
* Bad, because `npm install -g` does not integrate with Homebrew, WinGet,
  or system package managers.
* Bad, because the PRD explicitly states the npm package is private
  and not published to the npm registry.

### Single universal installer script

* Good, because a single script reduces packaging complexity.
* Bad, because installer scripts are less trustworthy than signed native
  packages (require `curl | sh` patterns).
* Bad, because installer scripts do not integrate with system package
  managers and do not support easy updates.

### Container only

* Good, because a single container image runs on all platforms with
  Docker installed.
* Bad, because using a CLI tool via `docker run` is cumbersome compared
  to a native executable.
* Bad, because container distribution alone excludes Windows users who
  may not have Docker Desktop.
* Neutral, because container distribution is provided *in addition to*
  native packages, not as the sole method.

## More Information

* [WiX Toolset (Windows .msi)](https://wixtoolset.org/)
* [pkgbuild (macOS .pkg)](https://www.unix.com/man-page/osx/1/pkgbuild/)
* [fpm (cross-platform .deb/.rpm)](https://fpm.readthedocs.io/)
* [Homebrew tap documentation](https://docs.brew.sh/How-to-Create-and-Maintain-a-Tap)
* [WinGet manifest submission](https://github.com/microsoft/winget-pkgs)
