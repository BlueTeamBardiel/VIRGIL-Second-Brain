# T1003: OS Credential Dumping

Adversaries dump credentials from OS caches, memory, or structures to obtain account login material (hashes or cleartext) for [[Lateral Movement]] and accessing restricted information.

**Tactic:** [[Credential Access]]  
**Platforms:** Linux, Windows, macOS  
**ATT&CK ID:** T1003  
**Last Modified:** 24 October 2025

## Sub-techniques

| ID | Name |
|----|------|
| [[T1003.001]] | LSASS Memory |
| [[T1003.002]] | Security Account Manager |
| [[T1003.003]] | NTDS |
| [[T1003.004]] | LSA Secrets |
| [[T1003.005]] | Cached Domain Credentials |
| [[T1003.006]] | DCSync |
| [[T1003.007]] | Proc Filesystem |
| [[T1003.008]] | /etc/passwd and /etc/shadow |

## Associated Groups & Software

**Notable Threat Actors:**
- [[APT28]] — uses [[Mimikatz]] and custom tools
- [[APT32]] — uses GetPassword_x64
- [[APT39]] — uses Mimikatz variants
- [[Axiom]] — credential dumping capability
- [[BlackByte]] — uses [[Cobalt Strike]] and [[Mimikatz]]
- [[Ember Bear]] — gathers SSH keys and credential material
- [[Leviathan]] — uses HOMEFRY
- [[Mustang Panda]] — uses Hdump
- [[Poseidon Group]] — focuses on domain/database credentials
- [[Storm-0501]] — uses [[Impacket]] SecretsDump
- [[Tonto Team]] — varied credential dumping tools

**Associated Tools:**
- [[Mimikatz]]
- [[Cobalt Strike]]
- [[Impacket]]
- [[Carbanak]]
- [[HOMEFRY]]
- [[MgBot]]
- [[OnionDuke]]
- [[PinchDuke]]
- [[Revenge RAT]]
- [[Trojan.Karagany]]

## Tags

#att&ck #credential-access #credentials #lateral-movement #post-compromise

---
_Ingested: 2026-04-15 20:21 | Source: https://attack.mitre.org/techniques/T1003/_
