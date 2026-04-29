# credential compromise

## What it is
Like stealing a master key to a building instead of breaking down every door, credential compromise means an attacker obtains valid authentication secrets — passwords, tokens, hashes, or certificates — to impersonate a legitimate user without triggering forced-entry alarms. The attacker doesn't break the lock; they use the real key.

## Why it matters
In the 2020 SolarWinds attack, threat actors used compromised SAML token-signing certificates to forge authentication tokens, granting themselves persistent access to Microsoft 365 environments across thousands of organizations. No brute force, no malware alerts — just valid credentials opening every door. Defenders who monitored only perimeter traffic missed the intrusion entirely until anomalous OAuth token activity was flagged.

## Key facts
- **Credential stuffing** reuses breached username/password pairs against other services, exploiting password reuse; automated tools test millions of combos per hour
- **Pass-the-Hash (PtH)** allows attackers to authenticate using a captured NTLM hash without cracking the plaintext password — a critical Windows lateral movement technique
- **Kerberoasting** extracts service account ticket-granting service (TGS) tickets from Active Directory and cracks them offline, targeting accounts with weak passwords
- **MITRE ATT&CK Tactic T1078** (Valid Accounts) covers credential compromise as an initial access and persistence mechanism, making it one of the most commonly observed real-world TTPs
- MFA significantly reduces credential compromise impact, but attackers counter with MFA fatigue (prompt bombing) attacks to bypass it

## Related concepts
[[pass-the-hash]] [[kerberoasting]] [[multi-factor authentication]] [[credential stuffing]] [[privilege escalation]]