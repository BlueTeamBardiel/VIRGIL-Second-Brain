# CWE-918: Server-Side Request Forgery

## What it is
Imagine handing a note to a bank teller that says "please call this number and read me back whatever they say" — and that number is the bank's internal vault line. SSRF is when an attacker manipulates a server into making HTTP requests on their behalf, allowing them to probe internal networks and services that are unreachable from the outside world. The server becomes an unwitting proxy, laundering the attacker's requests through trusted internal infrastructure.

## Why it matters
In the 2019 Capital One breach, the attacker exploited an SSRF vulnerability against a misconfigured WAF running on AWS EC2. By issuing a crafted request, they queried the AWS Instance Metadata Service (IMDb) at `http://169.254.169.254/latest/meta-data/iam/` and retrieved temporary IAM credentials — ultimately exfiltrating over 100 million customer records. Blocking outbound requests to metadata IP ranges would have broken the attack chain entirely.

## Key facts
- **Cloud metadata services are the primary target**: AWS (`169.254.169.254`), GCP, and Azure all expose credentials and configuration at link-local addresses reachable via SSRF.
- **Blind SSRF** yields no direct response to the attacker but can still exfiltrate data through DNS lookups or timing differences — don't assume "no response" means "no impact."
- **Input vectors include URLs, webhooks, PDF generators, XML parsers (XXE), and image-fetch functions** — anywhere the server fetches a user-supplied resource.
- **Defense requires allowlist-based URL validation**, not blocklists. Attackers use redirects, alternate IP encodings (`0x7f000001`), and DNS rebinding to bypass blocklists.
- **SSRF is on the OWASP Top 10 (A10:2021)** and appears in CySA+ scenarios involving cloud misconfiguration and lateral movement.

## Related concepts
[[XXE Injection]] [[Cloud Metadata Service Abuse]] [[OWASP Top 10]] [[Open Redirect]] [[Lateral Movement]]