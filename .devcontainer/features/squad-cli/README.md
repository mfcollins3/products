# Squad CLI — Dev Container Feature

Installs the [Squad CLI](https://bradygaster.github.io/squad/) globally via
`npm` so the `squad` command is available in every terminal session inside the
development container.

## Usage

Reference this local feature in your `devcontainer.json`:

```json
{
    "features": {
        "./features/squad-cli": {}
    }
}
```

To pin a specific release instead of always installing the latest version:

```json
{
    "features": {
        "./features/squad-cli": {
            "version": "0.9.1"
        }
    }
}
```

## Options

| Option | Type | Default | Description |
| --- | --- | --- | --- |
| `version` | `string` | `latest` | The npm dist-tag or semver version of `@bradygaster/squad-cli` to install. |

## Prerequisites

This feature requires Node.js and npm to be available in the container. It
declares an `installsAfter` dependency on
`ghcr.io/devcontainers/features/node`, which is already present in this
repository's `devcontainer.json`.

## Verification

After rebuilding the container, confirm that Squad is installed:

```plain
squad --version
```

## References

- [Squad documentation](https://bradygaster.github.io/squad/)
- [Installation guide](https://bradygaster.github.io/squad/docs/get-started/installation/)
- [npm: @bradygaster/squad-cli](https://www.npmjs.com/package/@bradygaster/squad-cli)
