# Use Google Distroless as the Container Base Image

* Status: Proposed
* Date: 2026-04-20

## Context and Problem Statement

Naked Products provides a container image as an alternative installation
method (see [ADR-0008](0008-distribute-via-platform-native-packages.md)).
The container image must include the Node.js runtime, `git`, the GitHub
CLI (`gh`), and the GitHub Copilot CLI. A base image must be chosen that
balances security, image size, and ease of including the required tools.

A secondary decision is whether to use Docker multi-stage builds (building
inside Docker) or to build the application in the GitHub Actions CI
pipeline and copy the pre-built output into the final image.

## Decision Drivers

* The container image should have a minimal attack surface; unused tools,
  shells, and package managers should not be present in the production
  image.
* The image must include `git`, `gh`, and the GitHub Copilot CLI, which
  are required runtime dependencies.
* The build process should leverage GitHub Actions dependency caching to
  avoid redundant `npm install` runs across CI jobs.
* The image must support linux/amd64 and linux/arm64 architectures.

## Considered Options

**Base image:**

* Google distroless (`gcr.io/distroless/nodejs24-debian12`)
* `node:24-alpine`
* `node:24-slim`

**Build strategy:**

* Build in CI, copy artifacts into the final image
* Docker multi-stage build (build inside Docker)

## Decision Outcome

Chosen option: "Google distroless base image with CI-built artifacts",
because distroless provides the smallest attack surface by excluding a
shell and package manager from the production image, and building in CI
allows GitHub Actions dependency caching to be applied before the Docker
build step.

The CI pipeline runs `npm ci` and the TypeScript build with caching, then
the Dockerfile copies the pre-built output into the distroless base image.
The required CLI tools (`git`, `gh`, Copilot CLI) are added via a custom
intermediate layer before the distroless base.

### Consequences

* Good, because distroless images contain no shell, package manager, or
  unnecessary system utilities, significantly reducing the attack surface.
* Good, because building outside Docker leverages GitHub Actions
  dependency caching, reducing CI build times.
* Good, because the final image is smaller than images built from
  `node:alpine` or `node:slim` due to the absence of build tools.
* Neutral, because debugging a distroless container requires attaching a
  separate debug sidecar, as there is no shell.
* Bad, because adding `git`, `gh`, and Copilot CLI to a distroless image
  requires additional Dockerfile complexity (custom layers or copying
  binaries from an intermediate image).

## Pros and Cons of the Options

### Google distroless (`gcr.io/distroless/nodejs24-debian12`)

* Good, because it contains only the Node.js runtime and its minimal
  OS dependencies — no shell, no package manager.
* Good, because it is maintained by Google and tracks security patches
  for the included components.
* Good, because it produces the smallest final image size for a Node.js
  application.
* Bad, because adding extra binaries (`git`, `gh`) requires copying them
  from an intermediate builder image, adding Dockerfile complexity.

### `node:24-alpine`

* Good, because Alpine-based images are small and use musl libc.
* Good, because Alpine includes `apk` for installing additional packages.
* Bad, because musl libc can cause compatibility issues with some native
  Node.js modules.
* Bad, because Alpine includes a shell and package manager, increasing
  the attack surface relative to distroless.

### `node:24-slim`

* Good, because slim images are Debian-based and include `apt` for
  installing `git` and other dependencies.
* Good, because Debian compatibility avoids the musl libc issues of
  Alpine.
* Bad, because slim images include a shell (`bash`) and `apt`, which are
  not needed in the production image and increase the attack surface.
* Bad, because slim images are larger than both distroless and Alpine.

### Build in CI, copy artifacts into final image

* Good, because CI dependency caching (`npm ci`) is reused across
  multiple jobs without duplicating work inside Docker.
* Good, because the Dockerfile is simpler; it only needs a `COPY`
  instruction for the pre-built output.
* Neutral, because the CI environment and the container environment must
  be compatible (same OS/libc) for the built artifacts to work.

### Docker multi-stage build

* Good, because the entire build is self-contained in the Dockerfile,
  making it reproducible outside CI.
* Bad, because the build stage runs inside Docker and cannot leverage
  GitHub Actions' native dependency caching.
* Bad, because multi-stage builds increase Dockerfile complexity and
  build time in CI.

## More Information

* [Google distroless images](https://github.com/GoogleContainerTools/distroless)
* [distroless Node.js image](https://github.com/GoogleContainerTools/distroless/blob/main/nodejs/README.md)
* [Docker multi-arch builds with buildx](https://docs.docker.com/buildx/working-with-buildx/)
