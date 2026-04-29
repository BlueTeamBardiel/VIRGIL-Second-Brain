# Netmiko

## What it is
Think of it like a universal TV remote that speaks the native language of every brand — Netmiko is a Python library that standardizes SSH connections across dozens of network device vendors (Cisco, Juniper, Palo Alto, Fortinet) so you can send commands and receive output without hand-crafting vendor-specific session handling. It wraps Paramiko (raw SSH) into a device-aware abstraction layer.

## Why it matters
During a network security audit or incident response, an analyst needs to rapidly query hundreds of routers and switches for suspicious routes, ACL changes, or unauthorized users. Netmiko enables automated collection of `show` command output across a mixed-vendor environment in minutes rather than hours — the difference between catching lateral movement in progress versus finding evidence after the fact. Conversely, attackers with stolen credentials can weaponize Netmiko scripts to bulk-modify firewall rules or exfiltrate running configurations at scale.

## Key facts
- Built on top of **Paramiko** (Python SSH library); adds vendor-specific prompt handling, timing controls, and `send_command()` / `send_config_set()` abstractions
- Supports **60+ device types** including Cisco IOS, NX-OS, ASA, Junos, Arista EOS, and Palo Alto PAN-OS
- Used heavily in **network automation and compliance auditing** — scripting config backups, checking patch levels, or validating security baselines across all devices simultaneously
- Credentials are passed in plaintext dictionaries by default; **secrets management** (Vault, environment variables) is a critical hardening step to avoid credential exposure in scripts
- Relevant to **CySA+** in the context of scripting for threat hunting, automated evidence collection, and configuration drift detection

## Related concepts
[[Paramiko]] [[Network Automation]] [[SSH Hardening]] [[Configuration Management]] [[Credential Exposure]]