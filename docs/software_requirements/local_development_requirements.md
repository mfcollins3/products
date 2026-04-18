# Local Development Software Requirements

This documents the software requirements for developing Naked Products locally
on your development computer. The following software is required for local
development:

1. [Git](#git)
1. [GitHub CLI](#github-cli)
1. [GitHub Copilot CLI](#github-copilot-cli)
1. [prek](#prek)

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
