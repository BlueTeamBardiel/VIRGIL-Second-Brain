# systemd service implant

## What it is
Like hiding a parasite inside a host's immune system so it restarts itself every time the host fights back, a systemd service implant embeds malicious code as a legitimate-looking `.service` unit file, ensuring the operating system itself resurrects the payload after every reboot or crash. Precisely: it is a persistence mechanism where an attacker creates or modifies a systemd unit file (stored in `/etc/systemd/system/` or `/lib/systemd/system/`) to execute malicious binaries automatically under the guise of a normal system service.

## Why it matters
In the 2022 Linux malware campaign deploying **OrBit**, attackers dropped a rogue systemd service that re-launched their rootkit loader after every reboot, surviving both manual kill commands and basic incident response wipes of running processes. Defenders who only examined running processes missed it entirely — the threat wasn't found until analysts inspected unit files directly.

## Key facts
- **Primary persistence paths**: `/etc/systemd/system/`, `/usr/lib/systemd/system/`, and per-user scope at `~/.config/systemd/user/` — the user-scope path often evades system-level auditing.
- **Detection command**: `systemctl list-units --type=service --state=enabled` exposes all enabled services; unusual names or paths are red flags.
- **`ExecStartPre=` abuse**: attackers use pre-start directives to execute secondary payloads before the decoy "legitimate" service launches, burying malicious activity in the startup chain.
- **Log evasion**: malicious services commonly set `StandardOutput=null` and `StandardError=null` to suppress journald logging.
- **Privilege context**: services installed system-wide run as root by default unless `User=` is specified, granting immediate high-privilege execution.

## Related concepts
[[persistence mechanisms]] [[Linux privilege escalation]] [[cron job implant]] [[rootkit]] [[MITRE ATT&CK T1543.002]]