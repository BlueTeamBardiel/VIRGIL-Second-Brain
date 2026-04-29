# Replication

## What it is
Like a photocopier that keeps making copies of itself until it fills every tray in the building, replication is the mechanism by which malware or data propagates copies of itself across systems, networks, or storage media. Precisely: replication is the automated duplication and distribution of code or data — in malware contexts, it's the defining behavior that separates self-spreading threats (viruses, worms) from inert malicious payloads.

## Why it matters
The 2017 WannaCry ransomware outbreak infected over 200,000 systems in 150 countries within 24 hours — not because victims clicked links, but because WannaCry used the EternalBlue exploit to replicate autonomously across networks via SMB port 445. Understanding replication mechanisms is why network segmentation and disabling unused protocols are fundamental defensive controls: they physically interrupt the replication pathway.

## Key facts
- **Viruses replicate by attaching** to host files and require human action (opening a file) to trigger replication; **worms replicate autonomously** by exploiting network vulnerabilities with no user interaction required.
- Replication can occur via **four main vectors**: network shares, removable media (USB), email attachments, and vulnerability exploitation.
- **Polymorphic malware** mutates its code with each replication cycle to evade signature-based detection while preserving its payload functionality.
- In database and directory contexts, replication refers to legitimate **Active Directory replication** — attackers abuse this via DCSync attacks to pull password hashes without touching LSASS directly.
- Security+ distinguishes replication as a key characteristic in malware **classification**: it determines whether a threat is categorized as a virus, worm, or non-replicating Trojan.

## Related concepts
[[Worms]] [[Polymorphic Malware]] [[DCSync Attack]] [[SMB Exploitation]] [[Network Segmentation]]