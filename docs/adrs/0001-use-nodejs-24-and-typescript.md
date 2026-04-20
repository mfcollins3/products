# Use Node.js 24 LTS and TypeScript

* Status: Proposed
* Date: 2026-04-20

## Context and Problem Statement

Naked Products is a terminal-based application that must be distributed as
platform-native packages on Windows, macOS, and Linux. The choice of runtime
and language determines the ecosystem of available libraries, the quality of
tooling, the ease of packaging, and the long-term maintainability of the
codebase.

The GitHub Copilot SDK — the required AI integration for Naked Products — is
compatible with multiple runtimes including Node.js, Go, and Rust. The choice
of runtime is therefore driven by the broader ecosystem, tooling, and packaging
requirements of the application.

## Decision Drivers

* The runtime must be compatible with the GitHub Copilot SDK.
* Development speed and ecosystem maturity matter; a large library ecosystem
  reduces the amount of code the team must write from scratch.
* The TUI framework and prior art in the space should inform the choice;
  well-known AI agent tools (Claude Code, GitHub Copilot CLI) have been built
  with Ink, validating the approach.
* The application will be distributed as platform-native packages that bundle
  the runtime, so the runtime must be well-supported for packaging tools.
* Type safety reduces defects and improves developer productivity for a
  maintainable, evolving codebase.
* Long-term stability is critical for a distributed tool used in production
  developer workflows.

## Considered Options

* Node.js 24 LTS with TypeScript
* Node.js 22 LTS with TypeScript
* Deno with TypeScript
* Bun with TypeScript
* Go
* Rust

## Decision Outcome

Chosen option: "Node.js 24 LTS with TypeScript", because the Node.js/npm
ecosystem provides the fastest path to a production-quality application, the
Ink TUI framework has been validated by Claude Code and the GitHub Copilot
CLI, and TypeScript adds type safety without introducing a new runtime. The
GitHub Copilot SDK is compatible with Node.js.

### Consequences

* Good, because Node.js 24 LTS provides a stable, well-supported runtime
  with a long support window suitable for packaged distributions.
* Good, because TypeScript's static type checking catches errors at compile
  time and improves IDE support and developer productivity.
* Good, because the Node.js ecosystem has mature tooling for packaging
  applications as `.msi`, `.pkg`, `.deb`, and `.rpm` packages.
* Good, because the Ink TUI framework was used to build Claude Code and the
  GitHub Copilot CLI, providing strong validation that it is the right
  foundation for AI agent terminal applications.
* Neutral, because bundling the Node.js runtime into platform-native
  packages increases package size, though this is acceptable for a
  developer tool.
* Bad, because TypeScript adds a compilation step to the development
  workflow, though this is standard practice in the ecosystem.

## Pros and Cons of the Options

### Node.js 24 LTS with TypeScript

* Good, because LTS releases receive security patches and bug fixes for
  an extended period.
* Good, because the npm ecosystem provides a vast library of packages
  for CLI tools, TUI frameworks, and GitHub API clients, maximizing
  development speed.
* Good, because Ink (TUI) and Pastel (CLI) are validated by their use in
  Claude Code and the GitHub Copilot CLI.
* Good, because TypeScript adds type safety, interfaces, and generics
  that improve code quality.
* Bad, because the Node.js runtime adds startup overhead compared to
  native binaries.

### Node.js 22 LTS with TypeScript

* Good, because it is also an active LTS release.
* Bad, because Node.js 24 is the current LTS and will have a longer
  active support window.
* Neutral, because both versions are compatible with the GitHub Copilot
  SDK.

### Deno with TypeScript

* Good, because Deno has first-class TypeScript support without a
  compilation step.
* Good, because Deno has a more secure permission model.
* Bad, because Deno has limited compatibility with Node.js npm packages;
  the GitHub Copilot SDK may not be supported.
* Bad, because Deno's packaging ecosystem for native installers is
  immature.

### Bun with TypeScript

* Good, because Bun is faster than Node.js for startup time.
* Bad, because Bun is not yet at an LTS maturity level suitable for
  packaged production tools.
* Bad, because Bun's compatibility with all npm packages used by the
  GitHub Copilot SDK is not guaranteed.

### Go

* Good, because Go compiles to a single native binary with no runtime
  dependency.
* Good, because Go binaries start up very fast.
* Good, because the GitHub Copilot SDK is compatible with Go.
* Good, because Go has capable TUI (Bubble Tea) and CLI (Cobra) libraries.
* Bad, because Go's TUI ecosystem is less mature than Ink for building
  React-component-model interfaces.
* Bad, because switching to Go would forfeit the prior art and community
  knowledge established by Claude Code and GitHub Copilot CLI.

### Rust

* Good, because Rust compiles to highly optimized native binaries.
* Good, because Rust has strong memory safety guarantees.
* Good, because the GitHub Copilot SDK is compatible with Rust.
* Good, because Rust has capable TUI (Ratatui) and CLI (clap) libraries.
* Bad, because Rust's TUI ecosystem does not follow the React component
  model used by Ink, requiring a different mental model.
* Bad, because Rust's learning curve is significantly higher than
  TypeScript, impacting development velocity.

## More Information

* [Node.js 24 LTS release schedule](https://nodejs.org/en/about/previous-releases)
* [TypeScript documentation](https://www.typescriptlang.org/)
* [GitHub Copilot SDK](https://github.com/github/copilot-sdk)
* [Ink (React for CLIs)](https://github.com/vadimdemedes/ink)
* [Bubble Tea (Go TUI framework)](https://github.com/charmbracelet/bubbletea)
* [Cobra (Go CLI framework)](lhttps://github.com/spf13/cobra)
* [Ratatui (Rust TUI framework)](https://ratatui.rs/)
* [clap (Rust CLI framework)](https://docs.rs/clap/latest/clap/)
