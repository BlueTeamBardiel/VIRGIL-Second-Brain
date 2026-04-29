# PowerShell Desired State Configuration

## What it is
Like a building inspector who continuously checks that every room matches the approved blueprint and immediately fixes unauthorized renovations, DSC is a PowerShell management platform that enforces and maintains a declared system configuration. It defines the *desired* state of a Windows system (installed software, registry keys, services, file permissions) and continuously monitors and corrects drift from that baseline.

## Why it matters
Attackers abuse DSC as a living-off-the-land technique: a compromised administrator can push a malicious `.mof` configuration file that installs backdoors or disables security tools across hundreds of endpoints simultaneously, all using legitimate Windows management channels that blend into normal traffic. Defenders use the same mechanism defensively — enforcing that Windows Defender remains enabled, audit policies stay intact, and unauthorized local admin accounts are automatically removed.

## Key facts
- DSC uses **Managed Object Format (.mof) files** to describe desired configuration; these files are compiled from PowerShell scripts and can be weaponized to deploy malicious payloads
- Two modes: **Push** (admin sends config directly to node) and **Pull** (nodes periodically fetch configs from a central Pull Server over HTTP/HTTPS)
- The **Local Configuration Manager (LCM)** is the engine on each node that applies and enforces DSC configurations — a prime target for tampering
- DSC activity is logged under **Microsoft-Windows-DSC/Operational** event log; absence of these logs on an active system can indicate log tampering
- Malicious `.mof` files can execute arbitrary code via the `Script` resource block, making them a fileless execution vector that bypasses many AV solutions

## Related concepts
[[Living Off the Land Binaries (LOLBins)]] [[Windows Management Instrumentation (WMI)]] [[Group Policy Objects (GPO)]]