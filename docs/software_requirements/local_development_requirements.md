# Local Development Software Requirements

This documents the software requirements for developing Naked Products locally
on your development computer. The following software is required for local
development:

1. [Git](#git)
1. [GitHub CLI](#github-cli)
1. [GitHub Copilot CLI](#github-copilot-cli)
1. [prek](#prek)
1. [Fast Node Manager](#fast-node-manager)
1. [Node.js](#nodejs)
1. [Squad CLI](#squad-cli)

## Git

| Operating System | Required? |
| ---------------- | --------- |
| Apple macOS | :white_check_mark: |
| Linux | :white_check_mark: |
| Microsoft Windows | :white_check_mark: |

[Git](https://git-scm.com) is a popular distributed version control system used
by many software developers to manage source code, track changes, and
collaborate. Git is a distributed version control system where each developer
maintains a complete clone of the repository, including all history and changes.
Developers can work offline and locally on their machine, and when they're
ready, Git makes it easy to share their changes with other developers either
directly or using a shared repository using a service such as
[GitHub](https://github.com).

- **Apple macOS or Linux:** [Homebrew](README.md#homebrew) can be used to
  install Git. In a terminal, run:

```bash
brew install git
```

- **Microsoft Windows:** [WinGet](https://learn.microsoft.com/en-us/windows/package-manager/winget/)
  can be used to install Git. In a PowerShell terminal, run:

```powershell
winget install --id Git.Git -e --source winget
```

## GitHub CLI

| Operating System | Required? |
| ---------------- | --------- |
| Apple macOS | :white_check_mark: |
| Linux | :white_check_mark: |
| Microsoft Windows | :white_check_mark: |

[GitHub CLI](https://cli.github.com) is a CLI tool for managing GitHub by
providing a CLI interface for the GitHub API. GitHub CLI can be used to automate
tasks for repositories and projects, running GitHub Actions workflows, and
performing other operations.

- **Apple macOS or Linux:** [Homebrew](README.md#homebrew) can be used to
  install GitHub CLI. In a terminal, run:

```bash
brew install gh
```

- **Microsoft Windows:** [WinGet](https://learn.microsoft.com/en-us/windows/package-manager/winget/)
  can be used to install GitHub CLI. In a PowerShell terminal, run:

```powershell
winget install --id GitHub.cli
```

## GitHub Copilot CLI

| Operating System | Required? |
| ---------------- | --------- |
| Apple macOS | :white_check_mark: |
| Linux | :white_check_mark: |
| Microsoft Windows | :white_check_mark: |

[GitHub Copilot CLI](https://github.com/features/copilot/cli/) is a terminal
version of [GitHub Copilot](https://github.com/features/copilot) that supports
software development in the terminal outside of any development tools.

- **Apple macOS or Linux:** [Homebrew](README.md#homebrew) can be used to
  install GitHub Copilot CLI. In a terminal, run:

```bash
brew install copilot-cli
```

- **Microsoft Windows:** [WinGet](https://learn.microsoft.com/en-us/windows/package-manager/winget/)
  can be used to install GitHub Copilot CLI. In a PowerShell terminal, run:

```powershell
winget install GitHub.Copilot
```

## prek

| Operating System | Required? |
| ---------------- | --------- |
| Apple macOS | :white_check_mark: |
| Linux | :white_check_mark: |
| Microsoft Windows | :white_check_mark: |

[prek](https://prek.j178.dev/) is a software tool that hooks into the
[Git](#git) commit process and runs validation tools before commits are
persisted to the Git repository. prek can be used to run linters, formatters,
and other tools that look for errors and prevent the errors from being committed
to the Git repository.

- **Apple macOS or Linux:** [Homebrew](README.md#homebrew) can be used to
  install prek. In a terminal, run:

```bash
brew install prek
```

- **Microsoft Windows:** [WinGet](https://learn.microsoft.com/en-us/windows/package-manager/winget/)
  can be used to install prek. In a PowerShell terminal, run:

```powershell
winget install --id j178.Prek
```

## Fast Node Manager

| Operating System | Required? |
| ---------------- | --------- |
| Apple macOS | :white_check_mark: |
| Linux | :white_check_mark: |
| Microsoft Windows | :white_check_mark: |

[Fast Node Manager](https://github.com/Schniz/fnm) is a version manager for
[Node.js](https://nodejs.org). Fast Node Manager can be used to install and
manage multiple versions of Node.js and switch between them automatically as
needed for different projects. When integrated into the shell, Fast Node Manager
will look for a file named [`.node-version`](../../.node-version) containing
the version number of Node.js that is required for a project. If found, Fast
Node Manager will install that version of Node.js (if necessary) and
automatically activate that version while you are working with the project's
source code.

- __Apple macOS or Linux:__ [Homebrew](README.md#homebrew) can be used to
  install Fast Node Manager. In a terminal, run:

```bash
curl -fsSL https://fnm.vercel.app/install | bash
```

- __Microsoft Windows:__ [WinGet](https://learn.microsoft.com/en-us/windows/package-manager/winget/)
  can be used to install Fast Node Manager. In a PowerShell terminal, run:

```powershell
winget install Schniz.fnm
```

## Node.js

| Operating System | Required? |
| ---------------- | --------- |
| Apple macOS | :white_check_mark: |
| Linux | :white_check_mark: |
| Microsoft Windows | :white_check_mark: |

[Node.js](https://nodejs.org) is a JavaScript runtime for building and running
programs. Node.js is great for development tools, CLI tools, desktop
applications, and can also be used to build web application and services.

We recommend using [Fast Node Manager](#fast-node-manager) to install Node.js.
The current required version of Node.js supported by Naked Products can be found
in the [`.node-version`](../../.node-version) file in the root directory of the
repository. To install Node.js, open a terminal and navigate to the repository
directory and run:

```bash
fnm use
```

## Squad CLI

| Operating System | Required? |
| ---------------- | --------- |
| Apple macOS | :white_check_mark: |
| Linux | :white_check_mark: |
| Microsoft Windows | :white_check_mark: |

[Squad](https://bradygaster.github.io/squad/) is an AI agent tool that simulates
having a team of developers to work on a software product. Squad plugs into
GitHub Copilot and interacts with you to complete software projects. Squad
breaks down work and assigns tasks to specialized agents that perform specific
type of work such as frontend development, backend development, DevOps,
architecture, or documentation.

It is recommended to install Squad CLI globally on your machine. In a terminal,
run:

```bash
npm install -g @bradygaster/squad-cli
```
