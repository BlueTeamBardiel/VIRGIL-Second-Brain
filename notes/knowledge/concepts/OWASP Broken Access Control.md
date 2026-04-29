# OWASP Broken Access Control

## What it is
Imagine a hotel where any guest can walk into any room simply by typing a different room number into the keypad — the lock checks *that you have a keycard*, but never checks *which room you're allowed to enter*. Broken Access Control occurs when an application correctly authenticates users but fails to enforce what those authenticated users are permitted to do or access. It is the #1 vulnerability in the OWASP Top 10 (2021), covering flaws like insecure direct object references (IDOR), missing function-level access control, and privilege escalation.

## Why it matters
In 2019, researchers discovered that First American Financial exposed 885 million sensitive mortgage documents because their web app used sequential document IDs in URLs — any authenticated user could increment the ID and access anyone else's records (a textbook IDOR attack). Proper authorization checks server-side, combined with indirect reference maps (randomized tokens instead of predictable IDs), would have prevented the entire breach.

## Key facts
- **IDOR** is the most common subtype: predictable resource identifiers (e.g., `?user_id=1042`) allow horizontal privilege escalation to other users' data
- **Vertical privilege escalation** occurs when a regular user accesses admin-only functions by manipulating roles, parameters, or URLs
- Access control must be enforced **server-side** — client-side enforcement (hidden buttons, JavaScript checks) is trivially bypassed
- The principle of **least privilege** and **deny-by-default** are the primary architectural defenses
- Testing tools include **Burp Suite** (manual parameter tampering) and automated scanners checking for forced browsing vulnerabilities

## Related concepts
[[IDOR (Insecure Direct Object Reference)]] [[Privilege Escalation]] [[OWASP Top 10]] [[Least Privilege Principle]] [[Authentication vs Authorization]]