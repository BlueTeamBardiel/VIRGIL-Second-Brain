# HaveIBeenPwned

## What it is
Think of it as a lost-and-found bulletin board for stolen identities — except instead of wallets, it holds billions of exposed email addresses and passwords scraped from real breaches. HaveIBeenPwned (HIBP) is a free public service created by Troy Hunt that aggregates data from known breaches and allows individuals or organizations to query whether their credentials have been compromised.

## Why it matters
When the 2012 LinkedIn breach exposed 117 million credential pairs, attackers used that data for credential stuffing attacks against banks and email providers years later. Organizations integrating the HIBP API into their login flows can proactively block users from setting passwords that already appear in breach databases — cutting off credential stuffing before it starts.

## Key facts
- HIBP indexes over **12 billion** compromised accounts sourced from hundreds of publicly disclosed breaches
- The **Pwned Passwords** feature uses a *k-anonymity model* — your full password is never transmitted; only the first 5 characters of its SHA-1 hash are sent to the API, preserving privacy
- NIST SP 800-63B explicitly recommends checking new passwords against breach corpuses like Pwned Passwords during account creation
- Organizations can use the **domain search** feature to identify all exposed employee emails within their domain — useful for threat intelligence and phishing risk assessment
- HIBP distinguishes between **"sensitive" breaches** (e.g., adult sites) that are not publicly searchable, protecting victim privacy

## Related concepts
[[Credential Stuffing]] [[Password Spraying]] [[Data Breach Notification]] [[k-Anonymity]] [[NIST Password Guidelines]]