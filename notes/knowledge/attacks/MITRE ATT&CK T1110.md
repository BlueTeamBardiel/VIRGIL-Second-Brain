# MITRE ATT&CK T1110

## What it is
Like a locksmith methodically testing every key on a ring until one fits, Brute Force is the systematic attempt of multiple credentials against an authentication system. It encompasses four sub-techniques: password guessing, password spraying, credential stuffing, and password cracking — each varying in volume, velocity, and source material.

## Why it matters
In the 2016 compromise of the Democratic National Committee, credential stuffing attacks used username/password pairs from prior breaches to gain authenticated access — no exploitation required, just valid credentials from elsewhere. Defenders counter this by implementing account lockout policies and monitoring for authentication anomalies, but these controls create their own tradeoffs between security and availability.

## Key facts
- **T1110.001 (Guessing):** High-volume attempts against one account; most likely to trigger lockout policies
- **T1110.002 (Cracking):** Performed *offline* against captured hash values — no network lockout risk since no live system is targeted
- **T1110.003 (Password Spraying):** One password attempted across *many* accounts; specifically designed to evade lockout thresholds
- **T1110.004 (Credential Stuffing):** Uses breach-derived username:password pairs; exploits password reuse — success rates of 0.1–2% are considered operationally significant
- Detection signal: authentication logs showing distributed failed logins, especially across many usernames from a single source (spraying) or single username with rapid failures (guessing)

## Related concepts
[[Credential Access]] [[T1078 Valid Accounts]] [[Multi-Factor Authentication]] [[Account Lockout Policy]] [[T1003 OS Credential Dumping]]