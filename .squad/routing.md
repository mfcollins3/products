# Work Routing

How to decide who handles what on Naked Products.

## Routing Table

| Work Type | Route To | Examples |
|-----------|----------|----------|
| Architecture, scope, ADR approval, cross-cutting decisions | Dallas | "Should we use simple-git or shell out to git?", scope debates, ADR review |
| GitHub API, gh CLI, git operations, repo/issue/project creation | Parker | PROD-005, PROD-007, PROD-008, PROD-009, PROD-010, PROD-015 |
| Workflow orchestration, session persistence, CLI commands (Pastel) | Parker | PROD-004, PROD-017, PROD-019 |
| TUI components, Ink rendering, keyboard input, terminal UX | Lambert | PROD-003, chat scrollback, streaming display |
| GitHub Copilot SDK, prompts, agent conversation logic | Ash | PROD-006 (PRD gen), PROD-011, PROD-012, PROD-013, PROD-014, PROD-018 |
| Tests, test strategy, edge cases, packaging install verification | Ripley | All test authoring; reviews testability |
| CI/CD, packaging (.msi/.pkg/.deb/.rpm), containers, releases | Brett | PROD-001, PROD-002, all GitHub Actions workflows |
| README, CONTRIBUTING, ADR authoring, user docs, privacy policy | Kane | docs/, ADRs in `Proposed` status, release notes |
| Code review (cross-cutting) | Dallas | Architectural reviews |
| Code review (within domain) | Domain owner | Parker reviews backend; Lambert reviews TUI; etc. |
| Session logging, decision merging | Scribe | Automatic — never needs routing |
| Work queue / backlog monitoring | Ralph | "Ralph, go", board status checks |

## Anticipatory Pairing

When the trigger task lands, spawn the listed agents alongside in parallel.

| Trigger | Spawn alongside (background) |
|---------|------------------------------|
| Parker building a feature with defined acceptance criteria | Ripley (writes test cases from criteria) |
| Ash designing a new prompt | Ripley (writes golden tests for prompt structure) |
| Lambert building a new TUI screen | Ripley (component tests via ink-testing-library) |
| Any new user-facing feature shipping | Kane (drafts docs/release-note entry) |
| Any new ADR-worthy decision arises in conversation | Kane (drafts the ADR in `Proposed`) |
| Any change to packaging or runtime requirements | Brett (updates CI matrix, package manifests) |

## Issue Routing

| Label | Action | Who |
|-------|--------|-----|
| `squad` | Triage: analyze issue, assign `squad:{member}` label | Dallas |
| `squad:dallas` | Architecture, scope, or review issue | Dallas |
| `squad:parker` | Backend / GitHub API / CLI / orchestration issue | Parker |
| `squad:lambert` | TUI / Ink / terminal UX issue | Lambert |
| `squad:ash` | Copilot SDK / prompt / template issue | Ash |
| `squad:ripley` | Test / QA issue | Ripley |
| `squad:brett` | CI / packaging / release / container issue | Brett |
| `squad:kane` | Docs / ADR / README / CONTRIBUTING issue | Kane |

### How Issue Assignment Works

1. When a GitHub issue gets the `squad` label, **Dallas** triages — analyzing content, assigning the right `squad:{member}` label, and commenting triage notes.
2. When a `squad:{member}` label is applied, that member picks it up in their next session.
3. Members can reassign by removing their label and adding another member's label.
4. The bare `squad` label is the "inbox" — untriaged issues waiting for Dallas.

## Rules

1. **Eager by default** — spawn all agents who could usefully start work, including anticipatory downstream work (see table above).
2. **Scribe always runs** after substantial work, always as `mode: "background"`.
3. **Quick facts → coordinator answers directly.** Don't spawn an agent for "what's our Node version?".
4. **When two agents could handle it**, pick the one whose domain is the primary concern.
5. **"Team, ..." → fan-out.** Spawn all relevant agents in parallel as `mode: "background"`.
6. **Respect the existing ADRs (0001–0014).** They are approved decisions — don't re-litigate without reason.
7. **Reviewer rejection lockout is strict.** If Dallas or Ripley rejects work, the original author cannot self-revise.
# Work Routing

How to decide who handles what.

## Routing Table

| Work Type | Route To | Examples |
|-----------|----------|----------|
| {domain 1} | {Name} | {example tasks} |
| {domain 2} | {Name} | {example tasks} |
| {domain 3} | {Name} | {example tasks} |
| Code review | {Name} | Review PRs, check quality, suggest improvements |
| Testing | {Name} | Write tests, find edge cases, verify fixes |
| Scope & priorities | {Name} | What to build next, trade-offs, decisions |
| Session logging | Scribe | Automatic — never needs routing |

## Issue Routing

| Label | Action | Who |
|-------|--------|-----|
| `squad` | Triage: analyze issue, assign `squad:{member}` label | Lead |
| `squad:{name}` | Pick up issue and complete the work | Named member |

### How Issue Assignment Works

1. When a GitHub issue gets the `squad` label, the **Lead** triages it — analyzing content, assigning the right `squad:{member}` label, and commenting with triage notes.
2. When a `squad:{member}` label is applied, that member picks up the issue in their next session.
3. Members can reassign by removing their label and adding another member's label.
4. The `squad` label is the "inbox" — untriaged issues waiting for Lead review.

## Rules

1. **Eager by default** — spawn all agents who could usefully start work, including anticipatory downstream work.
2. **Scribe always runs** after substantial work, always as `mode: "background"`. Never blocks.
3. **Quick facts → coordinator answers directly.** Don't spawn an agent for "what port does the server run on?"
4. **When two agents could handle it**, pick the one whose domain is the primary concern.
5. **"Team, ..." → fan-out.** Spawn all relevant agents in parallel as `mode: "background"`.
6. **Anticipate downstream work.** If a feature is being built, spawn the tester to write test cases from requirements simultaneously.
7. **Issue-labeled work** — when a `squad:{member}` label is applied to an issue, route to that member. The Lead handles all `squad` (base label) triage.
