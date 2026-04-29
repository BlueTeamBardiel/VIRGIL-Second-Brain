# Credential Access

## What it is
Like a thief who doesn't break down walls but instead steals the keyring hanging by the front door, credential access is about obtaining legitimate usernames and passwords rather than exploiting technical vulnerabilities. It is the collection of account credentials — through theft, extraction, or manipulation — that allows an attacker to authenticate as a legitimate user and move through a system without triggering "break-in" alerts.

## Why it matters
In the 2020 SolarWinds breach, attackers used credential dumping tools to harvest service account passwords from memory after establishing initial access — then used those credentials to pivot laterally across government networks for months undetected. Because they were authenticating *legitimately*, traditional perimeter defenses saw nothing unusual. Privileged Access Management (PAM) and behavioral analytics were the only controls capable of flagging the anomaly.

## Key facts
- **Mimikatz** is the canonical credential dumping tool; it extracts plaintext passwords and NTLM hashes from Windows LSASS process memory
- **Pass-the-Hash (PtH)** attacks allow authentication using a stolen NTLM hash *without ever cracking the underlying password*
- **Kerberoasting** targets Active Directory by requesting service tickets and cracking them offline — requiring zero elevated privileges to initiate
- MITRE ATT&CK categorizes Credential Access as **Tactic TA0006**, with techniques including OS Credential Dumping (T1003), Brute Force (T1110), and Phishing for credentials (T1598)
- Windows Credential Guard (introduced in Windows 10) isolates LSASS in a virtualized secure enclave, specifically to defeat Mimikatz-style attacks

## Related concepts
[[Lateral Movement]] [[Pass-the-Hash]] [[Kerberoasting]] [[Privilege Escalation]] [[MITRE ATT&CK Framework]]