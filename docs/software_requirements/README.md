# Software Requirements

This document provides instructions for installing the software applications and
packages that are required to build and run Naked Products from the source code.
The intended audience for this document are software developers and other
technical stakeholders who need to work directly with the product source code.
For other users, it is recommended that you download and use the
[latest release](https://github.com/mfcollins3/product/releases).

## Development Modes

There are two ways that you can work with the source code for Naked Products:

1. [Use a development container](#development-container-software-requirements)
1. [Develop locally on your computer](#local-development-software-requirements)

The preferred and recommended way to build and run Naked Products from the
source code is to the [development container](https://containers.dev). The
development container provides a stable Linux-based environment that is built
and pre-configured with the correct versions of all programming tools and
libraries. As changes to dependencies occur, these will be automatically
captured in the development container configuration and it makes it easier for
developers to stay up-to-date with Naked Product's requirements.

The development container can be run in [Visual Studio Code](https://code.visualstudio.com),
[JetBrains IDEs](https://jetbrains.com), or [GitHub Codespaces](https://github.com/features/codespaces).

## Platform Support

Naked Products runs on Apple macOS, Linux, and Microsoft Windows and will also
support local development on all three platforms. Not all required software is
required or compatible with all operating systems. The description of each
software requirement includes a table at the beginning indicating whether or not
the software package is required for your operating system. The following icons
are used to indicate whether a software package is required or not.

- :white_check_mark:: The software is required to be installed on your operating
  system.
- :grey_question:: The software package is optional for your operating system.
  We typically recommend installing it though.
- :x:: The software package is not supported or not necessary for your operating
  system.

## Required Software

The following software is required to be installed for all development modes:

1. [Homebrew](#homebrew)

### Homebrew

| Operating System | Required? |
| ---------------- | --------- |
| Apple macOS | :white_check_mark: |
| Linux | :white_check_mark: |
| Microsoft Windows | :x: |

[Homebrew](https://brew.sh) is a popular package management system for Apple
macOS and Linux users. Homebrew can be used to install many popular software
packages, programming language compilers, and development libraries. Homebrew
makes it easy to keep the software up-to-date as new versions are released.

To install Homebrew, open a terminal and run:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

After installing Homebrew, you will need to restart your terminal for the
environment changes to take effect.

## Development Container Software Requirements

See the [software requirements for development container development](development_container_requirements.md).

## Local Development Software Requirements

See the [software requirements for local development](local_development_requirements.md).
