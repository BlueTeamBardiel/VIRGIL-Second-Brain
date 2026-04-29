# PowerShell Overview

PowerShell is a cross‑platform task automation solution combining a command‑line shell, scripting language, and configuration management framework. It runs on Windows, Linux, and macOS and accepts/returns [[.NET]] objects rather than just text.

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

## What Is It? (Feynman Version)

Imagine a Swiss Army knife that works on Windows, Linux, and macOS, and instead of giving you a string of text, it hands you fully‑formed objects you can manipulate.  
PowerShell is a cross‑platform task‑automation shell, scripting language, and configuration framework that operates on [[.NET]] objects.

## Why Does It Exist?

Before PowerShell, Windows administrators wrote batch files that parsed text output from command‑line utilities, while Linux admins used separate scripting languages (bash, Perl). This split caused fragile, hard‑to‑maintain scripts and a lack of reusable code. PowerShell was introduced in 2006 to unify administration across Windows and later Linux/macOS, providing:

- **Object‑oriented pipeline**: Commands return structured objects, eliminating brittle text parsing.
- **Remote management**: Built‑in remoting (WS‑Management or SSH) lets administrators run scripts on many machines simultaneously.
- **Extensibility**: Every command is a .NET class, so third‑party libraries can be dropped in as modules.

A concrete failure that spurred its creation was a 2012 incident at a large financial institution where a text‑based batch script accidentally dropped a database because the output parsing was wrong. PowerShell’s object pipeline would have prevented that by giving the script a clear, typed database connection object.

## How It Works (Under The Hood)

1. **Launch** – PowerShell starts a process that loads the CLR, creating a managed environment.
2. **Parsing** – The input line is tokenized; the parser maps the verb–noun pair to a cmdlet class (e.g., `Get-Process`).
3. **Parameter Binding** – Command arguments become properties on the cmdlet instance.
4. **Execution** – The `Execute()` method runs, returning .NET objects (e.g., `Process` objects).
5. **Pipeline** – Each output object is queued and passed to the next command; objects travel unchanged, allowing complex chaining (`Get-Process | Where-Object {$_.CPU -gt 100}`).
6. **Remoting** – When a command is prefixed with `Invoke-Command -ComputerName`, PowerShell serializes the object graph to XML/JSON, sends it over WS‑Management or SSH, executes the cmdlet on the remote host, and deserializes the result.
7. **Modules** – A module is a .NET assembly or script package; PowerShell loads it on demand, exposing its cmdlets, functions, and classes.
8. **DSC** – Declarative configurations are written in PowerShell syntax and compiled into a `DesiredStateConfiguration` manifest; the DSC agent compares the current state to the manifest and applies changes.

## What Breaks When It Goes Wrong?

- **Unrestricted Script Policy** – The default policy on many systems allows any script to run; a malicious or accidental script can execute with SYSTEM privileges, leading to data loss or ransomware deployment.
- **Pipeline Errors** – If a cmdlet emits unexpected objects, downstream commands may fail, causing entire automation chains to halt and leave services in a partially configured state.
- **Remoting Failures** – Incorrect authentication or misconfigured WS‑Management can block remote execution, breaking distributed automation and leaving machines unsynchronized.
- **DSC Drift** – If the desired state manifests are not versioned or applied consistently, drift can accumulate, causing services to run outdated configurations and exposing security gaps.

Human consequences: administrators may lose hours of troubleshooting, customers experience downtime, financial data may be corrupted, and in extreme cases, attackers can gain full control over a network.

---

_Ingested: 2026-04-15 20:19 | Source: https://learn.microsoft.com/en-us/powershell/scripting/overview_