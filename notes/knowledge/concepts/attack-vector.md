# attack-vector

## What it is
Think of a castle with multiple weak points — the front gate, a drainage tunnel, a bribed guard. An attack vector is the specific pathway or method an attacker uses to gain unauthorized access to a system or network. It describes *how* the attack is delivered, not what it does once inside.

## Why it matters
In the 2021 Colonial Pipeline ransomware attack, the attack vector was a compromised VPN password — no multi-factor authentication was enabled on that account. Understanding this distinction (password compromise via VPN = vector; ransomware deployment = payload) allowed defenders to immediately prioritize credential hygiene and MFA enforcement as the critical control gap, rather than chasing the malware itself.

## Key facts
- Attack vectors are categorized in CVSS scoring as **Network, Adjacent, Local, or Physical** — each representing how remotely exploitable a vulnerability is
- A **network** vector (score: most severe) means the attacker needs no physical or logical proximity; **physical** vectors require hands-on access
- Common vectors include phishing emails, unpatched software, misconfigured APIs, removable media, and supply chain compromise
- Attack vector differs from **attack surface** — the surface is the total set of exposure points; the vector is the specific path chosen to exploit one of them
- Reducing attack vectors is the core goal of **hardening**: disabling unused services, closing ports, and removing unnecessary software all eliminate potential pathways

## Related concepts
[[attack-surface]] [[threat-vector]] [[CVSS]] [[lateral-movement]] [[vulnerability]]