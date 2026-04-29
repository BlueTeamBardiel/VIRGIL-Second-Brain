# Threats and Vulnerabilities

## What it is
Think of a castle: a **vulnerability** is the crumbling section of the outer wall, while a **threat** is the army that knows about it and might exploit it. Precisely: a **vulnerability** is a weakness in a system, software, or process; a **threat** is any circumstance or actor with the potential to exploit that weakness and cause harm. The **risk** emerges only when threats and vulnerabilities intersect.

## Why it matters
In 2021, attackers exploited the ProxyLogon vulnerability (CVE-2021-26855) in Microsoft Exchange — a pre-authentication SSRF flaw that had existed unpatched in production servers worldwide. The threat actors (nation-state groups including HAFNIUM) weaponized it within days of disclosure, compromising tens of thousands of organizations before patches could be deployed. This illustrates that a vulnerability alone is dormant; a motivated threat actor transforms it into active danger.

## Key facts
- **Threat actors** are categorized by type: nation-states, hacktivists, insider threats, cybercriminals, and script kiddies — each with different capabilities (sophistication) and motivations
- **CVE (Common Vulnerabilities and Exposures)** provides standardized identifiers for publicly known vulnerabilities; **CVSS scores** (0–10) quantify severity
- **Zero-day vulnerability**: a flaw unknown to the vendor, with no available patch — highest exploitability window
- The **threat vector** (attack vector) describes the path used: network, adjacent network, local, or physical — directly affects CVSS scoring
- **Vulnerability ≠ Risk**: Risk = Threat × Vulnerability × Impact; eliminating any factor reduces overall risk

## Related concepts
[[Risk Management]] [[Attack Surface]] [[CVE and CVSS Scoring]] [[Zero-Day Exploits]] [[Threat Intelligence]]