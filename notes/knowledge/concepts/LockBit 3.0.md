# LockBit 3.0

## What it is
Like a franchise operation where the "home office" supplies the tools, branding, and payment infrastructure while independent contractors do the actual break-ins, LockBit 3.0 is a Ransomware-as-a-Service (RaaS) platform. It is the third major iteration of the LockBit family, released in 2022, featuring a bug bounty program, customizable payloads, and intermittent encryption to maximize speed while evading detection.

## Why it matters
In 2023, LockBit 3.0 affiliates attacked the Royal Mail UK, demanding a $80 million ransom and leaking data when payment was refused — halting international postal services for weeks. Defenders must recognize that stopping LockBit requires targeting both the affiliate (initial access) and the RaaS infrastructure (takedown/disruption), as demonstrated by Operation Cronos in 2024 when law enforcement seized LockBit's servers.

## Key facts
- **Intermittent encryption**: LockBit 3.0 encrypts only portions of files (e.g., every other 4KB block), making encryption ~40% faster and bypassing I/O-based behavioral detection tools
- **Double extortion**: Combines file encryption with data exfiltration, threatening to publish stolen data on a dedicated leak site ("LockBit Blog") if ransom is unpaid
- **Bug bounty program**: Uniquely offered cash rewards for discovering flaws in its own malware — a first for ransomware operations, signaling professional software development practices
- **Self-propagation**: Uses Windows Management Instrumentation (WMI) and compromised Active Directory Group Policy to spread laterally without manual attacker intervention
- **MITRE ATT&CK alignment**: Maps heavily to T1486 (Data Encrypted for Impact), T1490 (Inhibit System Recovery), and T1567 (Exfiltration Over Web Service)

## Related concepts
[[Ransomware-as-a-Service]] [[Double Extortion]] [[Lateral Movement]] [[Active Directory Attacks]] [[MITRE ATT&CK Framework]]