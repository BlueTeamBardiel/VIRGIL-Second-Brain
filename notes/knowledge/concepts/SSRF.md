# SSRF

## What it is
Imagine you're at a locked library and you can't enter, but you convince the librarian inside to fetch any book for you — including books from the restricted back room. Server-Side Request Forgery (SSRF) works the same way: an attacker manipulates a server into making HTTP requests on their behalf, reaching internal resources that the attacker cannot directly access from outside the network. The server becomes an unwitting proxy, trusted by internal systems that would never accept requests from the attacker directly.

## Why it matters
In 2019, the Capital One breach exploited SSRF against an AWS EC2 instance: the attacker tricked the server into querying the internal metadata endpoint (`http://169.254.169.254/latest/meta-data/`), which returned IAM credentials with excessive permissions — ultimately exposing over 100 million customer records. Defenders counter this by blocking outbound server requests to link-local addresses and enforcing allowlists for any server-initiated HTTP calls.

## Key facts
- SSRF targets the **server's network trust position** — internal firewalls trust the server, so the attacker leverages that implicit trust
- The AWS metadata IP `169.254.169.254` is the canonical SSRF target in cloud environments; GCP and Azure have equivalents
- **Blind SSRF** occurs when the server makes the request but doesn't return the response to the attacker — detected via out-of-band callbacks (e.g., Burp Collaborator)
- SSRF was added as its own category in the **OWASP Top 10 2021** (A10), reflecting its rising prevalence in cloud architectures
- Mitigations include input validation, DNS rebinding protections, disabling unnecessary URL-fetching features, and using **IMDSv2** (token-based) on AWS to thwart metadata endpoint abuse

## Related concepts
[[Server-Side Request Forgery Mitigations]] [[Cloud Metadata Services]] [[Blind SSRF]] [[OWASP Top 10]] [[Open Redirect]]