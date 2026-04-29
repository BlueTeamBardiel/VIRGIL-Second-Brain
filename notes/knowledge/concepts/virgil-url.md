# virgil-url

## What it is
Like a postal address that can secretly redirect your mail to a different house while looking legitimate on the envelope, a Virgil URL is a crafted or manipulated web address designed to deceive users about the true destination. Specifically, it refers to a URL constructed to bypass security filters or mislead users through obfuscation techniques such as encoding, homograph substitution, or subdomain abuse.

## Why it matters
In phishing campaigns, attackers use obfuscated URLs to bypass email security gateways that blocklist known malicious domains. For example, encoding a malicious link as `https://legitimate-bank.com.evil.io/login` tricks both automated scanners and users into believing they're visiting their bank, while the actual destination is the attacker-controlled domain `evil.io`. Security analysts must recognize these patterns during triage to prevent credential harvesting.

## Key facts
- URL obfuscation methods include percent-encoding (`%2F` for `/`), punycode homograph attacks (using `xn--` prefixed Unicode look-alikes), and IP address substitution (e.g., `http://192.168.1.1` instead of a domain name)
- Subdomain spoofing places a trusted brand name as a subdomain of a malicious domain: `paypal.com.attacker.net` — the real domain is `attacker.net`
- URL shorteners (bit.ly, tinyurl) are frequently weaponized to hide malicious destinations from both users and security tools
- Security tools use URL reputation services and sandboxed link detonation to evaluate obfuscated URLs before user interaction
- HTTPS does **not** guarantee legitimacy — attackers routinely obtain valid TLS certificates for malicious domains, adding false trust signals

## Related concepts
[[Phishing]] [[Homograph Attack]] [[URL Encoding]] [[Open Redirect]] [[Email Security Gateway]]