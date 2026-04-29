# Wavlink WL-WN530H4

## What it is
Like a front door with a master key hidden under the welcome mat, the Wavlink WL-WN530H4 is a consumer Wi-Fi range extender that shipped with hardcoded credentials and unauthenticated remote code execution vulnerabilities baked into its firmware. It is a specific embedded networking device that became a case study in IoT insecurity due to critical flaws in its web management interface.

## Why it matters
In 2021, researchers discovered that the WL-WN530H4's web interface exposed shell command injection endpoints (`/cgi-bin/` scripts) without requiring authentication, meaning any attacker on the local network — or internet if the management interface was exposed — could execute arbitrary OS commands as root. This makes it a perfect pivot device: compromise the extender, own the entire LAN segment behind it.

## Key facts
- **CVE-2020-10971**: Unauthenticated command injection via the `hostname` parameter in the management interface, allowing root-level RCE
- The device runs a **BusyBox Linux** environment, giving attackers a full shell toolkit post-exploitation
- Default credentials (`admin/admin`) were never enforced to change during setup, violating basic security hygiene standards
- The management portal was accessible on **HTTP (port 80)** — no TLS — meaning credentials transmitted in cleartext
- Classified under **CWE-78 (OS Command Injection)** and **CWE-306 (Missing Authentication for Critical Function)** — both high-frequency CySA+ exam topics

## Related concepts
[[Command Injection]] [[Default Credentials]] [[IoT Security]] [[Unauthenticated Remote Code Execution]] [[Embedded Device Firmware Analysis]]