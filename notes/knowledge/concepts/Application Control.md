# Application Control

## What it is
Think of it like a nightclub with an exclusive guest list — if your name isn't on the list, you're not getting in, no matter how convincing you look. Application control is a security mechanism that restricts which programs are permitted to execute on a system, using whitelisting (allow-only-approved), blacklisting (block-known-bad), or hybrid approaches to enforce policy.

## Why it matters
In 2017, the NotPetya attack spread partly because organizations allowed arbitrary executables to run across their networks. A mature application control policy using Windows AppLocker or similar tools would have blocked the malicious payload from executing entirely — stopping lateral movement before it could begin, regardless of whether antivirus signatures existed.

## Key facts
- **Whitelisting** is the gold standard: only explicitly approved applications run, making zero-day malware ineffective if it can't match an approved hash or publisher signature
- **AppLocker** (Windows) and **Software Restriction Policies (SRP)** are the two primary built-in Windows mechanisms; AppLocker is the modern, GPO-managed replacement
- Application control can enforce rules based on **file path, publisher certificate, or cryptographic hash** — hash is most secure, path is easiest to bypass
- **WDAC (Windows Defender Application Control)** operates at the kernel level and is harder to bypass than AppLocker, which runs in user space
- The **MITRE ATT&CK technique T1218 (Signed Binary Proxy Execution)** specifically describes attackers abusing trusted, whitelisted binaries like `mshta.exe` or `regsvr32.exe` to bypass application control — a technique called **Living off the Land (LotL)**

## Related concepts
[[Allowlisting]] [[Blocklisting]] [[Least Privilege]] [[Windows Defender Application Control]] [[Living off the Land Attacks]]