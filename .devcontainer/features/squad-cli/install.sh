#!/usr/bin/env bash

# Copyright 2026 Michael F. Collins, III
# Licensed under the Naked Products Source-Available Temporary License
# See LICENSE.md for license terms

# install.sh
#
# Installs the Squad CLI (@bradygaster/squad-cli) globally via npm so the
# squad command is available in the development container.
#
# Feature options are injected as environment variables by the devcontainer
# CLI before this script runs:
#   VERSION  The npm dist-tag or semver version to install (default: latest)

set -e

VERSION="${VERSION:-"latest"}"

echo "Installing @bradygaster/squad-cli@${VERSION}..."
npm install -g "@bradygaster/squad-cli@${VERSION}"

echo "Verifying squad CLI installation..."
squad --version

echo "squad CLI installed successfully."
