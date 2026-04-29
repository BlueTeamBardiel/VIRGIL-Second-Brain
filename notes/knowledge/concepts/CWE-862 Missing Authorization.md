# CWE-862 Missing Authorization

## What it is
Like a hospital where nurses check your ID at the front door but nobody verifies you're actually allowed into the ICU once you're inside — the system authenticates you, then forgets to ask *what* you're permitted to do. Missing Authorization occurs when code performs an operation without verifying that the authenticated user has the privilege to perform that specific action.

## Why it matters
In 2019, a flaw in the Facebook API allowed any authenticated user to remove other users from groups by directly calling a privileged endpoint — authentication existed, but the server never checked if the caller was a group admin. The fix is enforcing an explicit authorization check (e.g., `if user.role != 'admin': return 403`) on every sensitive function, not just at login.

## Key facts
- **Distinct from CWE-306** (Missing Authentication): 862 means you *are* logged in but the app never checks your *permissions* — apples vs. oranges on the CIA triad impact.
- Commonly exploited via **Insecure Direct Object Reference (IDOR)** — an attacker increments a resource ID in a request and the server returns another user's data without an authz check.
- Maps directly to **OWASP Top 10 A01:2021 (Broken Access Control)**, the #1 web application risk category.
- Proper mitigation requires **deny-by-default** access control: explicitly grant permissions rather than relying on absence of a block.
- Frequently found in **REST APIs** where developers secure the UI routes but forget server-side checks on the underlying API endpoints ("security through obscurity" anti-pattern).

## Related concepts
[[Broken Access Control]] [[IDOR - Insecure Direct Object Reference]] [[Principle of Least Privilege]] [[CWE-306 Missing Authentication]] [[Role-Based Access Control (RBAC)]]