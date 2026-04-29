# content filtering

## What it is
Think of it as a bouncer at a club with a specific guest list — except instead of checking IDs, it's inspecting every packet, URL, file, or keyword against a ruleset before allowing it through. Content filtering is the process of screening and blocking data in transit (or at rest) based on predefined policies, examining web categories, keywords, file types, or data patterns to enforce acceptable use or prevent data leakage.

## Why it matters
In a spear-phishing campaign, an attacker hosts a malicious payload at a newly registered domain. A properly configured DNS-based content filter (like Cisco Umbrella) blocks the outbound DNS resolution to that domain before the connection is ever established — stopping the infection at the very first hop, before the firewall or endpoint AV even gets involved.

## Key facts
- **Two primary directions**: ingress filtering blocks malicious inbound content (malware, phishing URLs); egress filtering prevents sensitive data from leaving (DLP use case)
- **URL categorization** is a core mechanism — vendors maintain threat intelligence databases categorizing billions of domains (gambling, malware, adult, etc.) updated in near-real-time
- **SSL/TLS inspection** (aka HTTPS inspection) is required to filter encrypted content; without it, roughly 80%+ of modern web traffic is invisible to the filter
- **False positives** are a real operational cost — overly aggressive keyword filtering can block legitimate medical, legal, or security research content
- Content filtering is explicitly tested under the **Security+ domain: Architecture and Design** and maps to the **CySA+ defense-in-depth** controls discussion

## Related concepts
[[web application firewall]] [[data loss prevention]] [[proxy server]] [[DNS sinkhole]] [[SSL inspection]]