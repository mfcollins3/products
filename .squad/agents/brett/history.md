# Project Context

- **Owner:** Michael Collins
- **Project:** Naked Products — TUI/CLI distributed via .msi/.pkg/.deb/.rpm, Homebrew, WinGet, and ghcr.io distroless container. CI/CD via GitHub Actions (ADR-0014).
- **Stack:** Node.js 24.15.0, TypeScript 6.0, Ink (TUI), Pastel (CLI), GitHub Copilot SDK, pino (logging)
- **Created:** 2026-04-21

## Learnings

<!-- Append new learnings below. -->

### 2026-04-21 — PROD-001 Release Infrastructure

- Node.js SEA injection requires removing the pre-existing signature on
  macOS (`codesign --remove-signature`) and Windows
  (`signtool remove /s`) before running `postject`.
- `xcrun stapler staple` does not work on raw Mach-O binaries — only on
  `.app`, `.dmg`, and `.pkg`. Binary notarization (notarytool submit)
  is sufficient; the ticket lives on Apple's servers.
- `pkgbuild --install-location /` with a `pkg-root/usr/local/bin/`
  staging tree maps the binary cleanly to `/usr/local/bin` on the
  target machine.
- WiX v4 uses `StandardDirectory` instead of the `Directory Id=`
  approach from v3. Cross-arch MSI compilation works via `-arch arm64`
  on an x64 runner.
- Homebrew formulae cannot `bin.install` from a `.pkg` URL — the
  install block assumes a plain binary or an extractable archive. A
  tarball or a Homebrew **cask** is needed for `.pkg` distribution.
  Filed as a known gap in the current formula template.
- For reusable workflows called with a matrix, `secrets: inherit` at
  the call site is the cleanest way to pass signing secrets without
  re-declaring them in the reusable workflow's `secrets:` block.
- `security find-identity -v -p codesigning` is more robust than
  hardcoding the full identity string for `codesign --sign`.
- Azure Function App keys should be passed via `x-functions-key` HTTP
  header for the winget-cli-restsource API.
- The WiX UpgradeCode placeholder GUID must be replaced with a real
  GUID before shipping — document this prominently.
