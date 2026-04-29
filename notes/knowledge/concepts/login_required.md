# login_required

## What it is
Like a bouncer checking wristbands before letting anyone onto the dance floor, `login_required` is a decorator or middleware mechanism that enforces authentication before granting access to a protected resource. It intercepts incoming requests and redirects unauthenticated users to a login page before the underlying function or route ever executes.

## Why it matters
In 2021, a misconfigured Django application exposed an admin dashboard because a developer forgot to apply `@login_required` to a sensitive API endpoint — unauthenticated users could enumerate user records directly. This class of vulnerability is categorized under **Broken Access Control** (OWASP #1), where missing authentication checks allow unauthorized data exposure or privilege escalation.

## Key facts
- `login_required` enforces **authentication**, not **authorization** — it only verifies *who you are*, not *what you're allowed to do*
- In Django, the decorator redirects unauthenticated requests to `settings.LOGIN_URL` and appends a `?next=` parameter to return users post-login
- Forgetting `login_required` on even one route creates a **forced browsing** vulnerability — attackers can directly access URLs by guessing or enumerating paths
- Properly combined with role checks (e.g., `@permission_required`), it forms the foundation of **defense-in-depth** at the application layer
- Session tokens must still be validated server-side — `login_required` is only as strong as the session management beneath it; stolen cookies bypass it entirely

## Related concepts
[[Broken Access Control]] [[Session Management]] [[Authentication vs Authorization]] [[Forced Browsing]] [[Middleware Security]]