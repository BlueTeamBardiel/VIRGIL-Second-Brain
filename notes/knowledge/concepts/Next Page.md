# Next Page

## What it is
Like a "Page 2" button in a phone book that reveals more listings than fit on the first page, **Next Page** in a security context refers to pagination mechanisms in APIs and web applications that expose additional records through sequential or token-based requests. Precisely, it describes the technique — both in recon and in exploitation — of iterating through paginated responses to enumerate resources, users, or data that would otherwise appear limited or hidden.

## Why it matters
During an API security assessment, an attacker who discovers a `/users?page=1` endpoint can iterate through all pages (`page=2`, `page=3`...) to enumerate every user account in the system — a technique called **IDOR through pagination**. In one documented scenario, a misconfigured API exposed admin accounts only appearing on later pages, bypassing a UI that showed only the first 10 results, allowing privilege escalation through account takeover.

## Key facts
- Pagination parameters (`page=`, `offset=`, `cursor=`, `after=`) are common attack surfaces for **Insecure Direct Object Reference (IDOR)** and data enumeration
- **Token-based pagination** (opaque cursor tokens) is more secure than numeric page/offset pagination because tokens are harder to predict or manipulate
- Failing to apply **authorization checks on each paginated request** (not just the first) is a top API misconfiguration per OWASP API Security Top 10 (API3: Broken Object Property Level Authorization)
- Automated tools like **ffuf**, **Burp Suite Intruder**, or **wfuzz** can iterate pagination parameters rapidly to scrape full datasets
- Rate limiting and access controls must be enforced **per page request**, not just at the initial endpoint, to prevent mass data harvesting

## Related concepts
[[IDOR]] [[API Security]] [[Enumeration]] [[OWASP API Top 10]] [[Rate Limiting]]