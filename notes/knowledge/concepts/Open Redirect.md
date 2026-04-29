# open redirect

## What it is
Imagine a hotel concierge who will personally escort any guest to *any* address in the city, no questions asked — attackers just slip him a fake destination card. An open redirect is a web application vulnerability where a server blindly forwards users to an attacker-controlled URL using a trusted domain as the launching point, because the redirect destination is pulled from a user-supplied parameter without validation.

## Why it matters
Attackers weaponize open redirects in phishing campaigns: they craft a URL like `https://bank.com/redirect?url=https://evil.com/fake-login`, which passes email filters and looks legitimate because it starts with the real bank's domain. The victim clicks a "safe-looking" link and lands on a credential-harvesting page, never noticing the bait-and-switch mid-flight.

## Key facts
- Open redirects are listed in the **OWASP Top 10** historical entries under "Unvalidated Redirects and Forwards" and remain relevant to modern web testing frameworks
- The vulnerable parameter is commonly named `url=`, `next=`, `redirect=`, or `return=` — these are high-value targets during recon
- Mitigation: use an **allowlist** of permitted redirect destinations rather than blacklisting or stripping characters
- Open redirects can chain into **OAuth token theft** — an attacker abuses the redirect_uri parameter to intercept authorization codes if the OAuth server fails to validate it strictly
- Severity is often rated **Medium** in bug bounty programs, but chains with phishing or OAuth flaws can escalate it to High

## Related concepts
[[phishing]] [[OAuth vulnerabilities]] [[input validation]] [[SSRF]] [[URL manipulation]]