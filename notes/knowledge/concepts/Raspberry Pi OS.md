# Raspberry Pi OS

## What it is
Think of it as a Swiss Army knife running on a credit-card-sized computer — a full operating system squeezed onto a microSD card. Raspberry Pi OS (formerly Raspbian) is a Debian-based Linux distribution optimized for the Raspberry Pi hardware platform, providing a complete desktop environment, command-line tools, and development utilities on low-cost single-board computers.

## Why it matters
A red teamer can drop a Raspberry Pi running Raspberry Pi OS behind a target company's network switch — acting as a persistent, inconspicuous implant that phones home over a reverse SSH tunnel. Because it looks like harmless office hardware and draws minimal power, it can persist undetected for weeks, exfiltrating credentials or pivoting deeper into internal subnets. Defenders counter this with physical security controls, network access control (NAC), and 802.1X port authentication to prevent rogue device attachment.

## Key facts
- **Default credentials risk:** Early versions shipped with default username `pi` and password `raspberry` — a classic hardcoded credential vulnerability directly relevant to CIS Controls and Security+ exam scenarios.
- **Debian heritage:** Inherits Debian's `apt` package manager and security update model; unpatched packages represent the same CVE exposure as any Linux server.
- **Headless mode:** Can run without a monitor/keyboard, making it ideal for covert physical implants (a documented physical penetration testing technique).
- **Kali Linux alternative:** Security professionals often swap Raspberry Pi OS for Kali Linux ARM builds on the same hardware, turning it into a portable attack platform.
- **SSH enabled by default:** Older images had SSH enabled out-of-the-box; current images require explicit activation, directly addressing the "unnecessary services" hardening principle.

## Related concepts
[[Physical Penetration Testing]] [[Default Credentials]] [[Network Access Control (NAC)]] [[Rogue Device Detection]] [[Linux Hardening]]