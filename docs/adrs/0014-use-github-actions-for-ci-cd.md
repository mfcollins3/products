# Use GitHub Actions for CI/CD

* Status: Proposed
* Date: 2026-04-20

## Context and Problem Statement

Naked Products must be automatically built, tested, and packaged across six
platform/architecture combinations (macOS x64, macOS ARM64, Linux x64,
Linux ARM64, Windows x64, Windows ARM64) on every pull request and merge to
main. Release builds must produce signed native packages, a multi-arch
container image, and publish to GitHub Releases.

A CI/CD platform must be chosen that can support this matrix build, GitHub
Releases publishing, and integration with the GitHub repository.

## Decision Drivers

* The CI/CD platform must integrate natively with GitHub for pull request
  status checks and GitHub Releases publishing.
* The platform must provide hosted runners for macOS, Linux, and Windows
  to build platform-native packages without requiring self-hosted
  infrastructure.
* The platform must support matrix builds to build all six
  platform/architecture combinations in parallel.
* The platform must support reusable workflow components to avoid
  duplicating build logic.
* Caching of Node.js dependencies (`node_modules`) must be supported
  to reduce build times.

## Considered Options

* GitHub Actions
* CircleCI
* Jenkins (self-hosted)
* GitLab CI

## Decision Outcome

Chosen option: "GitHub Actions", because the repository is hosted on
GitHub, making GitHub Actions the tightest native integration. GitHub
Actions provides hosted macOS, Linux, and Windows runners, supports
matrix builds, and has a rich ecosystem of community actions for Node.js,
Docker, and GitHub Releases.

### Workflow structure

The CI/CD pipeline is structured around the following workflows:

```plain
.github/
└── workflows/
    ├── ci.yml          # PR validation: lint, test, build
    ├── release.yml     # Release: package, container, publish
    └── pr-checks.yml   # PR labeling, size checks
```

The `ci.yml` workflow runs on every push and pull request. The
`release.yml` workflow runs on version tags (`v*.*.*`).

### Consequences

* Good, because GitHub Actions is natively integrated with GitHub
  repositories, pull requests, and GitHub Releases.
* Good, because hosted macOS, Linux, and Windows runners eliminate the
  need for self-hosted CI infrastructure.
* Good, because the matrix build strategy allows all six
  platform/architecture targets to build in parallel.
* Good, because the community Actions ecosystem provides pre-built
  actions for Node.js setup, Docker buildx, and GitHub Release
  publishing.
* Neutral, because the macOS hosted runners cost more credits than
  Linux runners on GitHub's billing model for private repositories;
  this is acceptable for a public repository.
* Bad, because GitHub Actions YAML syntax can become complex for
  large matrix builds; reusable workflows (`workflow_call`) mitigate
  this.

## Pros and Cons of the Options

### GitHub Actions

* Good, because it is natively integrated with GitHub and requires no
  additional authentication or webhook configuration.
* Good, because it provides hosted macOS, Linux, and Windows runners.
* Good, because it supports matrix builds and reusable workflows.
* Good, because it supports OIDC-based authentication to cloud providers
  for future deployment workflows.
* Bad, because GitHub Actions YAML can become verbose for complex
  pipelines.

### CircleCI

* Good, because it has a mature pipeline configuration model and strong
  caching support.
* Bad, because it requires configuring a third-party integration with the
  GitHub repository.
* Bad, because it does not provide native macOS runners at the same level
  of availability as GitHub Actions.

### Jenkins (self-hosted)

* Good, because it provides maximum control over the build environment.
* Bad, because it requires operating and maintaining self-hosted
  infrastructure, which is out of scope for this project.
* Bad, because it does not integrate natively with GitHub Releases.

### GitLab CI

* Good, because it is a fully-featured CI/CD platform with built-in
  container registry.
* Bad, because the repository is on GitHub, not GitLab; using GitLab CI
  requires mirroring or webhooks.
* Bad, because GitLab CI is optimized for GitLab-hosted repositories.

## More Information

* [GitHub Actions documentation](https://docs.github.com/en/actions)
* [GitHub Actions matrix builds](https://docs.github.com/en/actions/using-jobs/using-a-matrix-for-your-jobs)
* [Reusable workflows](https://docs.github.com/en/actions/sharing-automations/reusing-workflows)
* [`actions/setup-node`](https://github.com/actions/setup-node)
* [`docker/build-push-action`](https://github.com/docker/build-push-action)
