# REST Security

## What it is
Think of a REST API like a drive-through window: anyone who knows the right order format can pull up and make requests — so the window itself must verify *who's* ordering before handing anything over. REST (Representational State Transfer) security is the set of controls applied to HTTP-based APIs to ensure that endpoints only respond to authenticated, authorized, and properly formed requests, protecting the data resources they expose.

## Why it matters
In 2019, Facebook exposed millions of user records because third-party apps using their REST APIs had overly permissive access tokens — no proper scope enforcement meant apps could read far more than they needed. This is a textbook **Broken Object Level Authorization (BOLA)** failure, the #1 vulnerability in the OWASP API Security Top 10, where an attacker simply swaps one user's ID for another in a request URL and retrieves someone else's data.

## Key facts
- **Statelessness** means every REST request must carry its own credentials (typically a Bearer token via OAuth 2.0) — the server holds no session state, so token theft is equivalent to credential theft
- **HTTPS is mandatory** — REST APIs transmit credentials and sensitive data in headers/body, making cleartext transmission an instant critical finding
- **Rate limiting and throttling** prevent enumeration attacks and credential stuffing against API endpoints
- **Input validation** must occur server-side; malformed JSON/XML payloads can trigger injection attacks or parser vulnerabilities
- OWASP API Security Top 10 (not the standard Top 10) is the authoritative reference — knowing **BOLA, Broken Authentication, and Excessive Data Exposure** is exam-critical for CySA+

## Related concepts
[[OAuth 2.0]] [[JSON Web Tokens]] [[API Security]] [[Broken Access Control]] [[HTTPS]]