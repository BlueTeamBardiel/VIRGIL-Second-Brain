# security-research

## What it is
Like a locksmith who legally picks locks to expose flaws before burglars do, security research is the systematic investigation of systems, software, and networks to discover vulnerabilities before malicious actors exploit them. It encompasses offensive techniques (finding flaws) and defensive analysis (understanding attack patterns), conducted under ethical and often legal frameworks like bug bounty programs or academic disclosure policies.

## Why it matters
In 2014, security researcher Tavis Ormandy discovered Heartbleed — a critical OpenSSL buffer over-read vulnerability — through code auditing, enabling coordinated disclosure that let organizations patch before mass exploitation. Without proactive security research, this flaw (affecting an estimated 17% of all SSL servers) could have silently drained private keys and encrypted communications for years.

## Key facts
- **Responsible disclosure** (coordinated disclosure) requires researchers to notify vendors privately and allow a remediation window — typically 90 days (Google Project Zero's standard) — before going public
- **CVE (Common Vulnerabilities and Exposures)** IDs are assigned by CNAs (CVE Numbering Authorities) to formally catalog discovered vulnerabilities, enabling standardized tracking
- **Bug bounty programs** (HackerOne, Bugcrowd) legally authorize researchers to test systems in defined scopes; payouts can exceed $1M for critical flaws (e.g., Apple's Security Research Device Program)
- The **Computer Fraud and Abuse Act (CFAA)** creates legal risk for researchers — authorization is the critical legal boundary between white-hat research and criminal hacking
- **Threat intelligence** feeds from security research (IOCs, TTPs) feed directly into SIEM rules and defensive tooling, making research operationally actionable

## Related concepts
[[vulnerability-disclosure]] [[bug-bounty-programs]] [[CVE]] [[threat-intelligence]] [[penetration-testing]]