# Cross-Site Request Forgery

## What it is
Imagine a forger who slides a document under your hand while you're signing something else — you unknowingly sign their paper too. CSRF works the same way: a malicious site tricks your authenticated browser into sending an unauthorized request to another site where you're already logged in, exploiting the browser's automatic cookie-sending behavior. The victim's credentials are genuine; only the intent is forged.

## Why it matters
In 2008, attackers used CSRF to change router DNS settings on thousands of home devices — victims simply visited a malicious page while authenticated to their router's admin panel, and the page silently submitted a form that pointed DNS to attacker-controlled servers. The defense that stopped this class of attack at scale was the anti-CSRF token: a secret, session-specific value embedded in forms that the server validates before acting on any state-changing request.

## Key facts
- CSRF targets **state-changing requests** (fund transfers, password resets, account changes) — it cannot read responses, so it cannot steal data directly
- The primary defense is a **synchronizer token pattern**: a random token tied to the user session, included in every form, and validated server-side
- **SameSite cookie attribute** (`Strict` or `Lax`) is a modern browser-level defense that prevents cookies from being sent on cross-origin requests
- CSRF requires the victim to be **authenticated** to the target site and to trigger the malicious request (usually by visiting an attacker-controlled page)
- HTTP **GET requests should never perform state changes** — CSRF exploits are trivial via `<img src="...">` tags if GET is misused
- Differs from XSS: XSS injects malicious scripts into a trusted site; CSRF uses the user's trust in a site against it

## Related concepts
[[Cross-Site Scripting]] [[Same-Origin Policy]] [[Session Management]] [[Cookie Security Attributes]]