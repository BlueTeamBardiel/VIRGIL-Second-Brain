# PowerShell Overview

PowerShell is a cross-platform task automation solution combining a command-line shell, scripting language, and configuration management framework. It runs on Windows, Linux, and macOS and accepts/returns [[.NET]] objects rather than just text.

## Command-line Shell

- Modern shell with features from popular shells
- Robust command-line history and tab completion
- Command and parameter aliases
- Pipeline for chaining commands
- In-console help system similar to Unix `man` pages

## Scripting Language

- Built on [[.NET]] Common Language Runtime (CLR)
- Commonly used for system automation, testing, and deployment in [[CI/CD]] environments
- All inputs/outputs are .NET objects (no text parsing needed)
- Extensible through functions, classes, scripts, and modules
- Built-in support for CSV, JSON, and XML formats

## Automation Platform

PowerShell ecosystem includes modules for major platforms:
- **Microsoft**: Azure, Windows, Exchange, SQL
- **Third-party**: AWS, VMware, Google Cloud

## Configuration Management

[[PowerShell Desired State Configuration]] (DSC) enables enterprise infrastructure management:
- Declarative configurations and custom scripts for repeatable deployments
- Configuration drift enforcement and reporting
- Push or pull deployment models

## Related

- [[Monad Manifesto]] — Jeffrey Snover's vision document for PowerShell
- Getting started: Install PowerShell, Discover PowerShell, PowerShell 101
- Advanced: PowerShell remoting over SSH, Azure PowerShell, DSC CI/CD

## Tags

#powershell #automation #scripting #devops #microsoft #cli

---
_Ingested: 2026-04-15 20:19 | Source: https://learn.microsoft.com/en-us/powershell/scripting/overview_
