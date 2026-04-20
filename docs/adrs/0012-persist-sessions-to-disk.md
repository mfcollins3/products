# Persist Sessions to Disk

* Status: Proposed
* Date: 2026-04-20

## Context and Problem Statement

The product initialization workflow is complex and multi-step. A user may
begin a session — providing information about their product, making
decisions, generating artifacts — and then need to stop before the workflow
is complete. Without session persistence, all progress is lost and the user
must start over.

A strategy is needed for preserving session state between runs of the
application so that interrupted workflows can be resumed.

## Decision Drivers

* A user must be able to resume an interrupted initialization workflow
  without losing progress.
* The session storage must not contain tokens, credentials, or other
  secrets (see [ADR-0005](0005-delegate-authentication-to-github-cli.md)).
* The storage location must follow platform conventions for user data on
  macOS, Linux, and Windows.
* Session data must be scoped to the project directory, so users working
  on multiple products have independent sessions.
* Old sessions that are no longer needed must be cleaned up automatically.

## Considered Options

* Disk persistence in `~/.config/naked-products/sessions/`
* In-memory only (no persistence)
* GitHub Gist storage
* Cloud sync (e.g., via a backend API)

## Decision Outcome

Chosen option: "Disk persistence in `~/.config/naked-products/sessions/`",
because it is simple, requires no external services or network access, and
follows the XDG Base Directory specification used on Linux and the platform
equivalent conventions on macOS and Windows. The project directory path is
used as the session key, ensuring sessions are independent per project.

Sessions are stored as JSON files. Sessions older than 30 days are
automatically deleted on startup to prevent unbounded growth.

### Consequences

* Good, because users can resume incomplete workflows after interruptions,
  including system restarts.
* Good, because disk persistence requires no external services, network
  access, or accounts beyond what the application already requires.
* Good, because the 30-day automatic cleanup keeps session storage bounded.
* Good, because storing sessions per project directory prevents cross-project
  contamination.
* Neutral, because the `~/.config/naked-products/` directory is created on
  first run.
* Bad, because session data is stored on the local machine only and is not
  available on other machines.
* Bad, because disk storage may fail in restricted environments; the
  application must degrade gracefully to in-memory behavior in this case.

## Pros and Cons of the Options

### Disk persistence in `~/.config/naked-products/sessions/`

* Good, because it works offline with no external dependencies.
* Good, because it follows XDG conventions that developers expect.
* Good, because JSON files are easy to inspect and debug.
* Bad, because sessions are not portable across machines.

### In-memory only (no persistence)

* Good, because it eliminates all session storage complexity.
* Good, because there is no risk of stale or corrupted session data.
* Bad, because any interruption (system restart, terminal close, error)
  causes the user to lose all progress and start the workflow over.

### GitHub Gist storage

* Good, because sessions are accessible from any machine where the user
  is authenticated.
* Bad, because it requires a GitHub API call to read and write sessions,
  adding latency and introducing a network dependency.
* Bad, because Gist content is potentially visible to others; sensitive
  context (e.g., partially generated PRD content) would be stored there.
* Bad, because it adds complexity for a relatively uncommon use case
  (working on the same product from multiple machines simultaneously).

### Cloud sync (backend API)

* Good, because it provides full cross-device session portability.
* Bad, because it requires building, operating, and securing a backend
  service.
* Bad, because it introduces a dependency on infrastructure availability,
  adding risk of downtime.
* Bad, because it is significantly over-engineered for the current
  release scope.

## More Information

* [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/latest/)
* [`env-paths` npm package for cross-platform config directory resolution](https://github.com/sindresorhus/env-paths)
