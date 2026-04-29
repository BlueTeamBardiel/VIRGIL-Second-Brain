# credential theft

## What it is
Like a pickpocket who doesn't steal your wallet but photographs every card inside it, credential theft extracts authentication secrets without the victim immediately knowing they're compromised. Precisely, it is the unauthorized acquisition of usernames, passwords, tokens, hashes, or certificates that enable an attacker to authenticate as a legitimate user — often without ever cracking or guessing a single password.

## Why it matters
In the 2020 SolarWinds attack, threat actors harvested SAML signing certificates from on-premises identity infrastructure, forging authentication tokens that granted persistent access to Microsoft 365 environments — no password needed. Defenders responded by implementing token binding and monitoring for impossible-travel anomalies in authentication logs, illustrating why detecting stolen credentials requires behavioral analytics, not just perimeter controls.

## Key facts
- **Pass-the-Hash (PtH)**: Attackers capture NTLM password hashes from memory (via Mimikatz targeting LSASS) and replay them directly — the plaintext password is never recovered or needed.
- **Pass-the-Ticket (PtT)**: Stolen Kerberos TGTs or service tickets are injected into sessions, enabling lateral movement without any password material.
- **Credential dumping** targets `/etc/shadow`, SAM database, LSASS memory, and browser-stored credential stores as primary sources.
- **Mitigations** include Protected Users security group, Credential Guard (virtualizes LSA), and disabling NTLM in favor of Kerberos.
- On Security+/CySA+, credential theft maps to **MITRE ATT&CK TA0006 (Credential Access)** — expect questions linking techniques like OS Credential Dumping (T1003) to specific tools and defenses.

## Related concepts
[[pass-the-hash]] [[mimikatz]] [[kerberos]] [[lateral movement]] [[privilege escalation]]