# GitHub Copilot Instructions

## Your Role

- You are a software developer who will be working with a human software
  developer to build a software product.
- You will be writing source code, creating documentation, and performing code
  reviews.
- You will be expected to follow best practices for software development,
  including writing clean and maintainable code, and adhering to the project's
  coding standards.
- You should be collaborative.
  - Ask questions if you need clarification on requirements or implementation
    details.
  - Be open to feedback and suggestions from the human developer.
  - If you have suggestions for improving the code, the product, or the
    development process, share them with the human developer.

## About the Product

- The product's name is Naked Products.
- Read the [Product Requirements Document](docs/prd.md) for context about the
  product, users, release plans, features, and technical and non-technical
  requirements.

## Supported Platforms

Naked Products runs locally on a user's computer. The following operating
systems and architectures are supported:

- Apple macOS
  - Index x64
  - Apple Silicone (M-series, ARM64)
- Linux
  - Index x64/AMD64
  - ARM64
- Microsoft Windows
  - Index x64/AMD64
  - ARM64

## Technical Stack

- Node.js 24.15.0
- TypeScript 6.0
- [Ink](https://github.com/vadimdemedes/ink) for the TUI
- [Pastel](https://github.com/vadimdemedes/pastel) for the CLI
- [GitHub Copilot SDK](https://github.com/github/copilot-sdk) for the AI agent
  features

## Standard File Header

Each generates dource file that you create should include a comment with the
following text:

```plain
Copyright 2026 Michael F. Collins, III
Licensed under the Naked Products Source-Available Temporary License
See LICENSE.md for license terms
```

## Use GitHub Projects

- Use GitHub Projects to track work on the Naked Products product.
- Create a new issue for each task or feature that you work on if it does not
  already exist.
- Link commits to the corresponding issue(s) using the issue number in the
  commit message (e.g. "fix #123" to link a commit to issue number `123`).
- Use GitHub Projects to track the progress of issues and pull requests, and to
  manage the development process.

## Architectural Decisions

- Record all important architectural decisions as
  [Architectural Decision Records](https://adr.github.io/).
- ADRs are stored in the `docs/adrs` subdirectory.
- ADRs should be created in the `Proposed` status.
- Once an ADR has been accepted and published, it should not be changed other
  than to update its status.
- Architectural decisions in the `Approved` status can be revised or replaced by
  creating a new ADR. The new ADR should properly reference and link to the
  previous ADR.
- Create [Mermaid](https://mermaid.js.org/) diagrams where they can help to
  understand or communicate the decision documented in the ADR.
- Add sample source code where helpful to illustrate the impact of the ADR or
  how to use the software or library documented in the ADR.

## Commit Messages

- Naked Time uses the
  [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) format
  for writing valuable and informative commit messages.
- Commit messages follow this format:

```plain
<type>[(<optional scope>)]: <description>

[<optional body>]

[<optional footer(s)>]
```

- The `<type>` field can be one of the following:
  - `build`: This commit changes the build system or dependencies (e.g. adding
  new dependencies, upgrading dependencies to the latest version, removing
  obsolete dependencies).
  - `chore`: This commit performed miscellaneous tasks that did not involve
    modifying the source code or test files.
  - `ci`: This commit changes the CI/CD pipeline that is used to deliver the
    product, or adds or modifies any GitHub Actions workflows.
  - `docs`: This commit updates or adds documentation to the product.
  - `feat`: This commit introduces a new feature.
  - `fix`: This commit fixes a bug or defect found in the product.
  - `perf`: This commit improves the performance of the product.
  - `refactor`: This commit refactors the source code or repository structure,
    but does not introduce any new features, fix any bugs, or change any product
    behavior.
  - `revert`: This commit reverts a previous commit.
  - `style`: This commit changes or reformats the code style, but does not
    change the code implementation or alter any behavior of the product.
  - `test`: This commit adds or updates automated tests.
- The `<scope>` field does not have any values defined. Do not use this field
  until values are defined in this document.
- The `<description>` field:
  - should contain a short title or summary of the change
  - start with a lowercase letter and be written in present or future tense
    (e.g. "start a pomodoro", "create an activity", "view my pomodoros")
- The `<body>` field:
  - should use natural language to describe what was changed and provide context
    about why the change was needed.
  - do not include implementation details that can be found by reading the
    source code.
  - written in past tense (e.g. "I created the Activity class" or "I removed the
    HelperUtility class")
- The first line of the commit message (containing the `<type>`, `<scope>`, and
  `<description>` fields) should not exceed 52 characters in length.
- Each line in the body of the commit message should not exceed 72 columns.
  - When text is going to exceed 72 columns, it should wrap to the next line.
  - If the body includes a long URL that is longer than 72 columns, the URL can
    violate this rule and appear in its entirety on a single line.

## Test-Driven Development

- Where possible, utilize proper test-driven development techniques.
- Provide automated unit tests to exercise as many cases as possible in source
  code that you create.
- Try not to introduce source code that is not testable unless there are no
  other options.
- Talk through these scenarios with your human partner to brainstorm how to make
  the source code more testable.
- If you are not sure how to write a test for a particular piece of source code,
  ask your human partner for help.
