# Winget

## What it is
Think of Winget like a vending machine for software — you type the name, it fetches and installs the exact package without you hunting through websites. Precisely, Winget (Windows Package Manager) is Microsoft's official CLI tool introduced in Windows 10/11 that automates software installation, upgrade, and removal by pulling packages from the Microsoft Store and the WinGet Community Repository.

## Why it matters
Attackers have begun abusing Winget in **Living-off-the-Land (LotL)** attacks — because it's a Microsoft-signed binary, it can bypass application whitelisting controls while silently installing attacker-chosen tools (e.g., remote access utilities like `winget install AnyDesk`). Defenders use Winget in hardening scripts to rapidly patch known-vulnerable software across an enterprise fleet, directly reducing the attack surface exposed by unpatched applications.

## Key facts
- Winget is a **LOLBin (Living-off-the-Land Binary)** candidate — its legitimate Microsoft signature can bypass security controls that trust MS-signed executables
- The command `winget upgrade --all` patches every installed application at once — making it a powerful tool for reducing **mean time to patch (MTTP)**
- Winget sources packages from the **WinGet Community Repository** hosted on GitHub, meaning a compromised repository entry is a supply chain attack vector
- Winget requires **administrative privileges** for system-wide installs but can install user-scoped packages without elevation, widening its abuse potential
- Audit Winget activity via **Windows Event Logs** and PowerShell script block logging; execution appears under `winget.exe` in process telemetry

## Related concepts
[[Living-off-the-Land Binaries]] [[Supply Chain Attack]] [[Application Whitelisting]] [[Patch Management]]