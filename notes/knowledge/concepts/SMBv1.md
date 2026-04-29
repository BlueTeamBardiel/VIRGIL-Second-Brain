# SMBv1

## What it is
Imagine sending secret messages through a pneumatic tube system built in 1984 — it works, but it has no locks, no tamper detection, and the design was never meant to handle modern threats. SMBv1 (Server Message Block version 1) is a legacy network file-sharing protocol developed by IBM and later adopted by Microsoft, enabling file, printer, and resource sharing across Windows networks. It lacks modern encryption, authentication hardening, and integrity verification found in SMBv2/v3.

## Why it matters
In May 2017, the WannaCry ransomware attack exploited EternalBlue (MS17-010), a vulnerability in SMBv1, to spread laterally across unpatched Windows systems without any user interaction — infecting over 200,000 machines across 150 countries, including the UK's National Health Service. Disabling SMBv1 entirely is now a baseline hardening requirement in CIS Benchmarks and DISA STIGs, and was the single most impactful mitigation against this attack class.

## Key facts
- **EternalBlue (CVE-2017-0144)** targets an SMBv1 buffer overflow, allowing unauthenticated remote code execution — it was weaponized in both WannaCry and NotPetya
- SMBv1 operates over **TCP port 445** (and legacy NetBIOS ports 137-139)
- Microsoft officially **deprecated SMBv1 in 2014** and disabled it by default starting with Windows Server 2016 and Windows 10 version 1709
- SMBv1 is vulnerable to **pass-the-hash** and **NTLM relay attacks** due to weak authentication mechanisms
- Detecting SMBv1 traffic on your network is a **Tier 1 threat indicator** — legitimate modern systems should never need it

## Related concepts
[[EternalBlue]] [[WannaCry]] [[Lateral Movement]] [[NTLM Authentication]] [[Network Hardening]]