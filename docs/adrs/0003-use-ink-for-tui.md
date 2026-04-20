# Use Ink for the TUI Framework

* Status: Proposed
* Date: 2026-04-20

## Context and Problem Statement

Naked Products requires a rich terminal user interface (TUI) to render a
conversational chat interface with scrollable history, real-time streaming
responses, and interactive input. The TUI must work on macOS, Linux, and
Windows terminal emulators.

Building a TUI with raw ANSI escape codes and `readline` is error-prone
and difficult to maintain. A higher-level TUI framework is needed that
supports composable UI components, state management, and cross-platform
terminal rendering.

## Decision Drivers

* Ink has been adopted by well-known AI agent terminal applications —
  Claude Code and the GitHub Copilot CLI — validating it as the standard
  framework for this class of tool.
* The framework must support real-time streaming updates as the AI
  generates response tokens.
* The framework must work on all supported platforms (macOS, Linux,
  Windows).
* The framework must be compatible with the Node.js 24 + TypeScript
  ecosystem from [ADR-0001](0001-use-nodejs-24-and-typescript.md).
* The CLI framework Pastel (see
  [ADR-0004](0004-use-pastel-for-cli.md)) is built specifically for Ink,
  so the two frameworks must be compatible.

## Considered Options

* Ink
* blessed / neo-blessed
* terminal-kit
* Custom implementation with chalk + readline

## Decision Outcome

Chosen option: "Ink", because it is the TUI framework used by Claude Code
and the GitHub Copilot CLI — two widely-used AI agent terminal applications
that share the same problem domain as Naked Products. This prior art
strongly validates Ink as the right foundation. It is also the only
framework that integrates natively with the Pastel CLI framework chosen in
ADR-0004.

### Consequences

* Good, because Claude Code and the GitHub Copilot CLI have proven that
  Ink is a capable foundation for AI agent terminal applications.
* Good, because React's component model and hooks make it straightforward
  to build and maintain a composable TUI.
* Good, because Ink's render loop handles terminal resizing and
  cross-platform output automatically.
* Good, because Ink is widely adopted with a strong ecosystem of
  community components.
* Good, because Pastel is built by the same author and integrates
  seamlessly with Ink components.
* Neutral, because developers must be familiar with React concepts
  (components, state, hooks) to contribute to the TUI code.
* Bad, because Ink's performance may be limited for very complex UIs,
  though the conversational interface for Naked Products is not complex
  enough to hit these limits.

## Pros and Cons of the Options

### Ink

* Good, because it is used by Claude Code and the GitHub Copilot CLI,
  providing strong real-world validation for AI agent terminal tools.
* Good, because it uses React, which is the most widely understood
  component model in the JavaScript ecosystem.
* Good, because it handles complex terminal interactions (cursor
  management, screen clearing) automatically.
* Good, because it supports `useInput` for keyboard handling and
  streaming updates via state changes.
* Good, because it is maintained by the same author as Pastel.
* Bad, because React's virtual DOM adds some overhead compared to
  imperative terminal rendering.

### blessed / neo-blessed

* Good, because blessed is a mature and feature-rich curses-inspired
  TUI library.
* Bad, because blessed uses an imperative API that is harder to maintain
  than React's declarative model.
* Bad, because neo-blessed (the maintained fork) has less community
  activity than Ink.
* Bad, because blessed is not compatible with Pastel.

### terminal-kit

* Good, because terminal-kit has comprehensive terminal control
  capabilities.
* Bad, because it uses an imperative API.
* Bad, because it does not have a component model, requiring significant
  manual state management.
* Bad, because it is not compatible with Pastel.

### Custom implementation with chalk + readline

* Good, because it has no external framework dependency.
* Bad, because it requires significant effort to implement scrolling,
  word wrapping, and real-time updates correctly.
* Bad, because it is error-prone on Windows where ANSI support varies.
* Bad, because it cannot leverage the Pastel CLI framework.

## More Information

* [Ink GitHub repository](https://github.com/vadimdemedes/ink)
* [Ink documentation and examples](https://github.com/vadimdemedes/ink#readme)
* [Pastel (built for Ink)](https://github.com/vadimdemedes/pastel)
