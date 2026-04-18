#!/usr/bin/env pwsh

# Setup.ps1
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
# Usage: &".Setup.ps1"

$ErrorActionPreference = "Stop"

# Install prek hooks
prek install --hook-type commit-msg --hook-type pre-push
