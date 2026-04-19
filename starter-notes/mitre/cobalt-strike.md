# Cobalt Strike

Cobalt Strike is a commercial, full-featured remote access tool marketed as "adversary simulation software designed to execute targeted attacks and emulate the post-exploitation actions of advanced threat actors." It provides integrated post-exploitation capabilities across all ATT&CK tactics and leverages other tools like [[Metasploit]] and [[Mimikatz]].

## Metadata
- **ID**: S0154
- **Type**: MALWARE
- **Platforms**: Windows, Linux, macOS
- **Created**: 14 December 2017
- **Last Modified**: 25 September 2024
- **Contributors**: Martin Sohn Christensen (Improsec), Josh Abraham

## Techniques Used

### Defense Evasion
- [[Abuse Elevation Control Mechanism]] - Bypass UAC (T1548.002)
- [[Sudo and Sudo Caching]] (T1548.003)

### Lateral Movement & Privilege Escalation
- [[Access Token Manipulation]]
  - Token Impersonation/Theft from existing processes (T1134.001)
  - Make and Impersonate Token from known credentials (T1134.003)
  - Parent PID Spoofing for alternate process spawn (T1134.004)

### Discovery
- [[Account Discovery]] - Determine admin/domain admin group membership (T1087.002)

### Command & Control
- [[Application Layer Protocol]]
  - HTTP/HTTPS custom protocol (T1071.001)
  - SMB named pipes peer-to-peer (T1071.002)
  - DNS custom protocol (T1071.004)

### Execution & Lateral Movement
- [[BITS Jobs]] - Download beacon payloads (T1197)
- [[Browser Session Hijacking]] - Inject into browsers, inherit cookies and authenticated sessions (T1185)
- [[Command and Scripting Interpreter]]
  - PowerShell execution (T1059.001)
  - Windows Command Shell (T1059.003)
  - Visual Basic/VBA (T1059.005)

## Tags
#malware #c2 #post-exploitation #adversary-simulation #mitre-att&ck

---
_Ingested: [[2026-04-15]] 22:04 | Source: https://attack.mitre.org/software/S0154/_
