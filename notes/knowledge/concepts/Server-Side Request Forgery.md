# Server-side request forgery

## What it is
Imagine tricking a hotel concierge into fetching your rival's private mail from the back office — using the concierge's trusted access, not your own. SSRF is exactly that: an attacker manipulates a server into making HTTP requests on their behalf, typically to internal resources the attacker cannot reach directly. The server becomes an unwitting proxy, bypassing network boundaries and firewall rules.

## Why it matters
In the 2019 Capital One breach, an attacker exploited an SSRF vulnerability to query AWS's internal metadata endpoint (`http://169.254.169.254/latest/meta-data/`), retrieving temporary IAM credentials that granted access to over 100 million customer records stored in S3. This is the canonical SSRF horror story — a single misconfigured web application became the key to an entire cloud environment.

## Key facts
- SSRF targets internal services unreachable from the internet: cloud metadata APIs, internal admin panels, databases, and localhost services
- The AWS instance metadata endpoint (`169.254.169.254`) is a common SSRF target; IMDSv2 (requiring session-oriented tokens) was introduced specifically to mitigate this
- Blind SSRF returns no response to the attacker but still triggers back-end requests — detected via out-of-band techniques like DNS callbacks to Burp Collaborator
- Defense requires strict allow-listing of permitted outbound destinations, not block-listing (attackers bypass blocks with URL encoding, redirects, and DNS rebinding)
- SSRF is #10 on the OWASP Top 10 (2021), elevated from previous lists specifically due to cloud environment exposure

## Related concepts
[[Cross-Site Request Forgery]] [[DNS Rebinding]] [[Cloud Metadata Services]] [[Proxy and Pivoting Techniques]] [[Input Validation]]