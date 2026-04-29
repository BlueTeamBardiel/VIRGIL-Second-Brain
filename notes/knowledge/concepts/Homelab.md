# Homelab

## What it is
Like a chef who practices new recipes in their home kitchen before serving guests at a restaurant, a homelab is a private, self-managed computing environment where security professionals safely experiment, break things, and rebuild them. Precisely, it is a personal infrastructure — physical or virtual — used for hands-on practice with operating systems, networking, attack techniques, and defensive tools outside of production systems.

## Why it matters
A SOC analyst preparing to detect lateral movement can spin up a homelab with a Windows Active Directory domain, deploy Splunk for log collection, and then simulate a pass-the-hash attack using Mimikatz — observing exactly which Event IDs (4624, 4648) appear and how to write detection rules. Without this sandboxed practice environment, that analyst would face real attackers before ever seeing what malicious telemetry actually looks like.

## Key facts
- Virtualization platforms like **Proxmox**, **VMware Workstation**, or **VirtualBox** are common homelab foundations, enabling multiple isolated OS instances on a single host
- A proper homelab should segment attack VMs (Kali Linux) from victim VMs using **host-only or internal networking** to prevent accidental exposure to the actual network
- Practicing in a homelab directly supports skills tested in **Security+ (SY0-701)** domains: network security, identity management, and threat detection
- Tools commonly deployed: **pfSense** (firewall), **Wazuh/Splunk** (SIEM), **Metasploitable** (intentionally vulnerable target), **Active Directory** (enterprise simulation)
- A homelab environment can simulate **MITRE ATT&CK** techniques safely, allowing defenders to map observable artifacts to specific adversary TTPs

## Related concepts
[[Virtual Machine]] [[Network Segmentation]] [[SIEM]] [[Active Directory]] [[Penetration Testing]]