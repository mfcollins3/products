# Use Layered Template Resolution Hierarchy

* Status: Proposed
* Date: 2026-04-20

## Context and Problem Statement

Naked Products generates a set of artifacts during product initialization:
PRDs, CONTRIBUTING.md, ADRs, issue templates, and Copilot instructions.
The built-in templates provide sensible defaults, but organizations and
individual developers may want to override them with custom templates that
match their standards.

A strategy is needed for resolving which template to use when multiple
candidates exist (built-in, user-level, organization-level, project-level).

## Decision Drivers

* The application must work correctly out of the box with no configuration;
  built-in templates serve as the default fallback.
* Individual users must be able to set personal defaults that apply across
  all of their projects.
* Organizations must be able to enforce standards by providing templates in
  a shared GitHub repository.
* Projects must be able to override all other templates for project-specific
  requirements.
* Higher-specificity templates take precedence over lower-specificity ones.
* The template resolution order should be predictable and communicable to
  the user.

## Considered Options

* Layered hierarchy (Project > User > Organization > Built-in)
* Single user-level configuration file with template paths
* Remote template registry
* Built-in templates only (no customization)

## Decision Outcome

Chosen option: "Layered hierarchy (Project > User > Organization >
Built-in)", because it follows the well-understood precedence model used
by Git configuration (`local > global > system`), works out of the box
with zero configuration, and provides increasing levels of specificity
that match how teams typically want to enforce standards.

```plain
Template resolution order (highest priority first):

1. Project:      .naked-products/templates/<artifact>
2. User:         ~/.config/naked-products/templates/<artifact>
3. Organization: .naked-products repo in the user's GitHub org
4. Built-in:     Templates bundled with the application
```

### Consequences

* Good, because the layered model is predictable and follows the
  precedent established by Git's config hierarchy.
* Good, because the application works without any configuration; built-in
  templates are always available as the final fallback.
* Good, because the agent reports which template source is being used,
  giving the user visibility into customization.
* Good, because organization-level templates can be centrally managed
  in a `.naked-products` repository and automatically pulled by all
  team members.
* Neutral, because organization-level template fetching requires an
  additional GitHub API call; templates are cached locally to avoid
  repeated calls.
* Bad, because four levels of precedence increase the complexity of
  explaining the system to users.
* Bad, because invalid or malformed templates at a higher level silently
  fall back to the next level, which may be confusing if not communicated
  clearly.

## Pros and Cons of the Options

### Layered hierarchy (Project > User > Organization > Built-in)

* Good, because it follows the Git config model that developers already
  understand.
* Good, because it supports the full range of use cases: personal,
  team, and project-specific customization.
* Good, because the built-in fallback ensures the application always
  works without configuration.
* Bad, because it is the most complex option to implement and explain.

### Single user-level configuration file

* Good, because it is simpler than a four-level hierarchy.
* Bad, because it does not support project-level or organization-level
  overrides.
* Bad, because it requires the user to explicitly configure template
  paths rather than following a convention.

### Remote template registry

* Good, because templates can be versioned and shared publicly.
* Bad, because it requires network access and a template registry service
  to be available and maintained.
* Bad, because it adds a point of failure if the registry is unavailable.

### Built-in templates only

* Good, because it eliminates template resolution complexity entirely.
* Bad, because it forces all users to use the same templates, regardless
  of organizational standards.
* Bad, because it does not meet the PRD requirement for custom templates.

## More Information

* [Git configuration hierarchy](https://git-scm.com/book/en/v2/Customizing-Git-Git-Configuration)
* Custom templates PRD requirement: PROD-018
