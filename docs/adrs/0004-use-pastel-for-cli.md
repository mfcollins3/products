# Use Pastel for the CLI Framework

* Status: Proposed
* Date: 2026-04-20

## Context and Problem Statement

Naked Products exposes both a primary TUI (conversational interface) and
supplementary CLI commands that users can run non-interactively (see
[ADR-0010](0010-tui-first-with-cli-commands.md)). A CLI framework is
needed to handle command routing, argument parsing, `--help` generation,
and exit code management.

Because the application is built with Ink (see
[ADR-0003](0003-use-ink-for-tui.md)), the CLI framework must be
compatible with Ink components so that command implementations can render
output using the same TUI primitives as the main conversational interface.

## Decision Drivers

* The CLI framework must integrate seamlessly with Ink's React-based
  component rendering.
* The framework must support subcommand routing, flag parsing, and
  automatic `--help` generation.
* The framework must be compatible with the Node.js 24 + TypeScript
  ecosystem from [ADR-0001](0001-use-nodejs-24-and-typescript.md).
* Minimal configuration overhead is preferred; the framework should
  enable commands to be defined as simple React components or modules.

## Considered Options

* Pastel
* Commander.js
* yargs
* oclif

## Decision Outcome

Chosen option: "Pastel", because it is built specifically for Ink by the
same author, allowing CLI commands to be defined as Ink components and
rendered with the full TUI primitive set. This eliminates any integration
layer between the CLI framework and the TUI framework.

### Consequences

* Good, because CLI commands and TUI components share the same rendering
  model, enabling consistent output across interactive and non-interactive
  modes.
* Good, because Pastel uses file-system-based command routing similar to
  Next.js pages, which is easy to understand and extend.
* Good, because there is no impedance mismatch between the CLI layer and
  the Ink rendering layer.
* Neutral, because Pastel is less widely known than Commander.js or yargs,
  which may affect the contributor pool.
* Bad, because Pastel's feature set is narrower than yargs or oclif; if
  advanced CLI features are needed in the future, an alternative may be
  required.

## Pros and Cons of the Options

### Pastel

* Good, because it is built for Ink with native integration.
* Good, because commands are defined as Ink components, enabling rich
  terminal output in non-interactive mode.
* Good, because the file-system-based routing convention reduces
  boilerplate.
* Bad, because it has a smaller community and ecosystem than Commander.js
  or yargs.

### Commander.js

* Good, because it is the most widely used Node.js CLI framework with
  extensive documentation.
* Good, because it supports complex command hierarchies, option groups,
  and validation.
* Bad, because it has no native Ink integration; output would require
  manual adaptation between Commander.js and Ink rendering.
* Bad, because using Commander.js with Ink creates two separate rendering
  pipelines that must be reconciled.

### yargs

* Good, because yargs provides flexible argument parsing with
  middleware support.
* Good, because yargs has an extensive ecosystem and is battle-tested.
* Bad, because yargs has no native Ink integration.
* Bad, because yargs output (help text, error messages) uses its own
  formatting that cannot leverage Ink components.

### oclif

* Good, because oclif is a mature CLI framework with plugin support,
  command lifecycle hooks, and strong TypeScript support.
* Good, because it is used in production by major products like the
  Heroku and Salesforce CLIs.
* Bad, because oclif has significant configuration and scaffolding
  overhead for a relatively simple command set.
* Bad, because oclif has no native Ink integration.

## More Information

* [Pastel GitHub repository](https://github.com/vadimdemedes/pastel)
* [Ink GitHub repository](https://github.com/vadimdemedes/ink)
