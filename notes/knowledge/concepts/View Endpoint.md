# View Endpoint

## What it is
Like a window in a museum that lets visitors see the art without touching it — a View Endpoint is a read-only API or web route that retrieves and displays data without modifying it. Precisely, it is a server-side endpoint that responds to GET requests by fetching and rendering information from a backend data source to the client.

## Why it matters
View endpoints are prime targets for enumeration and data exposure attacks because developers often assume "read-only means harmless" and apply weaker access controls. An attacker who discovers an unauthenticated `/api/users/view` endpoint can harvest usernames, email addresses, and account metadata to fuel credential stuffing or spear phishing campaigns — all without triggering write-operation alerts.

## Key facts
- View endpoints typically use HTTP GET methods and should be protected with the same authentication/authorization rigor as write endpoints — misconfiguration is a top cause of IDOR (Insecure Direct Object Reference) vulnerabilities
- Excessive data exposure occurs when a view endpoint returns full object records (including sensitive fields like SSNs or tokens) when only a subset is needed by the client
- Broken Object Level Authorization (BOLA/IDOR) — an OWASP API Security Top 10 risk — is frequently exploited through view endpoints by manipulating resource IDs in the URL (e.g., `/user/1234/view` → `/user/1235/view`)
- Rate limiting is critical on view endpoints to prevent automated enumeration; without it, attackers can scrape entire datasets
- Logging and monitoring of GET requests to sensitive view endpoints is a CySA+ defense priority — anomalous spikes in read traffic often indicate active reconnaissance

## Related concepts
[[IDOR]] [[API Security]] [[Excessive Data Exposure]] [[Broken Access Control]] [[Enumeration]]