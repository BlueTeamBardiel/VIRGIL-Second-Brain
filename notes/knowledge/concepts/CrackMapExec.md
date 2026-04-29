# crackmapexec

## What it is
Think of it as a skeleton key ring for Windows networks — one tool that tries every door simultaneously using credentials you've already found. CrackMapExec (CME) is an open-source post-exploitation framework designed to automate lateral movement across Active Directory environments by leveraging SMB, WinRM, LDAP, and other protocols to spray credentials, execute commands, and enumerate network resources at scale.

## Why it matters
During a ransomware intrusion, attackers who compromise a single domain user account will immediately reach for CME to spray that credential across every reachable host — identifying where it works, dumping SAM databases, and executing payloads without ever writing a traditional malware binary to disk. Defenders watching for this look for Event ID 4625 (failed logon) spikes followed by 4624 (successful logon) across multiple hosts in rapid succession, a textbook sign of credential spraying.

## Key facts
- CME uses Pass-the-Hash (PtH) attacks natively, meaning attackers never need a plaintext password — just the NTLM hash extracted from LSASS or a SAM dump
- The `--shares` and `--sessions` flags enumerate accessible SMB shares and active sessions without triggering most AV solutions because it uses legitimate Windows APIs
- CME integrates directly with Impacket and Mimikatz modules, enabling `--lsa` and `--ntds` flags to dump domain credentials from domain controllers
- It supports multiple protocols: SMB (port 445), WinRM (5985/5986), LDAP (389/636), RDP, MSSQL — making it protocol-agnostic for lateral movement
- Detection signature: multiple 4625/4648 events from a single source IP across diverse hosts within seconds is a high-fidelity CME indicator

## Related concepts
[[Pass-the-Hash]] [[lateral movement]] [[Active Directory enumeration]] [[credential spraying]] [[Impacket]]