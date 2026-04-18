#!/usr/bin/env bash

# setup.sh
#
# This program automates the process of preparing the development workspace for
# the Naked Products product. This program will install the dependencies and
# development tools needed to build, run, and test the product. This program
# will also install hooks that will run before commits and in response to other
# Git events on the local repository.
#
# This program only needs to be run once, immediately after cloning the
# repository.
#
# Usage: ./setup.sh

set -e

# Install prek hooks
prek install --hook-type commit-msg --hook-type pre-push
