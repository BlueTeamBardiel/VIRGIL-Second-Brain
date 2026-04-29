# EternalBlue

## What it is
Imagine a locksmith discovers that every Master Lock ever made has a hidden flaw where inserting a bent paperclip opens it instantly — that's EternalBlue. It is an exploit targeting a critical buffer overflow vulnerability (CVE-2017-0144) in Microsoft's SMBv1 protocol, allowing unauthenticated remote code execution by sending a specially crafted packet to port 445.

## Why it matters
In May 2017, the WannaCry ransomware campaign weaponized EternalBlue to self-propagate across networks without any user interaction, infecting over 200,000 systems in 150 countries within days — including shutting down NHS hospitals in the UK. Patching MS17-010 and disabling SMBv1 were the critical defensive responses, demonstrating how a single unpatched protocol can become a global catastrophe.

## Key facts
- Originally developed by the NSA as a cyberweapon; leaked publicly by the Shadow Brokers group in April 2017
- Targets **SMBv1** (Server Message Block version 1) on **TCP port 445**; the patch is **MS17-010**, released March 2017
- Used in both **WannaCry** (ransomware) and **NotPetya** (destructive wiper) attacks — two of the most damaging cyberattacks in history
- The exploit achieves **lateral movement** without credentials, making it devastating in flat, unpatched networks
- Mitigation: disable SMBv1 via Windows Features, block port 445 at network boundaries, and apply MS17-010 immediately

## Related concepts
[[SMB Protocol]] [[Ransomware]] [[Lateral Movement]] [[CVE Vulnerability Scoring]] [[Patch Management]]