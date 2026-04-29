# BOLA

## What it is
Imagine a hotel where every room has a number on the door — and the front desk gives you a key to Room 214, but never checks if you're *allowed* to enter Room 215 when you walk up and try it. Broken Object Level Authorization (BOLA) — also called IDOR (Insecure Direct Object Reference) — occurs when an API exposes object identifiers (like user IDs or record numbers) and fails to verify that the requesting user has permission to access that specific object. An attacker simply manipulates the identifier in the request to access data belonging to other users.

## Why it matters
In 2019, a vulnerability in the Venmo API allowed unauthenticated requests to enumerate millions of transactions by sequentially incrementing transaction IDs — a textbook BOLA flaw. An attacker could harvest user financial behavior data at scale simply by iterating integers in API calls. Proper object-level authorization checks on every request would have blocked this entirely.

## Key facts
- BOLA is ranked **#1 in the OWASP API Security Top 10** (2019 and 2023), reflecting how widespread and dangerous it is
- The attack vector is parameter tampering: changing `/api/orders/1001` to `/api/orders/1002` to access another user's order
- Root cause is trusting the client-supplied identifier without server-side ownership verification
- Exploitation requires minimal skill — often just a browser or Burp Suite to intercept and modify requests
- Defense requires **object-level authorization checks** on every API endpoint, not just authentication at login — verify that the authenticated user *owns* the requested resource

## Related concepts
[[IDOR]] [[API Security]] [[Access Control]] [[Privilege Escalation]] [[OWASP Top 10]]