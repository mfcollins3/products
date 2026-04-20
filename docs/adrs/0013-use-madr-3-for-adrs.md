# Use MADR 3.0 for Architectural Decision Records

* Status: Proposed
* Date: 2026-04-20

## Context and Problem Statement

Architectural decisions are a critical artifact of software projects.
Without a consistent format, ADRs become difficult to read, compare, and
maintain. A standard format must be chosen so that all ADRs produced for
Naked Products are uniform, tooling can be applied consistently, and
contributors know how to write new ADRs.

This ADR is self-referential: it records the decision about which ADR
format to use.

## Decision Drivers

* The format must be lightweight, human-readable, and renderable in
  GitHub without special tooling.
* The format should be widely documented so contributors can learn it
  from an external reference rather than a custom internal guide.
* The format should support the key elements of a decision record:
  context, options considered, decision, and consequences.
* The format should accommodate Mermaid diagrams and code samples where
  helpful (per the copilot-instructions.md requirement).

## Considered Options

* MADR 3.0 (Markdown Any Decision Records, version 3)
* MADR 4.0 (uses YAML frontmatter)
* Michael Nygard's ADR format
* Custom format

## Decision Outcome

Chosen option: "MADR 3.0", because it is the version specified in the
project's Product Requirements Document, it is widely adopted, its
documentation is comprehensive, and it uses plain Markdown sections
(not YAML frontmatter) that render cleanly on GitHub.

ADRs are stored in `docs/adrs/` and named using the convention
`NNNN-title-with-dashes.md`. All new ADRs are created with the status
`Proposed`. The status field is a plain Markdown bullet point at the top
of the file, not YAML frontmatter.

**MADR 3.0 template structure:**

```markdown
# {title}

* Status: {Proposed | Accepted | Deprecated | Superseded}
* Date: {YYYY-MM-DD}

## Context and Problem Statement

## Decision Drivers

## Considered Options

## Decision Outcome

### Consequences

## Pros and Cons of the Options

### {option}

## More Information
```

### Consequences

* Good, because MADR is documented at [https://adr.github.io/madr/](https://adr.github.io/madr/)
  and contributors can consult the official documentation.
* Good, because MADR 3.0 uses plain Markdown sections that render on
  GitHub without a static site generator or special tools.
* Good, because the format explicitly requires listing all considered
  options and their trade-offs, producing richer decision records.
* Neutral, because MADR 4.0 (which uses YAML frontmatter) provides
  better machine-parseability; MADR 3.0 trades that for simplicity.
* Bad, because the structure has more required sections than the simpler
  Nygard format, which can make writing new ADRs slightly more involved.

## Pros and Cons of the Options

### MADR 3.0

* Good, because it is specified in the PRD as the required format.
* Good, because it is widely used and has official documentation.
* Good, because it uses plain Markdown with no YAML frontmatter, which
  keeps the format simple and portable.
* Neutral, because the template has more sections than the Nygard format,
  which requires more thought per ADR.

### MADR 4.0

* Good, because YAML frontmatter improves machine parseability and
  supports tooling such as `adr-tools`.
* Bad, because YAML frontmatter in Markdown files renders as a table on
  GitHub, not as metadata, reducing readability.
* Bad, because it is not the version specified in the PRD.

### Michael Nygard's ADR format

* Good, because it is the original and simplest ADR format: Title,
  Status, Context, Decision, Consequences.
* Good, because it is well-understood by many developers.
* Bad, because the Nygard format does not explicitly require listing
  considered options and their trade-offs, producing less thorough
  decision records.

### Custom format

* Good, because it can be tailored to the exact needs of this project.
* Bad, because it requires writing and maintaining internal documentation
  for the format.
* Bad, because contributors cannot consult an external reference to
  learn the format.

## More Information

* [MADR specification](https://adr.github.io/madr/)
* [ADR GitHub organization](https://adr.github.io/)
* ADRs are stored in: `docs/adrs/`
