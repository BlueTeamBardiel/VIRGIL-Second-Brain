# sshd_config Hardening

## What it is
Think of sshd_config as the bouncer's rulebook for your SSH nightclub — it decides who gets ID'd, what IDs are accepted, and which back doors stay permanently welded shut. It is the primary configuration file for the OpenSSH daemon (`/etc/ssh/sshd_config`) that controls authentication methods, access controls, encryption algorithms, and session behavior for all incoming SSH connections.

## Why it matters
In the 2020 SolarWinds-era lateral movement playbook, attackers who gained initial footholds frequently pivoted via SSH using password spraying and default credentials — attacks that a properly hardened sshd_config would have blocked by disabling password authentication entirely and restricting login to named accounts only. Enforcing key-based authentication alone eliminates an entire class of brute-force attacks at zero cost.

## Key facts
- **`PermitRootLogin no`** — disables direct root SSH access; attackers must compromise a regular account first, adding a required escalation step
- **`PasswordAuthentication no`** — forces public key authentication, eliminating brute-force and credential-stuffing attacks against SSH
- **`Protocol 2`** — SSHv1 has known cryptographic flaws (e.g., CRC-32 compensation attack); SSHv2 is the only acceptable protocol
- **`AllowUsers` / `AllowGroups`** — explicit allowlisting of permitted users enforces least privilege at the daemon level
- **`MaxAuthTries 3`** and **`LoginGraceTime 30`** — limit authentication attempts and connection windows, slowing automated attack tools and reducing exposure time

## Related concepts
[[Public Key Infrastructure]] [[Principle of Least Privilege]] [[Brute Force Attack Mitigation]]