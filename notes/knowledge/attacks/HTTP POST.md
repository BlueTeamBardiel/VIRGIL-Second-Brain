# HTTP POST

## What it is
Like slipping a sealed envelope under a door instead of writing on the outside of it, POST sends data inside the request body rather than exposed in the URL. It is an HTTP method designed to submit data to a server for processing — creating resources, submitting forms, or triggering actions — where the payload is carried in the message body rather than appended as query parameters.

## Why it matters
SQL injection attacks frequently ride inside POST request bodies because developers sometimes sanitize GET parameters while forgetting to validate form fields submitted via POST. An attacker targeting a login form can intercept the POST request with Burp Suite and inject `' OR '1'='1` into the username field, bypassing authentication entirely if input is unsanitized — demonstrating that "hidden in the body" does not mean "hidden from attackers."

## Key facts
- POST data is **not encrypted by default** — HTTPS is required to protect the body from interception; POST alone provides no confidentiality
- Unlike GET, POST requests are **not cached or stored in browser history**, making them preferable for sensitive operations like password submission
- POST is **not idempotent** — sending the same POST request twice may create two separate resources or trigger the action twice (unlike PUT)
- Web Application Firewalls (WAFs) must inspect POST bodies, not just URLs, to catch injection payloads — a common misconfiguration oversight
- **CSRF attacks** abuse POST requests by tricking an authenticated user's browser into submitting a forged POST to a trusted site without their knowledge

## Related concepts
[[SQL Injection]] [[Cross-Site Request Forgery (CSRF)]] [[HTTP Methods]] [[Web Application Firewall]] [[HTTPS]]