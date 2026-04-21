# Architectural Decision Records

This directory contains the Architectural Decision Records (ADRs) for
Naked Products. ADRs are written using the
[MADR 3.0](https://adr.github.io/madr/) template format.

## ADR Index

| ADR | Title | Status |
| --- | ----- | ------ |
| [0001](0001-use-nodejs-24-and-typescript.md) | Use Node.js 24 LTS and TypeScript | Proposed |
| [0002](0002-use-github-copilot-sdk-for-ai.md) | Use GitHub Copilot SDK for AI | Proposed |
| [0003](0003-use-ink-for-tui.md) | Use Ink for the TUI Framework | Proposed |
| [0004](0004-use-pastel-for-cli.md) | Use Pastel for the CLI Framework | Proposed |
| [0005](0005-delegate-authentication-to-github-cli.md) | Delegate Authentication to the GitHub CLI | Proposed |
| [0006](0006-use-pino-for-structured-logging.md) | Use pino for Structured Logging | Proposed |
| [0007](0007-use-google-analytics-for-telemetry.md) | Use Google Analytics GA4 for Telemetry | Proposed |
| [0008](0008-distribute-via-platform-native-packages.md) | Distribute via Platform-Native Packages | Proposed |
| [0009](0009-use-distroless-container-image.md) | Use Google Distroless as the Container Base Image | Proposed |
| [0010](0010-tui-first-with-cli-commands.md) | TUI-First Interface with Supplementary CLI Commands | Proposed |
| [0011](0011-layered-template-resolution.md) | Use Layered Template Resolution Hierarchy | Proposed |
| [0012](0012-persist-sessions-to-disk.md) | Persist Sessions to Disk | Proposed |
| [0013](0013-use-madr-3-for-adrs.md) | Use MADR 3.0 for Architectural Decision Records | Proposed |
| [0014](0014-use-github-actions-for-ci-cd.md) | Use GitHub Actions for CI/CD | Proposed |
| [0015](0015-use-telemetry-relay-api.md) | Use a Telemetry Relay API to Protect the GA4 Measurement Protocol Secret | Proposed |

## Format

ADRs follow the
[MADR 3.0](https://github.com/adr/madr/tree/3.0.0/template) template:

- **Status**: `Proposed`, `Accepted`, `Deprecated`, or
  `Superseded by ADR-XXXX`
- **Context and Problem Statement**: What problem prompted this decision?
- **Decision Drivers**: Forces or concerns that shaped the decision
- **Considered Options**: Alternatives that were evaluated
- **Decision Outcome**: The chosen option and the rationale
- **Consequences**: Trade-offs of the chosen option
- **Pros and Cons of the Options**: Detailed evaluation of each option
