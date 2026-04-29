# Fastfetch

## What it is
Like a valet who reads your car's make, model, VIN, and mileage at a glance before handing you the keys, Fastfetch is a system information tool that rapidly queries and displays detailed hardware and software specifications of a machine. It is a modern, actively maintained replacement for Neofetch, written in C for performance, that collects OS version, kernel, CPU, GPU, memory, uptime, and installed packages in a single terminal output.

## Why it matters
During a post-exploitation phase, an attacker who lands a shell on an unknown system will often run reconnaissance tools like Fastfetch (or invoke equivalent commands) to fingerprint the environment — identifying OS version, architecture, and resource constraints to select the right privilege escalation exploit. Defensively, blue teamers monitoring process execution logs (via EDR or auditd) should flag unexpected invocations of system enumeration utilities as potential indicators of compromise, since legitimate users rarely run them in production environments.

## Key facts
- Fastfetch is **not inherently malicious**, but its execution on a server — especially by a non-admin user — should trigger investigation under the principle of anomaly detection.
- It queries sources like `/proc`, `/sys`, and OS-specific APIs, meaning it requires **no elevated privileges** to gather significant system detail.
- Attackers performing **local enumeration** often replicate Fastfetch's queries manually (e.g., `uname -a`, `cat /etc/os-release`) to avoid dropping recognizable binaries.
- Fastfetch output can reveal **kernel version**, which directly maps to searchable CVEs for local privilege escalation exploits.
- Security baselines under **CIS Benchmarks** recommend auditing installed software and restricting package installation to limit attacker utility of tools like this.

## Related concepts
[[System Enumeration]] [[Post-Exploitation]] [[Living off the Land (LotL)]] [[Indicator of Compromise]] [[Privilege Escalation]]