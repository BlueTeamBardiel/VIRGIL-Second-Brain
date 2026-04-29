# Expansion

## What it is
Like a sponge that absorbs water and becomes ten times its original size, expansion in cybersecurity refers to the phase of an attack where an adversary broadens their foothold — moving laterally across systems, escalating privileges, and increasing their presence within a compromised environment. Precisely, it is the post-initial-access stage where threat actors grow their control surface to maximize impact or persistence.

## Why it matters
During the 2020 SolarWinds supply chain attack, once actors gained initial access via the poisoned Orion update, they expanded aggressively — moving laterally through victim networks using forged SAML tokens (Golden SAML attack) to access cloud resources far beyond the original beachhead. Detecting expansion early — through anomalous authentication logs or unusual service account behavior — is the primary goal of behavioral analytics in a SOC environment.

## Key facts
- Expansion maps to the **Lateral Movement** and **Privilege Escalation** tactics in the MITRE ATT&CK framework (TA0008, TA0004)
- Common expansion techniques include Pass-the-Hash, Pass-the-Ticket, and exploitation of misconfigured trust relationships between systems
- Network segmentation and least-privilege principles are the primary architectural controls that *limit* expansion radius
- CySA+ expects analysts to identify expansion via indicators like new admin account creation, unusual SMB traffic, or Kerberoasting artifacts in logs
- The longer expansion goes undetected, the higher the **dwell time** — the average dwell time before detection historically exceeds 200 days in many breach reports

## Related concepts
[[Lateral Movement]] [[Privilege Escalation]] [[Dwell Time]] [[MITRE ATT&CK]] [[Network Segmentation]]