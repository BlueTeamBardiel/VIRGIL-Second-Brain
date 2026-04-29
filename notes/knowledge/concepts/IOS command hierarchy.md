# IOS command hierarchy

## What it is
Think of it like a building with security clearance floors — the lobby lets anyone in, but the server room requires a badge, and the executive suite requires a badge *plus* a PIN. Cisco IOS organizes CLI access into privilege levels (0–15), where each level grants progressively more powerful commands. Level 1 is user EXEC mode (read-only, basic pings), level 15 is privileged EXEC mode (full control), and global configuration mode sits beneath that for making persistent changes.

## Why it matters
In a real-world scenario, an attacker who compromises a network device with only level 1 access can still run `show ip route` and map your entire internal network topology — intelligence that directly enables lateral movement. Defenders must restrict even low-privilege access and use `privilege level` commands to lock down which commands are visible at each tier, preventing reconnaissance through misconfigured read-only accounts.

## Key facts
- **User EXEC mode** (level 1): prompt is `>`, extremely limited — ping, traceroute, basic show commands only
- **Privileged EXEC mode** (level 15): prompt is `#`, accessed via `enable` command and password; full diagnostic and management access
- **Global Configuration mode**: entered from privileged EXEC via `configure terminal`; changes affect the entire device
- **Privilege levels 2–14** are customizable — admins can assign specific commands to intermediate levels for role-based access control (RBAC)
- Default `enable secret` uses MD5 hashing; `enable password` stores in cleartext — always prefer `enable secret` and use `service password-encryption` for all other passwords

## Related concepts
[[Role-Based Access Control]] [[AAA Authentication]] [[Network Device Hardening]]