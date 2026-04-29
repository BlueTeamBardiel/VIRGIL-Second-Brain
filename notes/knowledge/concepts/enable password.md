# enable password

## What it is
Like a spare key hidden under the doormat — technically works, but anyone who knows where to look can grab it. The `enable password` command on Cisco IOS devices sets a password required to enter privileged EXEC mode, but stores that password in **plaintext** within the running and startup configuration files.

## Why it matters
During a penetration test, an attacker who gains read access to a Cisco router's configuration file — via SNMP misconfiguration, backup file exposure, or physical access — will immediately see the enable password in cleartext. This single credential then grants full administrative control over the device, allowing routing table manipulation, traffic interception, or complete network reconfiguration. This is precisely why `enable secret` (which uses MD5 hashing) replaced it as the standard.

## Key facts
- Stores the password in **plaintext** in the device configuration; readable by anyone who can view the config
- Superseded by **`enable secret`**, which uses MD5 hashing (though MD5 is itself now considered weak)
- If both `enable password` and `enable secret` are configured simultaneously, **`enable secret` takes precedence** and `enable password` is effectively ignored
- Running `show running-config` or `show startup-config` will expose the plaintext enable password to any logged-in user with sufficient privilege
- `service password-encryption` can obscure it with Cisco's weak Type 7 encoding, but this is trivially reversible and **not true encryption**

## Related concepts
[[enable secret]] [[privilege escalation]] [[Cisco IOS hardening]] [[plaintext credentials]] [[service password-encryption]]