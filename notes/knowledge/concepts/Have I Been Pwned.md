# Have I Been Pwned

## What it is
Think of it as a missing persons database, but for stolen credentials — instead of searching for people, you search your email address to see if it appeared in a known data breach. Have I Been Pwned (HIBP) is a free public service created by Troy Hunt in 2013 that aggregates leaked credential databases and allows individuals and organizations to check whether their accounts were compromised in known breaches.

## Why it matters
After the 2012 LinkedIn breach exposed 117 million hashed passwords, attackers used credential stuffing tools to try those username/password pairs against banking and email services — attacking accounts whose owners had no idea their credentials were circulating on dark web forums. HIBP gives defenders and end users early warning, enabling password resets before attackers can pivot to higher-value targets.

## Key facts
- HIBP indexes over 12 billion compromised accounts across hundreds of breaches, including major incidents like Adobe (153M), Collection #1 (773M), and RockYou2024
- The **Pwned Passwords** feature lets you check if a specific password appears in breach data using a k-anonymity model — only the first 5 characters of the SHA-1 hash are transmitted, protecting your actual password
- Organizations can use the **Domain Search** and **API** to monitor all email addresses under their domain for breach exposure — a key proactive defense control
- HIBP is referenced in NIST SP 800-63B guidance, which recommends checking new passwords against known compromised password lists
- Troy Hunt donated HIBP's operation to the non-profit **CISA** partnership structure in 2024 to ensure long-term sustainability

## Related concepts
[[Credential Stuffing]] [[Password Spraying]] [[Data Breach Notification]] [[k-Anonymity]] [[Dark Web Monitoring]]