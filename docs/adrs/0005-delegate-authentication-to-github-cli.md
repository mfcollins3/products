# Delegate Authentication to the GitHub CLI

* Status: Proposed
* Date: 2026-04-20

## Context and Problem Statement

Naked Products must authenticate with the GitHub API to create repositories,
projects, issues, and manage teams. GitHub API authentication requires an
access token with appropriate scopes. The application needs a secure strategy
for acquiring and using this token without introducing its own credential
storage or OAuth flows.

The target audience — developers — almost universally have the GitHub CLI
(`gh`) installed and authenticated. The GitHub CLI handles the OAuth device
flow, token refresh, and secure storage in the system keychain.

## Decision Drivers

* The application must never store or cache GitHub credentials independently
  (stated security constraint in the PRD).
* The authentication strategy must work on macOS, Linux, and Windows without
  additional setup beyond what a developer already has.
* Adding a separate OAuth app registration or GitHub App adds complexity and
  requires distributing client secrets.
* Using `gh auth token` is the simplest path to a valid token that the user
  already controls.

## Considered Options

* Delegate to the GitHub CLI (`gh auth token`)
* OAuth Device Flow (GitHub App or OAuth App)
* Personal Access Token (PAT) configured by the user
* GitHub App with installation token

## Decision Outcome

Chosen option: "Delegate to the GitHub CLI (`gh auth token`)", because the
target audience already has `gh` installed and authenticated, this approach
requires zero credential management by the application, and it respects the
user's existing GitHub session including any enterprise or SSO configurations.

### Consequences

* Good, because the application stores no credentials; all tokens remain
  managed by `gh` in the system keychain.
* Good, because users with enterprise GitHub or SSO configurations do not
  need to set up separate credentials.
* Good, because validating that `gh` is installed and authenticated before
  proceeding provides clear, actionable error messages.
* Good, because `gh auth token` returns the token for the currently
  authenticated user, which is the same account that will own the
  repositories and projects created by Naked Products.
* Neutral, because the application has a hard dependency on `gh` being
  installed; users without `gh` must install it first.
* Bad, because if `gh` is not authenticated or the token is expired, the
  user must resolve the issue outside the application.

## Pros and Cons of the Options

### Delegate to the GitHub CLI (`gh auth token`)

* Good, because it requires no credential storage by the application.
* Good, because it leverages existing developer tooling with no new setup.
* Good, because it supports GitHub.com and GitHub Enterprise Server
  through `gh`'s existing configuration.
* Bad, because it requires `gh` to be installed and authenticated as a
  prerequisite.

### OAuth Device Flow (GitHub App or OAuth App)

* Good, because it does not require `gh` to be pre-installed.
* Bad, because it requires registering an OAuth App or GitHub App and
  distributing client credentials.
* Bad, because the application would need to implement secure token
  storage, token refresh, and revocation.
* Bad, because it adds complexity: callback handling, browser launch, and
  token persistence.

### Personal Access Token (PAT) configured by the user

* Good, because it works without any additional tooling.
* Bad, because it requires the user to manually create a PAT with the
  correct scopes, which is error-prone.
* Bad, because PATs must be stored somewhere (environment variable, config
  file), creating credential management complexity.
* Bad, because fine-grained PATs have a limited lifetime and require
  periodic rotation.

### GitHub App with installation token

* Good, because GitHub Apps have a more granular permission model than
  OAuth Apps.
* Bad, because GitHub Apps must be installed on each organization or
  repository, creating a complex onboarding flow.
* Bad, because installation tokens are short-lived (1 hour) and require
  a private key to be stored and managed by the application.
* Bad, because GitHub Apps are appropriate for services, not individual
  developer tools.

## More Information

* [GitHub CLI authentication documentation](https://cli.github.com/manual/gh_auth)
* [`gh auth token` command reference](https://cli.github.com/manual/gh_auth_token)
