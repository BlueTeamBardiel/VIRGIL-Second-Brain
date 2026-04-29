# LPE

## What it is
Like a hotel guest who tricks a housekeeper into handing over a master key, Local Privilege Escalation is when an attacker who already has limited access to a system manipulates a vulnerability to gain higher-level permissions — typically SYSTEM or root. It is the technique of moving from a low-privileged account to an administrative or kernel-level account on a machine the attacker has already accessed.

## Why it matters
In the 2017 EternalBlue-based attacks, ransomware operators frequently chained LPE exploits with lateral movement tools after initial phishing gave them only a standard user shell. Without LPE, attackers cannot disable security tools, dump credential hashes, or install persistent backdoors — making it a critical link in nearly every post-exploitation kill chain.

## Key facts
- **Common LPE vectors**: unquoted service paths, misconfigured SUID binaries (Linux), weak file permissions on executables run by privileged accounts, and kernel exploits (e.g., Dirty COW, CVE-2016-5195)
- **Windows-specific**: token impersonation attacks (e.g., JuicyPotato, PrintSpoofer) exploit Windows service accounts holding `SeImpersonatePrivilege`
- **Enumeration tools**: WinPEAS and LinPEAS are the standard automated tools used by attackers and penetration testers to identify LPE opportunities
- **Detection signal**: unexpected processes spawned with SYSTEM or root privileges, or services restarting under a different user context, are red flags for active LPE
- **CySA+/Security+ relevance**: LPE is distinct from remote code execution — it assumes the attacker is *already on the box* and requires least-privilege enforcement as a primary control

## Related concepts
[[Privilege Escalation]] [[Access Control]] [[Token Impersonation]] [[Lateral Movement]] [[Kernel Exploit]]