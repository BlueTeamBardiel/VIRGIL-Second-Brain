# Subiquity

## What it is
Think of Subiquity as the GPS navigation system for installing Ubuntu — it guides the OS installation process step by step, making decisions about partitioning, networking, and user configuration. Precisely, Subiquity is the modern server installer framework used by Ubuntu Server (18.04+), replacing the older debian-installer with a Python-based, cloud-init-integrated system that supports both interactive and automated "autoinstall" deployments via YAML configuration files.

## Why it matters
In enterprise environments, attackers who gain access to a PXE boot server can inject a malicious `autoinstall` YAML file, causing any machine that network-boots to receive a compromised OS image with backdoor user accounts or weakened SSH configurations — all before the system admin even touches the machine. Defenders use Subiquity's autoinstall feature legitimately to enforce hardened baseline configurations (CIS benchmarks) at provisioning time, ensuring every server is born secure rather than patched into compliance later.

## Key facts
- Subiquity uses **cloud-init** under the hood, meaning its autoinstall YAML files follow a structure security teams must audit just like cloud provisioning templates
- The autoinstall file can configure **storage encryption (LUKS)**, user accounts, SSH authorized keys, and package installation — making it a high-value target if stored insecurely in a PXE/TFTP environment
- **TFTP servers** hosting Subiquity autoinstall configs transmit data in **cleartext by default**, making them vulnerable to interception on untrusted networks
- Misconfigured autoinstall files have been found in **public GitHub repositories**, exposing internal network topology, credentials, and SSH keys
- Subiquity replaced `debian-installer` (d-i) starting with **Ubuntu 20.04 LTS** as the default server installer

## Related concepts
[[PXE Boot]] [[Cloud-Init]] [[LUKS Encryption]] [[TFTP Security]] [[Supply Chain Attack]]