# Development Container Software Requirements

This document presents the software requirements for using the
[development container](https://containers.dev) for building, running, and
contributing to Naked Products. To build and use the development container, you
will need to install the following software:

1. [Nerd Fonts](#nerd-fonts)
1. [Docker Desktop](#docker-desktop)
1. [Visual Studio Code](#visual-studio-code)
1. [Remote Development Extension Pack for Visual Studio Code](#remote-development-extension-pack-for-visual-studio-code)

## Nerd Fonts

| Operating System | Required? |
| ---------------- | --------- |
| Apple macOS | :white_check_mark: |
| Linux | :white_check_mark: |
| Microsoft Windows | :white_check_mark: |

The development container uses [Oh My Posh](https://ohmyposh.dev/) in the
terminal. Oh My Posh makes use of [Nerd Fonts](https://www.nerdfonts.com/) to
show the status of the workspace and other indicators. For these icons to
display correctly, you must install the MesloLGM nerd font.

- **Apple macOS or Linux:** [Homebrew](README.md#homebrew) can be used to
  install the nerd font. In a terminal, run:

```bash
brew install font-meslo-lg-nerd-font
```

- **Microsoft Windows:** The nerd font can be installed using PowerShell. In a
  PowerShell terminal, run:

```powershell
Install-PSResource -Name NerdFonts
Import-Module -Name NerdFonts
Install-NerdFont -Name 'Meslo'
```

## Docker Desktop

| Operating System | Required? |
| ---------------- | --------- |
| Apple macOS | :white_check_mark: |
| Linux | :white_check_mark: |
| Microsoft Windows | :white_check_mark: |

[Docker Desktop](https://www.docker.com/products/docker-desktop/) is a suite of
tools for building and running container images on your development computer.
Docker Desktop is needed to build and run the development container. To install
Docker Desktop, download the installer from the
[Docker website](https://www.docker.com/products/docker-desktop/).

## Visual Studio Code

| Operating System | Required? |
| ---------------- | --------- |
| Apple macOS | :white_check_mark: |
| Linux | :white_check_mark: |
| Microsoft Windows | :white_check_mark: |

[Visual Studio Code](https://code.visualstudio.com) is a popular free and open
source text editor and development environment created by
[Microsoft](https://www.microsoft.com). Visual Studio Code has a
[large ecosystem of extensions](https://marketplace.visualstudio.com/VSCode)
that add support for most programming lanauges, sofrware development tools, and
supporting file formats. You can install Visual Studio Code by downloading the
installer for your operating system from the
[Visual Studio Code website](https://code.visualstudio.com).

## Remote Development Extension Pack for Visual Studio Code

| Operating System | Required? |
| ---------------- | --------- |
| Apple macOS | :white_check_mark: |
| Linux | :white_check_mark: |
| Microsoft Windows | :white_check_mark: |

[Remote Development Extension Pack](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack)
is a set of extensions for [Visual Studio Code](#visual-studio-code) that
support using Visual Studio code to connect to remote computers or virtual
environments such as development containers or container images for development.
Remote Development Extension Pack implements support for development containers
in Visual Studio Code. Remote Development Extension Pack installs a server
component on the target machine so Visual Studio Code can connect to the remote
computer or virtual machine and act as a client for developing on the remote
computer or virtual machine. Install Remote Development Extension Pack from the
[Visual Studio Code Marketplace](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack).
