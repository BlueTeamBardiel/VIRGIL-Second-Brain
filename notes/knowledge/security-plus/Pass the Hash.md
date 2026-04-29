# Pass the Hash

## What it is
Imagine getting into a secure building not by knowing the password, but by stealing the laminated badge that *proves* you know it — the guard never checks the real thing. Pass the Hash (PtH) is exactly that: an attacker captures a hashed credential from memory or disk and replays it directly to authenticate to network services, bypassing the need to crack the actual plaintext password.

## Why it matters
During the 2014 Sony Pictures breach, attackers moved laterally across the entire Windows domain by harvesting NTLM hashes from compromised machines and reusing them to authenticate to other systems — no cracking required. A single compromised admin workstation became a skeleton key for the whole network, demonstrating why hash harvesting is a lateral movement staple in real intrusions.

## Key facts
- PtH specifically exploits **NTLM authentication**, which accepts the hash itself as proof of identity rather than requiring the plaintext password
- Tools like **Mimikatz** extract NTLM hashes from the Windows LSASS process in memory — no disk artifacts required
- **Kerberos is not directly vulnerable** to PtH; however, a related attack called Pass the Ticket (PtT) exploits Kerberos TGTs similarly
- Mitigations include enabling **Protected Users security group**, deploying **Windows Defender Credential Guard** (virtualizes LSASS), and enforcing **least privilege** to limit lateral movement reach
- **NTLM should be disabled or restricted** in modern environments via Group Policy; forcing Kerberos closes the primary PtH pathway

## Related concepts
[[NTLM Authentication]] [[Lateral Movement]] [[Mimikatz]] [[Credential Dumping]] [[Pass the Ticket]]