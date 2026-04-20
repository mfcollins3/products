# TUI-First Interface with Supplementary CLI Commands

* Status: Proposed
* Date: 2026-04-20

## Context and Problem Statement

Naked Products guides users through a complex, multi-step product
initialization workflow. This workflow involves gathering information,
making decisions, and executing actions that depend on earlier steps. The
interaction model — how the user drives the application — has a significant
impact on usability, implementation complexity, and the degree to which
the AI agent can provide guidance.

Two primary interaction models are possible: a conversational TUI where the
agent guides the user through the workflow, and a CLI where discrete commands
perform individual setup tasks.

## Decision Drivers

* The product's core design principle is "conversational over configuration":
  the agent should guide users rather than requiring them to know upfront
  what commands to run.
* Some users will want to run a single task (e.g., create an ADR) without
  entering a full conversational session.
* The TUI and CLI must share the same Ink rendering primitives to avoid
  maintaining two separate output systems (see
  [ADR-0003](0003-use-ink-for-tui.md) and
  [ADR-0004](0004-use-pastel-for-cli.md)).
* The application should provide standard CLI conventions (`--help`,
  exit codes, stdout/stderr) for scriptability.

## Considered Options

* TUI-first with supplementary CLI commands
* CLI-only (commands for each workflow step)
* TUI-only (no CLI commands)
* Dual-mode (independent TUI and CLI, separate codebases)

## Decision Outcome

Chosen option: "TUI-first with supplementary CLI commands", because the
conversational TUI is the primary and most capable interaction model, while
supplementary CLI commands allow discrete tasks to be scripted or run
without entering the full TUI. Both modes share the same Ink rendering
and business logic.

```plain
┌──────────────────────────────────────────────────────────────────┐
│  nakedproducts (no args)                                         │
│                                                                  │
│  ┌────────────────────────────────────────────────────────────┐  │
│  │  AI Agent TUI (Ink)                                        │  │
│  │  ┌──────────────────────────────────────────────────────┐  │  │
│  │  │ Conversation History                                 │  │  │
│  │  └──────────────────────────────────────────────────────┘  │  │
│  │  > User input                                              │  │
│  └────────────────────────────────────────────────────────────┘  │
└──────────────────────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────────────────────┐
│  nakedproducts <command> [flags]                                  │
│                                                                  │
│  Discrete CLI commands (Pastel / Ink)                            │
│  e.g. nakedproducts init, nakedproducts adr create               │
└──────────────────────────────────────────────────────────────────┘
```

### Consequences

* Good, because the conversational TUI is the most capable mode: the agent
  can ask follow-up questions, provide guidance, and handle complex
  multi-step workflows.
* Good, because CLI commands allow power users and scripts to invoke
  individual steps non-interactively.
* Good, because both modes share Ink rendering and the same business logic,
  avoiding duplication.
* Neutral, because designing the TUI and CLI to share logic requires
  careful separation of concerns between the presentation and domain layers.
* Bad, because the dual-mode approach requires testing both interaction
  paths for each feature.

## Pros and Cons of the Options

### TUI-first with supplementary CLI commands

* Good, because the TUI provides the richest, most guided experience
  for the primary persona (solo developer unfamiliar with best practices).
* Good, because CLI commands cover the secondary use case (scripting,
  quick individual tasks) without sacrificing the conversational model.
* Good, because shared Ink rendering keeps the codebase DRY.
* Bad, because the TUI is not suitable for fully automated/headless
  environments.

### CLI-only

* Good, because CLI commands are easy to script and automate.
* Good, because the implementation is simpler (no TUI state management).
* Bad, because a CLI requires the user to know which commands to run and
  in what order, violating the "conversational over configuration"
  principle.
* Bad, because CLI flags cannot capture the nuance of a multi-turn
  conversation for complex decisions.

### TUI-only

* Good, because it focuses all effort on the conversational experience.
* Bad, because it excludes power users who want to run single commands
  non-interactively.
* Bad, because it is not scriptable, limiting integration into developer
  workflows.

### Dual-mode (independent TUI and CLI)

* Good, because each mode can be optimized independently.
* Bad, because it duplicates business logic between two codebases,
  increasing maintenance burden.
* Bad, because inconsistencies between the two modes would degrade the
  user experience.

## More Information

* Design principle "Conversational over configuration" — PRD §3.1
* Ink TUI framework: [ADR-0003](0003-use-ink-for-tui.md)
* Pastel CLI framework: [ADR-0004](0004-use-pastel-for-cli.md)
