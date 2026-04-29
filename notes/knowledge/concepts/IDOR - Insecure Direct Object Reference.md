# IDOR - Insecure Direct Object Reference

## What it is
Imagine a hotel where every room key is just a card printed with your room number — and the door opens for *any* card showing that number, no questions asked. IDOR occurs when an application uses user-controllable input (like an ID in a URL) to directly access objects — database records, files, accounts — without verifying the requester actually has permission to access that specific object.

## Why it matters
In 2021, an IDOR vulnerability in Peloton's API allowed unauthenticated attackers to query any user's private profile data simply by cycling through numeric user IDs in API requests. The fix isn't encrypting the IDs — it's server-side authorization checks that confirm *this authenticated user* is permitted to access *that specific resource*, every single time.

## Key facts
- IDOR is classified under **OWASP A01:2021 – Broken Access Control**, the top web application vulnerability category
- The vulnerable parameter can be a URL path (`/invoice/1042`), query string (`?user_id=58`), POST body, or even a cookie value
- Simply obscuring IDs (using GUIDs instead of integers) is **security through obscurity** — not a true fix; authorization must be enforced server-side
- Testing method: authenticate as User A, capture a resource reference, then access it while authenticated as User B — if it succeeds, IDOR is confirmed
- IDOR is a **horizontal privilege escalation** vulnerability when accessing another user's same-level data, and **vertical** when accessing higher-privileged objects

## Related concepts
[[Broken Access Control]] [[Privilege Escalation]] [[API Security]] [[Forced Browsing]]