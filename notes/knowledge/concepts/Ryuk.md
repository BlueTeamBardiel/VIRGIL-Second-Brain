# Ryuk

## What it is
Think of Ryuk like a professional safecracker who breaks into a vault, inventories everything valuable, then demands ransom for the combination — except the "vault" is your entire enterprise network. Ryuk is a sophisticated ransomware strain first observed in 2018, operated by the WIZARD SPIDER threat group, that targets large organizations by encrypting critical files and demanding high-value Bitcoin ransoms (often $100K–$500K+). Unlike spray-and-pray ransomware, Ryuk is deployed *manually* after operators spend weeks establishing persistence.

## Why it matters
In 2020, Universal Health Services (UHS) suffered a Ryuk attack that forced 400 hospitals across the US to revert to paper records, costing an estimated $67 million. The attack followed a classic Ryuk kill chain: Emotet phishing email → TrickBot lateral movement → Ryuk deployment — illustrating how ransomware is rarely the *first* tool, just the last.

## Key facts
- **Delivery chain**: Ryuk is typically the final payload in a three-stage chain — Emotet (initial access) → TrickBot (credential harvesting/lateral movement) → Ryuk (ransomware detonation)
- **Target selection**: Exclusively targets enterprises and critical infrastructure; operators manually identify high-value victims before encrypting
- **Encryption**: Uses AES-256 for file encryption, RSA-4096 for key protection; decryption without paying is computationally infeasible
- **Wake-on-LAN abuse**: Ryuk sends Wake-on-LAN packets to power on offline machines before encrypting them — a distinctive behavior used for forensic attribution
- **Shadow copy deletion**: Executes `vssadmin delete shadows /all` to eliminate Volume Shadow Copies, preventing easy restoration

## Related concepts
[[Ransomware]] [[TrickBot]] [[Emotet]] [[Lateral Movement]] [[Defense in Depth]]