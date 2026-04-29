# confused deputy

## What it is
Imagine a corrupt notary who stamps documents on behalf of clients without checking whether *they* have the right to authorize what's being stamped — the notary's authority gets hijacked by whoever walks in the door. A confused deputy attack occurs when a privileged program (the "deputy") is tricked by a less-privileged caller into using its elevated permissions to perform actions the caller couldn't do directly. The deputy is confused because it acts on the *caller's* behalf without verifying whether that caller is entitled to the outcome.

## Why it matters
Cross-Site Request Forgery (CSRF) is the textbook confused deputy attack: your browser (the deputy, already authenticated to your bank) is tricked by a malicious site into submitting a funds-transfer request using your session cookie — authority the attacker couldn't wield directly. Defenses like CSRF tokens force the deputy to verify that the *legitimate principal* actually initiated the request, not just that valid credentials are present.

## Key facts
- The vulnerability lives in the deputy program, not the attacker — the deputy fails to distinguish *who* is making a request from *what authority* that request should carry.
- CSRF, clickjacking, and some privilege escalation attacks are all confused deputy variants.
- The classic fix is **capability-based security**: tie permissions to specific tokens passed explicitly, rather than ambient authority (e.g., session cookies inherited automatically by the browser).
- Server-Side Request Forgery (SSRF) is a server-side confused deputy — the server fetches internal resources on behalf of an attacker's crafted URL.
- The term was coined by Norm Hardy in 1988 using a compiler/billing-system example.

## Related concepts
[[Cross-Site Request Forgery]] [[Server-Side Request Forgery]] [[privilege escalation]] [[ambient authority]] [[capability-based security]]