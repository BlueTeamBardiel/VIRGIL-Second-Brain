# REST

## What it is
Think of REST like a well-organized post office: every package (resource) has a unique address, and workers follow strict rules (GET, POST, PUT, DELETE) for handling them — no worker needs to remember your previous visit. Representational State Transfer (REST) is an architectural style for designing networked APIs where each HTTP request is stateless and resources are identified by URLs. It is the dominant pattern for web services, used by virtually every modern application backend.

## Why it matters
REST APIs are prime attack targets because they often expose sensitive data endpoints without proper authentication or authorization controls — a flaw known as Broken Object Level Authorization (BOLA/IDOR). An attacker who discovers `GET /api/users/1042/records` might simply try `/api/users/1043/records` and retrieve another user's medical data. This was the root cause of the 2019 Venmo API breach, where millions of private transactions were publicly scraped.

## Key facts
- REST APIs rely on HTTP methods: **GET** (read), **POST** (create), **PUT/PATCH** (update), **DELETE** (remove) — misuse of these can bypass access controls
- **Statelessness** means each request must carry its own credentials (tokens/API keys), making token theft immediately dangerous with no session revocation by default
- OWASP API Security Top 10 specifically targets REST: BOLA, excessive data exposure, and lack of rate limiting are the highest-risk findings
- REST APIs should enforce **rate limiting** and **input validation** to prevent brute-forcing endpoints and injection attacks
- **HTTPS is mandatory** for REST APIs — plaintext transmission exposes authentication tokens to interception via MitM attacks

## Related concepts
[[API Security]] [[IDOR]] [[OAuth]] [[HTTP Methods]] [[JSON Web Tokens]]