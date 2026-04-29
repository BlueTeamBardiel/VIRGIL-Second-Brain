# Data Encrypted for Impact

## What it is
Imagine a kidnapper who locks all your family photos in a safe and demands ransom for the combination — that's exactly what ransomware does to your files. Data Encrypted for Impact (MITRE ATT&CK T1486) is an adversary technique where attackers encrypt files, databases, or entire systems to deny victims access to their own data, typically demanding payment for decryption keys.

## Why it matters
In 2021, the Colonial Pipeline attack used DarkSide ransomware to encrypt operational systems, forcing a shutdown of 5,500 miles of fuel pipeline and causing gas shortages across the U.S. East Coast. The company paid approximately $4.4 million in Bitcoin, demonstrating how this technique can cripple critical infrastructure far beyond just the digital environment.

## Key facts
- **MITRE ATT&CK T1486** classifies this under the Impact tactic, meaning the goal is disruption, not stealth — the victim is *meant* to know
- Ransomware commonly targets Volume Shadow Copies (`vssadmin delete shadows`) to prevent easy file recovery before encrypting
- Asymmetric encryption (RSA) is often used to protect the symmetric key (AES), so victims cannot decrypt without the attacker's private key
- Air-gapped backups and immutable backup storage are the most effective defensive controls against this technique
- Double extortion tactics combine encryption with data exfiltration, pressuring victims who might otherwise restore from backups

## Related concepts
[[Ransomware]] [[Inhibit System Recovery]] [[Impact Tactic]] [[Backup and Recovery Controls]] [[Defense Evasion]]