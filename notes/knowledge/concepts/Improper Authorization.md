# Improper Authorization

## What it is
Imagine a concert venue where staff check your ticket at the gate, but once inside, anyone can walk backstage because no one verifies credentials there. Improper Authorization occurs when a system authenticates users correctly but fails to verify whether they have *permission* to perform a specific action or access a specific resource. It is distinct from authentication failures — the user is who they say they are, but the system doesn't ask *"are you allowed to do this?"*

## Why it matters
In 2019, a flaw in Venmo's API allowed any authenticated user to query transaction data belonging to other users simply by changing a numeric ID in the request — a classic Insecure Direct Object Reference (IDOR) attack rooted in improper authorization. The server verified the user was logged in but never checked whether that user *owned* the requested resource. This exposed millions of private transactions to trivial scraping.

## Key facts
- Mapped as **CWE-285** and closely related to **OWASP API Security Top 10 #1 (Broken Object Level Authorization)**
- Authorization must be enforced **server-side**; client-side controls (hidden buttons, disabled fields) are trivially bypassed
- Horizontal privilege escalation = accessing *another user's* data at the same privilege level; Vertical privilege escalation = accessing *higher-privileged* functions
- Forced browsing and parameter tampering (changing `user_id=1001` to `user_id=1002`) are the most common exploitation techniques
- Defense: implement **access control checks on every sensitive function/object**, not just at the UI layer — apply the principle of least privilege per request

## Related concepts
[[Broken Access Control]] [[Privilege Escalation]] [[Insecure Direct Object Reference]] [[Principle of Least Privilege]] [[Authentication vs Authorization]]