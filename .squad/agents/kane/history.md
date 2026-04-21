# Project Context

- **Owner:** Michael Collins
- **Project:** Naked Products — TUI/CLI for product initialization. Docs include README, CONTRIBUTING, ADRs (MADR 3.0 per ADR-0013), getting-started, command reference, privacy policy.
- **Stack:** Node.js 24.15.0, TypeScript 6.0, Ink (TUI), Pastel (CLI), GitHub Copilot SDK, pino (logging)
- **Created:** 2026-04-21

## Learnings

<!-- Append new learnings below. -->

## Learnings

### 2026-04-21: PRD v1.0 review edits
Applied six decisions from Michael's PRD risk review to `docs/prd.md`:
- Set v1.0.0 release date to 2026-09-01.
- PROD-002: clarified distroless build copies static `git`/`gh`/Copilot CLI
  binaries from builder stages; linked ADR-0009; added pin-and-bot note.
- PROD-005: enumerated required `gh` token scopes (`repo`, `project`,
  `read:org`; `admin:org` only for PROD-015); noted `X-OAuth-Scopes` header
  for scope detection.
- PROD-007: replaced auto-stack-detection with explicit user prompt; sourced
  templates from `github/gitignore`.
- PROD-020: replaced direct GA4 calls with telemetry-relay design (forward
  ADR-0015); marked priority as may-slip-to-v1.0.1.
- Pattern: when a decision has an ADR, link to it in the PRD instead of
  restating — keeps PRD focused on "what" and ADRs on "why".
