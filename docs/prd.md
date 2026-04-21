# Naked Products - Product Requirements Document

## 1. Product overview

### 1.1 Problem statement

Solo developers and small teams who want to build software products face a
fragmented and time-consuming setup process. Starting a new product requires
creating repositories, setting up project tracking, writing foundational
documents (PRD, LICENSE, CONTRIBUTING, ADRs), configuring tooling, and
organizing teams — all before writing a single line of product code. These tasks
are repetitive, error-prone, and often skipped or done inconsistently, leading
to poorly organized projects from the start.

Naked Products solves this by providing an AI-powered conversational agent that
guides product owners through the entire product initialization workflow,
automating the creation and configuration of all foundational artifacts.

### 1.2 Product vision

Naked Products aims to become the definitive product management companion for
software developers — an intelligent agent that guides product owners through
every phase of the product development lifecycle, from inception through release
and beyond. Starting with product initialization, the platform will expand to
cover ongoing planning, tracking, and delivery workflows.

### 1.3 Success criteria

- A product owner can go from zero to a fully initialized product (repository,
  project board, PRD, issues, foundational documents) in a single conversational
  session.
- All generated artifacts (PRD, LICENSE, CONTRIBUTING, ADRs, issue templates,
  Copilot instructions) are production-quality and require minimal manual
  editing.
- GitHub integration works seamlessly using existing GitHub CLI authentication.
- The application installs cleanly via platform-native packages on Windows,
  macOS, and Linux, or runs in a container.

## 2. User personas

**Solo Developer (Primary)**
A developer building their own software product. They have technical skills but
limited time for project management overhead. They want to follow best practices
for product development but need guidance and automation to do so efficiently.

- **Goals:** Quickly set up a well-organized product with all the right
  foundational artifacts; focus time on building rather than configuring.
- **Pain Points:** Setting up new projects is tedious and repetitive; unsure
  which license to pick, what to include in CONTRIBUTING.md, or how to structure
  ADRs; forgets important setup steps.

**Small Team Lead (Secondary)**
A technical lead at a small company starting a new product with a small team.
They need to set up collaboration infrastructure (teams, code owners, issue
templates) in addition to the foundational artifacts.

- **Goals:** Get the team productive quickly with a well-structured repository
  and project board; establish clear contribution guidelines and ownership.
- **Pain Points:** Onboarding team members to a new project takes too long;
  inconsistent project setup across products.

## 3. Principles and constraints

### 3.1 Design principles

1. **Conversational over configuration** — The agent should guide users through
   decisions via natural conversation rather than requiring upfront configuration
   files or flags.
2. **Opinionated defaults, flexible overrides** — Provide sensible defaults for
   all artifacts but allow the user to customize through conversation.
3. **Incremental progress** — Each step should produce a tangible, usable
   artifact. The user can stop at any point and still have value.
4. **Leverage existing tools** — Integrate with GitHub CLI, Git, and other tools
   the user already has rather than reimplementing their functionality.

### 3.2 Technical constraints

- **Runtime:** Node.js 24 LTS
- **Language:** TypeScript
- **AI integration:** GitHub Copilot SDK for conversational AI capabilities
- **TUI framework:** Ink (React-based terminal UI)
- **CLI framework:** Pastel (CLI framework for Ink)
- **Logging:** pino (structured JSON logging)
- **NPM package:** `@mfcollins/products` (private, not published to NPM)
- **GitHub authentication:** Must use existing GitHub CLI (`gh`) authentication;
  no separate auth flow
- **Platform support:** macOS (x64, ARM64), Linux (x64, ARM64), and Windows
  (x64, ARM64)
- **Distribution formats:** `.msi` (Windows), `.pkg` (macOS), `.deb` and `.rpm`
  (Linux), container image (x64/AMD64, ARM64)
- **Container base image:** Google distroless (Node.js variant)
- **CI/CD:** GitHub Actions for building, testing, packaging, and publishing
- **Dependencies:** Requires Git and GitHub CLI (`gh`) to be installed and
  authenticated
- **Security:** No credentials stored by the application; relies entirely on
  `gh` auth tokens

### 3.3 Out of scope

- Web or desktop GUI interface (v1.0 is terminal-only)
- Voice-to-text input processing (future consideration)
- Ongoing project management after initial setup (sprint planning,
  retrospectives, etc.)
- CI/CD pipeline setup for the product being created
- Code generation or scaffolding (application code, frameworks)
- Integration with non-GitHub platforms (GitLab, Bitbucket, Azure DevOps)
- Multi-repository or monorepo management
- Billing, subscriptions, or SaaS features
- Hosting or deployment of the product being created
- Publishing the NPM package to a public registry

## 4. Release plan (high level)

### v1.0.0 - 2026-09-01 - Product initialization

The first release focuses on the complete product initialization workflow.
"Done" means a product owner can install Naked Products via a platform-native
package or container, run it, and through a guided conversational session
produce a fully initialized GitHub repository with all foundational documents,
a linked GitHub project with issues, configured teams, and issue templates.

### v1.1.0 - TBD - Refinement and additional workflows (tentative)

Expand to support updating existing products — adding new releases, revising
PRDs, managing backlog, and adding new ADRs as the product evolves.

### v2.0.0 - TBD - Full lifecycle management (tentative)

Expand into ongoing product management: release tracking, milestone management,
status reporting, and integration with CI/CD workflows.

## 5. Current version: v1.0.0 requirements

### 5.1 Feature: Installation and distribution

**PROD-001**
**User story:** As a product owner, I want to install Naked Products using a
platform-native package so that I can get started quickly on my operating
system.

**Acceptance criteria:**

- [ ] Windows users can install via an `.msi` installer (x64 and ARM64)
- [ ] macOS users can install via a `.pkg` installer (x64 and ARM64)
- [ ] Linux users can install via `.deb` (Debian/Ubuntu) or `.rpm` (Fedora/RHEL)
  packages (x64 and ARM64)
- [ ] macOS and Linux users can install and update via Homebrew (`brew install nakedproducts`)
- [ ] Windows users can install and update via WinGet (`winget install nakedproducts`)
- [ ] After installation, the `nakedproducts` command is available on the system
  PATH
- [ ] Installation packages are published as assets on GitHub Releases
- [ ] Each release includes checksums (SHA-256) for all packages

**Technical notes:** Use platform-specific packaging tools (e.g., WiX for .msi,
pkgbuild for .pkg, fpm or dpkg-deb for .deb/.rpm). Build and publish packages
via GitHub Actions. Use GitHub Actions caching for Node.js dependencies to
optimize build performance. Publish a Homebrew tap (e.g., `mfcollins3/tap`) with
a formula for macOS and Linux. Submit a WinGet manifest to the
`microsoft/winget-pkgs` repository for Windows package manager support.

**Priority:** Must-have

**PROD-002**
**User story:** As a product owner, I want to run Naked Products as a container
so that I can use it without installing native packages.

**Acceptance criteria:**

- [ ] A container image is published to GitHub Container Registry (ghcr.io)
- [ ] The image is available for linux/amd64 and linux/arm64 architectures
- [ ] The image uses a Google distroless base image for minimal attack
  surface (see [ADR-0009](adrs/0009-use-distroless-container-image.md))
- [ ] Static binaries for `git`, `gh`, and the GitHub Copilot CLI are copied
  from intermediate builder stages into the distroless final image (no shell
  or package manager in the final image)
- [ ] The image includes `git`, `gh` (GitHub CLI), and the GitHub Copilot CLI
- [ ] The container can be run with `docker run` and mounts the host filesystem
  for output
- [ ] The container passes through GitHub CLI authentication (via mounted config
  or environment variable)
- [ ] The image is tagged with the version number and `latest`

**Technical notes:** Build the application and install dependencies in the
GitHub Actions CI pipeline (leveraging dependency caching), then use a
Dockerfile that copies the pre-built output into the
`gcr.io/distroless/nodejs24-debian12` base image with the additional CLI tools.
Publish multi-arch images using Docker buildx. Binary versions for `git`, `gh`,
and the Copilot CLI are pinned in the Dockerfile and updated via dependency-bot
PRs.

**Priority:** Must-have

### 5.2 Feature: TUI conversational interface

**PROD-003**
**User story:** As a product owner, I want to launch Naked Products and interact
with an AI agent through a TUI so that I can be guided through the product
initialization workflow conversationally.

**Acceptance criteria:**

- [ ] Running `nakedproducts` without arguments opens the TUI with a
  conversational chat interface
- [ ] The agent greets the user and explains available capabilities
- [ ] The user can type messages and receive responses in real time
- [ ] The conversation history is visible and scrollable within the TUI
- [ ] The user can exit the TUI gracefully with a quit command or keyboard
  shortcut (e.g., Ctrl+C)

**Technical notes:** Use Ink for the TUI rendering. Integrate with the GitHub
Copilot SDK for AI-powered conversation.

**Priority:** Must-have

### 5.3 Feature: CLI commands

**PROD-004**
**User story:** As a product owner, I want to run specific CLI commands directly
so that I can perform individual setup tasks without entering the full
conversational TUI.

**Acceptance criteria:**

- [ ] The application provides a `--help` flag that lists all available commands
- [ ] Each command provides its own `--help` with usage instructions
- [ ] CLI commands can be run non-interactively with appropriate flags
- [ ] CLI commands output results to stdout and errors to stderr
- [ ] Exit codes follow standard conventions (0 for success, non-zero for
  failure)

**Technical notes:** Use Pastel for CLI command routing and argument parsing.

**Priority:** Must-have

### 5.4 Feature: GitHub authentication

**PROD-005**
**User story:** As a product owner, I want Naked Products to use my existing
GitHub CLI authentication so that I don't need to manage separate credentials.

**Acceptance criteria:**

- [ ] The application detects whether `gh` is installed and authenticated
- [ ] If `gh` is not installed, the application displays a clear error message
  with installation instructions
- [ ] If `gh` is not authenticated, the application prompts the user to run
  `gh auth login`
- [ ] All GitHub API calls use the token from `gh auth token`
- [ ] The application never stores or caches GitHub credentials independently
- [ ] The application validates that the `gh` token includes the scopes
  required for the operation: `repo` and `project` for all repository
  operations, `read:org` when targeting an organization, and `admin:org` only
  when GitHub team creation (PROD-015) is invoked. Missing scopes produce a
  clear error naming the scope and the `gh` command needed to grant it.

**Technical notes:** Use `gh auth token` to retrieve the auth token. Validate
the token has the required scopes before proceeding; scope validation uses the
`X-OAuth-Scopes` response header from `GET /user`.

**Priority:** Must-have

### 5.5 Feature: Product requirements document creation

**PROD-006**
**User story:** As a product owner, I want the agent to guide me through
creating a PRD so that I can document the product vision, features, and user
stories for my first release.

**Acceptance criteria:**

- [ ] The agent asks clarifying questions about the product (name, problem,
  audience, features)
- [ ] The agent generates a PRD in Markdown format following a consistent
  template
- [ ] The PRD includes sections for: product overview, user personas, design
  principles, constraints, release plan, feature requirements with user stories
  and acceptance criteria, non-functional requirements, and open questions
- [ ] Each user story has a unique requirement ID (e.g., PROD-001)
- [ ] The user can review and request revisions to the PRD through conversation
- [ ] The final PRD is saved to the repository as `prd.md`
- [ ] Custom PRD templates are supported via the template resolution hierarchy

**Technical notes:** Use the GitHub Copilot SDK to power the conversational PRD
creation.

**Priority:** Must-have

### 5.6 Feature: Git repository creation

**PROD-007**
**User story:** As a product owner, I want the agent to create a new Git
repository for my product so that I have version control set up from the start.

**Acceptance criteria:**

- [ ] The agent asks for the desired directory path for the new repository
- [ ] A new Git repository is initialized with `git init`
- [ ] The agent asks the user to identify the technology stack (programming
  languages, frameworks, build tools) for the new project
- [ ] A `.gitignore` file is composed from gitignore templates matching the
  selected stack and written to the repository root
- [ ] A `.gitattributes` file is created with sensible defaults
- [ ] An initial commit is created with the foundational files
- [ ] The default branch is named `main`

**Technical notes:** Use Node.js `child_process` or a Git library (e.g.,
simple-git) to execute Git commands. Gitignore templates are sourced from the
[`github/gitignore`](https://github.com/github/gitignore) repository (cached
locally) or bundled with the application.

**Priority:** Must-have

### 5.7 Feature: GitHub repository creation

**PROD-008**
**User story:** As a product owner, I want the agent to create a GitHub
repository for my product so that I can host my code and collaborate with
others.

**Acceptance criteria:**

- [ ] The agent asks whether to create the repository under a personal account
  or an organization
- [ ] The agent asks for the repository name, description, and visibility
  (public/private)
- [ ] The GitHub repository is created using the GitHub API via `gh`
  authentication
- [ ] The local Git repository is configured with the GitHub remote as `origin`
- [ ] The initial commit is pushed to the GitHub repository
- [ ] The agent confirms the repository URL to the user

**Technical notes:** Use the GitHub REST or GraphQL API with the token from
`gh auth token`.

**Priority:** Must-have

### 5.8 Feature: GitHub project creation

**PROD-009**
**User story:** As a product owner, I want the agent to create a GitHub project
for my first release so that I can track work items on a project board.

**Acceptance criteria:**

- [ ] The agent creates a GitHub project (Projects v2) with a title based on the
  product name and version
- [ ] The project is linked to the GitHub repository
- [ ] The project includes default columns/views for tracking work (e.g.,
  Backlog, In Progress, Done)
- [ ] The agent provides the project URL to the user

**Technical notes:** Use the GitHub GraphQL API for Projects v2 operations.

**Priority:** Must-have

### 5.9 Feature: GitHub issue creation from PRD

**PROD-010**
**User story:** As a product owner, I want the agent to create GitHub issues
from the user stories in my PRD so that each feature and story is trackable as a
work item.

**Acceptance criteria:**

- [ ] Each user story in the PRD is created as a GitHub issue in the repository
- [ ] Issue titles follow the format `[PROD-XXX] <user story summary>`
- [ ] Issue bodies include the full user story, acceptance criteria, and
  priority
- [ ] Issues are labeled with priority (e.g., `must-have`, `should-have`,
  `nice-to-have`)
- [ ] All created issues are added to the GitHub project
- [ ] The agent provides a summary of created issues with their URLs

**Technical notes:** Use the GitHub REST API to create issues and the GraphQL
API to add them to the project.

**Priority:** Must-have

### 5.10 Feature: License selection and creation

**PROD-011**
**User story:** As a product owner, I want the agent to help me select an
appropriate license and generate the LICENSE.md file so that my product has
clear legal terms from the start.

**Acceptance criteria:**

- [ ] The agent asks about the intended use of the product (open source,
  proprietary, etc.)
- [ ] The agent presents common license options with brief explanations (MIT,
  Apache 2.0, GPL-3.0, BSD, proprietary, etc.)
- [ ] The agent recommends a license based on the user's stated goals
- [ ] The selected license text is written to `LICENSE.md` in the repository
  root
- [ ] The license file includes the correct year and copyright holder name
- [ ] If the user is unsure, the agent explains tradeoffs between license types

**Technical notes:** License templates can be sourced from the GitHub Licenses
API or bundled with the application.

**Priority:** Must-have

### 5.11 Feature: CONTRIBUTING.md creation

**PROD-012**
**User story:** As a product owner, I want the agent to generate a
CONTRIBUTING.md document so that contributors know how to participate in my
project.

**Acceptance criteria:**

- [ ] The agent asks about the contribution model (open to external
  contributors, internal only, or both)
- [ ] The generated document includes sections for: how to report bugs, how to
  suggest features, development setup instructions, pull request process, coding
  standards, and code of conduct reference
- [ ] The document is tailored based on the project's technology stack and
  workflow
- [ ] The file is saved as `CONTRIBUTING.md` in the repository root
- [ ] The user can review and request changes before finalizing
- [ ] Custom CONTRIBUTING templates are supported via the template resolution
  hierarchy

**Technical notes:** Generate content using the Copilot SDK, customized based on
project context gathered during the conversation.

**Priority:** Must-have

### 5.12 Feature: Copilot instructions configuration

**PROD-013**
**User story:** As a product owner, I want the agent to create a
`.github/copilot-instructions.md` file so that GitHub Copilot generates code
consistent with my project's conventions.

**Acceptance criteria:**

- [ ] The agent asks about coding conventions, preferred patterns, and
  technology stack
- [ ] The generated file includes instructions for: language and framework
  preferences, coding style guidelines, testing conventions, file organization
  patterns, and any project-specific rules
- [ ] The file is saved at `.github/copilot-instructions.md`
- [ ] The user can review and modify the instructions through conversation

**Technical notes:** The instructions should be informed by decisions made
earlier in the session (tech stack, ADRs, etc.).

**Priority:** Must-have

### 5.13 Feature: Architecture decision records

**PROD-014**
**User story:** As a product owner, I want the agent to help me create initial
ADRs so that key architectural decisions are documented from the start.

**Acceptance criteria:**

- [ ] The agent asks about the technology stack and major architectural
  decisions
- [ ] ADRs are created in Markdown format using the MADR (Markdown Any Decision
  Records) 3.0 template
- [ ] ADRs are stored in a `docs/adr/` directory
- [ ] Each ADR has a sequential number and descriptive filename (e.g.,
  `0001-use-typescript-and-nodejs.md`)
- [ ] An `index.md` or `README.md` file is created in the ADR directory listing
  all ADRs
- [ ] Each ADR includes: title, date, status, context, decision, and consequences
- [ ] The agent suggests common initial ADRs based on the project context (e.g.,
  language choice, framework choice, database choice)

**Technical notes:** Follow the MADR 3.0 format. The agent should proactively
suggest decisions worth recording based on the conversation.

**Priority:** Should-have

### 5.14 Feature: GitHub teams and code owners

**PROD-015**
**User story:** As a product owner, I want the agent to create GitHub teams and
set up a CODEOWNERS file so that code review responsibilities are clearly
defined.

**Acceptance criteria:**

- [ ] The agent asks whether the repository is under an organization (teams
  require an org)
- [ ] If under an org, the agent asks about team structure (team names, members)
- [ ] GitHub teams are created in the organization using the GitHub API
- [ ] Team members are invited or added to the appropriate teams
- [ ] A `CODEOWNERS` file is generated in the repository root or `.github/`
  directory
- [ ] The CODEOWNERS file maps file patterns to teams or individuals
- [ ] If the repository is under a personal account, the agent skips team
  creation and focuses on CODEOWNERS with individual usernames
- [ ] The user can review and modify team and ownership assignments

**Technical notes:** Use the GitHub REST API for team management. CODEOWNERS
syntax must follow GitHub's specification.

**Priority:** Should-have

### 5.15 Feature: Issue templates

**PROD-016**
**User story:** As a product owner, I want the agent to set up issue templates
so that contributors can file well-structured bug reports and feature requests.

**Acceptance criteria:**

- [ ] The agent creates issue templates in the `.github/ISSUE_TEMPLATE/`
  directory
- [ ] At minimum, templates are created for: bug report, feature request, and a
  blank issue option
- [ ] Each template uses GitHub's issue form YAML format
- [ ] Templates include appropriate labels, title prefixes, and structured
  fields
- [ ] A `config.yml` is created to configure the issue template chooser
- [ ] The user can request additional custom templates through conversation

**Technical notes:** Use GitHub issue forms (YAML-based) rather than the older
Markdown-based templates for a better user experience.

**Priority:** Should-have

### 5.16 Feature: Session persistence and resumption

**PROD-017**
**User story:** As a product owner, I want my conversational session to be saved
so that I can resume where I left off if I need to close the application.

**Acceptance criteria:**

- [ ] Session state (conversation history, completed steps, in-progress data) is
  persisted to disk automatically
- [ ] Sessions are stored in `~/.config/naked-products/sessions/`
- [ ] When launching the application, if a previous session exists for the
  current project, the agent offers to resume it
- [ ] The user can list, resume, or delete previous sessions
- [ ] Session data does not include sensitive information (tokens, credentials)
- [ ] Sessions older than 30 days are automatically cleaned up

**Technical notes:** Serialize session state to JSON. Use the project directory
path as the session key.

**Priority:** Must-have

### 5.17 Feature: Custom templates

**PROD-018**
**User story:** As a product owner, I want to use custom templates for generated
artifacts so that outputs match my organization's standards.

**Acceptance criteria:**

- [ ] Templates are resolved using a layered hierarchy (highest to lowest
  priority):
  1. Project-level: `.naked-products/templates/` in the current repository
  2. User-level: `~/.config/naked-products/templates/` on disk
  3. Organization-level: `.naked-products` repository in the user's GitHub
     organization
  4. Built-in: default templates bundled with the application
- [ ] Custom templates can be provided for: PRD, CONTRIBUTING, ADR, issue
  templates, and Copilot instructions
- [ ] The agent indicates which template source is being used when generating an
  artifact
- [ ] Invalid or malformed templates produce a clear error with fallback to the
  next level in the hierarchy

**Technical notes:** Use a template engine (e.g., Handlebars, Mustache, or EJS)
for template rendering. Cache organization-level templates locally to avoid
repeated API calls.

**Priority:** Should-have

### 5.18 Feature: Guided workflow orchestration

**PROD-019**
**User story:** As a product owner, I want the agent to guide me through all
initialization tasks in a logical order so that I don't miss any steps and each
task builds on the previous one.

**Acceptance criteria:**

- [ ] The agent presents a suggested workflow order for product initialization
- [ ] The user can follow the suggested order or skip/reorder steps
- [ ] The agent tracks which steps have been completed and which remain
- [ ] Completed steps are not repeated unless the user explicitly requests it
- [ ] The agent warns if a step depends on a previous step that hasn't been
  completed (e.g., creating GitHub issues before creating the repository)
- [ ] At any point, the user can ask for a summary of progress

**Technical notes:** Implement a workflow state machine that tracks progress.
State is persisted as part of the session (see PROD-017).

**Priority:** Must-have

### 5.19 Feature: Usage telemetry and error reporting

**PROD-020**
**User story:** As the product maintainer, I want to collect anonymous usage
telemetry and error reports so that I can understand how Naked Products is being
used and fix serious issues.

**Acceptance criteria:**

- [ ] On first launch, the user is prompted to opt in to telemetry collection
  with a clear explanation of what data is collected
- [ ] The user can view the full privacy policy from the opt-in prompt before
  making a decision
- [ ] A `nakedproducts privacy-policy` command displays the full privacy policy
  in the terminal
- [ ] A `--privacy-policy` flag is available as a shortcut to display the
  privacy policy
- [ ] The user's telemetry preference is stored in
  `~/.config/naked-products/config.json`
- [ ] The user can change their telemetry preference at any time via
  `nakedproducts telemetry --enable` or `nakedproducts telemetry --disable`
- [ ] When telemetry is enabled, the following events are sent to the Naked
  Products telemetry relay (which forwards to Google Analytics GA4
  server-side):
  - Application launch events
  - Feature usage events (which commands/workflow steps are used)
  - Session duration
  - Platform and architecture (e.g., macOS ARM64, Linux x64)
  - Application version
- [ ] Unhandled errors and critical failures are reported with stack traces
  (no user data or file contents are included)
- [ ] No telemetry data is sent when the user has not opted in or has opted out
- [ ] Telemetry collection does not degrade application performance (events are
  sent asynchronously and non-blocking)
- [ ] No personally identifiable information (PII) is collected; telemetry uses
  a random anonymous client ID

**Technical notes:** Telemetry events are POSTed to a Naked Products-operated
telemetry relay endpoint (see
[ADR-0015](adrs/0015-use-telemetry-relay-api.md)). The relay holds the GA4
Measurement Protocol API secret server-side, forwarding validated events to
GA4. The CLI does not contain any GA4 credentials. Generate a random anonymous
client ID on first opt-in and store it in the config file. Batch events where
possible to minimize network calls. The privacy policy is bundled as a text
file with the application.

**Priority:** Should-have (depends on telemetry relay availability — may slip
to v1.0.1)

## 6. Non-functional requirements

- **Performance:** The TUI should feel responsive; AI responses should begin
  streaming within 3 seconds. GitHub API operations should include progress
  indicators for operations that take more than 1 second.
- **Error handling:** All external operations (Git, GitHub API, file system)
  should have clear error messages with suggested remediation steps. The agent
  should never crash silently; unhandled errors should be caught and reported
  gracefully.
- **Logging:** Use pino for structured JSON logging. Logs are written to
  `~/.config/naked-products/logs/`. Log verbosity is controllable via a
  `--verbose` or `--debug` flag. Debug logs include all GitHub API calls and Git
  operations with timing information.
- **Accessibility:** The TUI should work in standard terminal emulators on
  macOS, Linux, and Windows. Output should be compatible with screen readers
  where possible.
- **Idempotency:** Re-running steps should be safe. If a repository or project
  already exists, the agent should detect it and offer to update rather than
  fail.
- **Rate limiting:** GitHub API calls use exponential backoff with up to 3
  retries (delays of ~1s, ~2s, ~4s). After exhausting retries, the agent reports
  the error and displays the rate limit reset time so the user knows when to
  retry.
- **Security:** No credentials are stored by the application. All GitHub
  authentication is delegated to `gh`. Session files must not contain tokens or
  secrets.

## 7. Open questions

- What specific GitHub Actions workflows are needed for building the six
  platform packages plus the container image? Should this be a single workflow
  or multiple?
- Should the distroless container image use a custom layer to add `git`, `gh`,
  and Copilot CLI, or should a different base image be used that already
  includes these tools?
- What test framework should be used (Vitest, Jest, or other)?
- Should the application support a configuration file (e.g., `.nakedproductsrc`)
  for setting user-level defaults?

## 8. Decisions log

| Date | Decision | Rationale | Made by |
| ---- | -------- | --------- | ------- |
| 2026-04-18 | Use Node.js 24 LTS and TypeScript | Stability for distributed packages; aligns with Copilot SDK ecosystem | Product owner |
| 2026-04-18 | Use GitHub Copilot SDK for AI | Provides conversational AI capabilities integrated with GitHub's ecosystem | Product owner |
| 2026-04-18 | Leverage GitHub CLI for authentication | Avoids credential management complexity; reuses existing developer workflow | Product owner |
| 2026-04-18 | Use MADR 3.0 format for ADRs | Widely adopted, well-documented format for architectural decision records | Product owner |
| 2026-04-18 | TUI-first with supplementary CLI commands | Conversational interface is the primary interaction model; CLI commands serve as shortcuts for discrete tasks | Product owner |
| 2026-04-18 | Use Ink for TUI | React-based terminal UI framework; mature, well-maintained, strong ecosystem | Product owner |
| 2026-04-18 | Use Pastel for CLI framework | Built for Ink by the same author; seamless integration with TUI components | Product owner |
| 2026-04-18 | Use pino for structured logging | Fast, JSON-based structured logging; lightweight alternative to OpenTelemetry for a CLI tool | Product owner |
| 2026-04-18 | Distribute via platform-native packages and container | .msi, .pkg, .deb, .rpm for native installs; distroless container image for containerized use | Product owner |
| 2026-04-18 | Use Google distroless as container base | Minimal attack surface; no shell or package manager in production image | Product owner |
| 2026-04-18 | Include git, gh, and Copilot CLI in container | Container must be self-contained with all required CLI tools | Product owner |
| 2026-04-18 | Build outside Docker, copy into image | Leverage GitHub Actions dependency caching; avoid multi-stage builds that bypass CI cache | Product owner |
| 2026-04-18 | Persist sessions to disk | Allows users to resume interrupted product initialization workflows | Product owner |
| 2026-04-18 | Retry with exponential backoff for rate limiting | 3 retries with ~1s/~2s/~4s delays before reporting errors; standard API client pattern | Product owner |
| 2026-04-18 | Layered template resolution | Project > User > Org > Built-in hierarchy; follows Git config precedent; works out of the box with override capability | Product owner |
| 2026-04-18 | Use GitHub Actions for CI/CD | Build, test, package, and publish via GitHub Actions with dependency caching | Product owner |
| 2026-04-18 | NPM package: `@mfcollins/products` (private) | Package is not published to NPM; used internally for project structure | Product owner |
| 2026-04-18 | CLI command name: `nakedproducts` | Single-word command without hyphens | Product owner |
| 2026-04-19 | Use Google Analytics (GA4) for telemetry | Understand product usage patterns and capture critical errors; opt-in only with privacy policy | Product owner |
