# Ncrack

## What it is
Like a locksmith who methodically tries every key on a ring against every door in a building — simultaneously — Ncrack is a high-speed, network authentication cracking tool designed to test credentials across multiple services and hosts in parallel. It was built by the Nmap project team and supports protocols like SSH, RDP, FTP, Telnet, HTTP, SMB, and more.

## Why it matters
During a penetration test against a corporate network, a red team operator uses Ncrack to spray a list of 500 common passwords across 200 SSH endpoints simultaneously — identifying that 12 servers still use `admin:admin` or `root:password` within minutes. Defenders use this same scenario to justify enforcing account lockout policies and deploying multi-factor authentication on remote access services.

## Key facts
- Ncrack uses a **modular architecture** similar to Nmap, with each protocol handled by a dedicated module (e.g., `ncrack -p ssh,rdp target`)
- Supports **timing controls** (`-T0` through `-T5`) to throttle attack speed and evade detection or avoid lockouts
- Unlike Hydra, Ncrack is specifically optimized for **reliability and scalability** across large network ranges, not just single-target brute force
- Can load credential lists using `--user` / `--pass` flags or combined wordlists, and integrates with **Nmap XML output** for target discovery
- Authentication cracking with Ncrack is a **post-reconnaissance** technique; it assumes port/service discovery (e.g., via Nmap) has already identified open services

## Related concepts
[[Hydra]] [[Credential Stuffing]] [[Brute Force Attack]] [[Account Lockout Policy]] [[Multi-Factor Authentication]]