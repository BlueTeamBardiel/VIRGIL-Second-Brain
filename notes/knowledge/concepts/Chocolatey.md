# Chocolatey

## What it is
Think of it like an app store for Windows that runs entirely from the command line — you type one command and software installs itself, no clicking through wizards. Chocolatey is a Windows package manager that automates software installation, updates, and removal by pulling packages from a central repository, similar to how `apt` works on Debian Linux systems.

## Why it matters
In enterprise environments, attackers who gain a foothold can abuse Chocolatey to silently install malicious tools (netcat, mimikatz wrappers) without triggering traditional installer alerts, since `choco install` runs as a legitimate process. Defenders use Chocolatey in hardening scripts to rapidly deploy and patch software across fleets, ensuring consistent, auditable installations — critical for reducing the attack surface from unpatched third-party apps.

## Key facts
- Chocolatey runs with elevated privileges by default (`choco install` typically requires admin rights), making it a high-value target for privilege abuse
- Packages are pulled from the Chocolatey Community Repository (chocolatey.org) or private internal feeds — supply chain attacks can target these feeds with trojanized packages
- Commands follow predictable syntax: `choco install <package>`, `choco upgrade all`, `choco uninstall <package>` — all leave artifacts in Windows Event Logs
- In a SOC context, unexpected `choco.exe` execution in process logs (especially spawned by non-admin users or scripts) should trigger investigation
- Chocolatey integrates with configuration management tools like Ansible, Puppet, and Chef — making it relevant in DevSecOps and infrastructure-as-code security reviews

## Related concepts
[[Package Manager Security]] [[Supply Chain Attack]] [[Living Off the Land (LOLBins)]] [[Windows Event Logging]] [[Privilege Escalation]]