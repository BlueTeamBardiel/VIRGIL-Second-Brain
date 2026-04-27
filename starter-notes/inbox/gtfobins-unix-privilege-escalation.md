# GTFOBins: Unix Privilege Escalation

GTFOBins is a curated compendium of Unix-like executables that can be abused to bypass local security restrictions, escalate privileges, and facilitate post-exploitation tasks in misconfigured systems. It documents legitimate functions of common binaries that can be weaponized for security testing and authorized penetration testing.

## Overview

GTFOBins catalogs how to "live off the land" using standard Unix utilities when restricted to limited executables. The project focuses on abuse techniques rather than software vulnerabilities.

## Exploitation Categories

**Functions:**
- Shell spawning
- Command execution
- Reverse/bind shells
- File read/write operations
- File upload/download
- Library loading
- Privilege escalation
- Capability inheritance

**Privilege Escalation Contexts:**
- Unprivileged user execution
- [[Sudo]] abuse
- [[SUID]] binaries
- [[Linux Capabilities]] exploitation

## Common Vulnerable Binaries

- `apt`/`apt-get` — package managers with privilege escalation vectors
- `apport-cli` — crash report handler
- `ansible-playbook` — automation with elevated execution
- `apache2`/`apache2ctl` — web server misconfigurations
- `agetty` — terminal emulator
- `7z` — archive extraction
- And hundreds more documented at the source

## Resources

- **Official Site:** https://gtfobins.github.io/
- **GitHub:** Collaborative contributions welcome
- **JSON API:** Machine-readable format available
- **Related:** [[LOLBAS]] for Windows equivalents
- **Integration:** MITRE ATT&CK Navigator support

## Tags

#privilege-escalation #linux #sysadmin #post-exploitation #shell-escape #security-hardening

---
_Ingested: [[2026-04-15]] 22:04 | Source: https://gtfobins.github.io/_
