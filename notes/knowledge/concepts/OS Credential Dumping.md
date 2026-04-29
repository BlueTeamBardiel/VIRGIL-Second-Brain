# OS Credential Dumping

## What it is
Imagine a master locksmith's notebook left on a desk — it contains every key pattern for every lock in the building. OS credential dumping is exactly that: an attacker extracts stored password hashes, plaintext credentials, or Kerberos tickets directly from operating system memory or files (like LSASS.exe or the SAM database) after gaining initial access.

## Why it matters
In the 2020 SolarWinds breach, attackers used credential dumping tools like Mimikatz to harvest credentials from LSASS memory, enabling lateral movement across federal networks for months. Defenders counter this by enabling Credential Guard (Windows 10+), which isolates LSASS in a virtualization-based security enclave, making memory scraping ineffective.

## Key facts
- **LSASS (Local Security Authority Subsystem Service)** is the primary target on Windows — it holds NTLM hashes, Kerberos tickets, and sometimes plaintext credentials in memory
- **Mimikatz** is the canonical tool; its `sekurlsa::logonpasswords` command dumps credentials directly from LSASS memory
- **The SAM database** (`C:\Windows\System32\config\SAM`) stores local account hashes but requires SYSTEM privileges and is locked during runtime — attackers use Volume Shadow Copies to bypass this
- **Pass-the-Hash** attacks are often a direct follow-on: the attacker uses the dumped NTLM hash without cracking it to authenticate laterally
- This technique maps to **MITRE ATT&CK T1003** and is a post-exploitation move requiring elevated (admin/SYSTEM) privileges — detection focuses on anomalous LSASS access patterns via EDR tools

## Related concepts
[[Pass-the-Hash Attack]] [[Privilege Escalation]] [[MITRE ATT&CK Framework]] [[Lateral Movement]] [[Windows Authentication Protocols]]