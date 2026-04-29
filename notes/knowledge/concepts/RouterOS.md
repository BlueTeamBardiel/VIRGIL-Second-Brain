# RouterOS

## What it is
Think of it as the brain transplanted into a generic PC that turns it into a full-featured Cisco-class router — but built by a Latvian company and running on Linux underneath. RouterOS is the proprietary network operating system developed by MikroTik, designed to run on their RouterBOARD hardware or as a software installation (CHR — Cloud Hosted Router) on virtual machines and x86 hardware.

## Why it matters
In 2018, the VPNFilter malware campaign specifically targeted MikroTik RouterOS devices, exploiting CVE-2018-14847 — a Winbox protocol vulnerability that allowed unauthenticated attackers to read arbitrary files, including the user database, extracting credentials in plaintext. This compromised hundreds of thousands of routers globally, turning them into proxy nodes for C2 traffic — a reminder that network infrastructure firmware is a high-value, often-neglected attack surface.

## Key facts
- **Winbox** is RouterOS's proprietary GUI management protocol (port 8291/TCP); CVE-2018-14847 allowed credential theft through it without authentication
- RouterOS exposes multiple management interfaces: Winbox, SSH, Telnet, HTTP/HTTPS, and an API port (8728/TCP) — each is an independent attack surface
- Default credentials (`admin` / blank password) are a well-known hardening failure point; many deployed devices are never changed
- RouterOS supports **Scripting + Scheduler**, which attackers abuse for persistence — malicious scripts can survive reboots if written to non-volatile storage
- The `/ip firewall filter` chain processes rules top-down with a **first-match wins** logic, similar to ACLs; misconfigured rules can expose management interfaces to WAN

## Related concepts
[[Network Device Hardening]] [[Credential Exposure]] [[Firmware Vulnerabilities]] [[Default Credentials]] [[Botnet Infrastructure]]