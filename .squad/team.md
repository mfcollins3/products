# Squad Team

> Naked Products — AI agent-driven tool for managing software products. TUI/CLI built with Node.js 24, TypeScript, Ink, Pastel, and the GitHub Copilot SDK.

## Coordinator

| Name | Role | Notes |
|------|------|-------|
| Squad | Coordinator | Routes work, enforces handoffs and reviewer gates. |

## Members

| Name | Role | Charter | Status |
|------|------|---------|--------|
| 🏗️ Dallas | Lead / Architect | [.squad/agents/dallas/charter.md](.squad/agents/dallas/charter.md) | Active |
| 🔧 Parker | Core/Backend Dev | [.squad/agents/parker/charter.md](.squad/agents/parker/charter.md) | Active |
| ⚛️ Lambert | TUI Dev | [.squad/agents/lambert/charter.md](.squad/agents/lambert/charter.md) | Active |
| 🤖 Ash | Copilot SDK Specialist | [.squad/agents/ash/charter.md](.squad/agents/ash/charter.md) | Active |
| 🧪 Ripley | Tester | [.squad/agents/ripley/charter.md](.squad/agents/ripley/charter.md) | Active |
| ⚙️ Brett | DevOps | [.squad/agents/brett/charter.md](.squad/agents/brett/charter.md) | Active |
| 📝 Kane | DevRel / Docs | [.squad/agents/kane/charter.md](.squad/agents/kane/charter.md) | Active |
| 📋 Scribe | Session Logger | [.squad/agents/scribe/charter.md](.squad/agents/scribe/charter.md) | Active (silent) |
| 🔄 Ralph | Work Monitor | [.squad/agents/ralph/charter.md](.squad/agents/ralph/charter.md) | Active (monitor) |

## Project Context

- **Project:** Naked Products
- **Owner:** Michael Collins
- **Created:** 2026-04-21
- **Repo:** mfcollins3/products
- **PRD:** [docs/prd.md](docs/prd.md)
- **ADRs:** [docs/adrs/](docs/adrs/)

### Stack

- Node.js 24.15.0 (ADR-0001)
- TypeScript 6.0
- [Ink](https://github.com/vadimdemedes/ink) — TUI (ADR-0003)
- [Pastel](https://github.com/vadimdemedes/pastel) — CLI (ADR-0004)
- [GitHub Copilot SDK](https://github.com/github/copilot-sdk) — AI agent (ADR-0002)
- [pino](https://getpino.io/) — structured logging (ADR-0006)
- GitHub Actions — CI/CD (ADR-0014)
- Distroless container base (ADR-0009)

### Supported platforms

- macOS (x64, ARM64)
- Linux (x64/AMD64, ARM64)
- Windows (x64/AMD64, ARM64)

### Distribution

- Native packages: `.msi`, `.pkg`, `.deb`, `.rpm` (ADR-0008)
- Homebrew tap: `mfcollins3/tap`
- WinGet manifest
- Container image: `ghcr.io/mfcollins3/nakedproducts` (multi-arch, distroless)
# Squad Team

> product

## Coordinator

| Name | Role | Notes |
|------|------|-------|
| Squad | Coordinator | Routes work, enforces handoffs and reviewer gates. |

## Members

| Name | Role | Charter | Status |
|------|------|---------|--------|

## Project Context

- **Project:** product
- **Created:** 2026-04-20
