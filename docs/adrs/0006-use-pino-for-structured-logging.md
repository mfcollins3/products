# Use pino for Structured Logging

* Status: Proposed
* Date: 2026-04-20

## Context and Problem Statement

Naked Products interacts with the file system, Git, the GitHub API, and an AI
service. Debugging failures in these integrations requires detailed operational
logs. The application needs a logging strategy that provides:

* Structured, machine-readable log output suitable for analysis
* Controllable verbosity (normal, verbose, debug)
* Log persistence to disk without interfering with TUI output
* Minimal performance impact on the interactive terminal experience

## Decision Drivers

* Logs must not pollute the TUI's stdout/stderr; they should be written to
  a log file at `~/.config/naked-products/logs/`.
* Structured (JSON) logs make it easier to search, filter, and analyze
  issues reported by users.
* The logging library must be lightweight; this is a CLI tool, not a
  long-running server, and startup time matters.
* The library must be compatible with the Node.js 24 + TypeScript ecosystem
  from [ADR-0001](0001-use-nodejs-24-and-typescript.md).

## Considered Options

* pino
* winston
* bunyan
* OpenTelemetry (OTLP logging)
* `console.log` only

## Decision Outcome

Chosen option: "pino", because it is the fastest JSON-structured logger in
the Node.js ecosystem, has built-in support for writing to file transports
(keeping logs off stdout), and is significantly lighter than OpenTelemetry
for a CLI tool's operational logging needs.

### Consequences

* Good, because pino writes structured JSON logs that are easy to parse
  and filter with tools like `jq`.
* Good, because pino's file transport keeps log output separate from the
  TUI's terminal output.
* Good, because pino has extremely low overhead, contributing minimal
  latency to operations being logged.
* Good, because pino supports log levels (`trace`, `debug`, `info`,
  `warn`, `error`, `fatal`) that map directly to the `--verbose` and
  `--debug` flags.
* Neutral, because pino's log output is JSON rather than human-readable;
  users who want to read raw logs must use `pino-pretty` or `jq`.
* Bad, because pino requires a transport or pretty-printer for human-
  readable output during development.

## Pros and Cons of the Options

### pino

* Good, because it is the fastest JSON logger in the Node.js ecosystem
  by a significant margin.
* Good, because it supports multiple transports, including file write
  streams for separating logs from TUI output.
* Good, because it has excellent TypeScript type definitions.
* Bad, because raw pino output is JSON and is not human-readable without
  `pino-pretty` or a similar tool.

### winston

* Good, because winston is the most widely known Node.js logging library
  with a large ecosystem of transports.
* Good, because winston supports human-readable and JSON output formats.
* Bad, because winston is significantly slower than pino due to its
  synchronous transport architecture.
* Bad, because winston's API is more complex than pino for the simple
  use case of writing structured logs to a file.

### bunyan

* Good, because bunyan is also JSON-structured and supports log levels.
* Bad, because bunyan is no longer actively maintained.
* Bad, because bunyan is slower than pino.

### OpenTelemetry (OTLP logging)

* Good, because OpenTelemetry provides a vendor-neutral observability
  standard covering logs, traces, and metrics.
* Bad, because OpenTelemetry is significantly more complex to configure
  and is designed for distributed systems, not CLI tools.
* Bad, because the OpenTelemetry Node.js SDK has a larger footprint than
  pino, negatively impacting startup time.

### `console.log` only

* Good, because it requires no dependencies.
* Bad, because `console.log` writes to stdout, which would interfere with
  TUI rendering.
* Bad, because console output is not structured and cannot be filtered
  by log level.
* Bad, because console output cannot easily be persisted to a log file
  without stream redirection.

## More Information

* [pino documentation](https://getpino.io/)
* [pino GitHub repository](https://github.com/pinojs/pino)
* [pino-pretty (development pretty-printer)](https://github.com/pinojs/pino-pretty)
