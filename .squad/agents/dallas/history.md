# Project Context

- **Owner:** Michael Collins
- **Project:** Naked Products — AI agent-driven tool for managing software products. Helps with starting new products/releases, generating PRDs, and loading features into GitHub Issues and Projects. TUI/CLI installed on developer computers.
- **Stack:** Node.js 24.15.0, TypeScript 6.0, Ink (TUI), Pastel (CLI), GitHub Copilot SDK, pino (logging)
- **Created:** 2026-04-21

## Learnings

<!-- Append new learnings below. Each entry is something lasting about the project. -->

### 2026-04-21: PRD review (v1.0) — first pass
- PRD has 20 reqs (PROD-001..020) and 14 already-approved ADRs. Treat ADRs as binding scope when reviewing — don't relitigate (e.g., distroless, GA4, gh auth) unless raising a real risk.
- Distroless + bundled `git`/`gh`/Copilot CLI is a known sharp edge: distroless has no shell, no apt. Adding three CLI binaries means either (a) custom multi-stage that copies static binaries in, or (b) pick a non-distroless base. PRD currently asserts both, which is in tension. Open question #2 in the PRD already flags this.
- `gh auth token` does not surface scopes. PROD-005 says "validate the token has the required scopes" but the scopes themselves are never enumerated. Need a concrete list (repo, project, admin:org for teams, write:packages?) and a way to detect missing scopes (call `/user` with token and read `X-OAuth-Scopes`).
- PROD-017 (sessions) and PROD-019 (workflow orchestration) are coupled — workflow state machine is persisted in the session. Treat as one design surface.
- PROD-018 (org-level templates from `.naked-products` org repo) is a hidden dep on org perms + adds GitHub API surface area. Watch for scope creep into v1.0.
- GA4 from a CLI is non-trivial: Measurement Protocol requires API secret + measurement ID baked into the binary (or fetched). Need a story for secret rotation and for offline / corporate-proxy users.
- ADR-0009 (distroless) and PROD-002 acceptance "image includes git, gh, Copilot CLI" need a follow-up ADR or amendment documenting HOW (static binaries copied in).
- PRD has no acceptance criteria for the agent's *conversational quality* — no measurable bar for "good enough" PRD/ADR/CONTRIBUTING output. Hard to test without one.
- No CODEOWNERS / license / template **schema validation** specified. Generated artifacts could be invalid.
- v1.0 release date is "TBD" — no scope deadline pressure documented, but also no explicit MVP cut.
