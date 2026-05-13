# CSRF — Cross-site Request Forgery

## What it is

In **Subnautica**, your Seamoth has a docking module on the Cyclops. The Cyclops doesn't check who's piloting the Seamoth — it just sees the docking signature, opens the bay, and pulls it in. A Warper learns the signature and rides the dock straight into your sub. The Cyclops trusted the vehicle, not the driver. That's exactly what CSRF does — the web app trusts the **browser session**, not the human behind it, so an attacker rides a legitimate cookie straight into a state-changing request.

**Plain English:** CSRF tricks an already-logged-in user's browser into firing a request they didn't intend to make. The server sees the valid session cookie and obeys.

**Technical definition (CS0-003):** Cross-site Request Forgery is a web application vulnerability in which an attacker causes an authenticated victim's browser to submit a forged HTTP request to a target application. The application processes the request as legitimate because the browser automatically attaches the session cookie. CSRF exploits the trust the application places in the browser; XSS, by contrast, exploits the trust the browser places in the application.

## Why it matters

CSRF lives quietly inside Objective 2.4 (recommend controls to mitigate software vulnerabilities) and OWASP Top 10's "Broken Access Control" category (where it landed after 2017, when it was demoted from its own slot because mainstream frameworks started shipping defenses by default). Demoted doesn't mean dead. Legacy apps, internal admin panels, IoT management consoles, and home-grown APIs still ship with no token, no SameSite, no Origin check.

Real-world stakes: password change without knowing the old password, fund transfer in a banking app, admin role assignment in a CMS, router config flip on a home gateway from a malicious ad. The 2008 home-router CSRF wave rewrote DNS settings on millions of consumer devices through an `<img>` tag.

For the analyst, CSRF matters because **it leaves almost no fingerprint**. The request comes from the victim's real IP, real User-Agent, real cookie. Your SIEM sees a normal session doing a normal action. The only tells are timing, Referer header (if present), and the impossible business logic — *the CFO just wired $80k to an account she's never used, from a session that was idle for 4 hours*.

## Key facts

### How the attack works

The victim is authenticated to `bank.example` — cookie sitting in the browser. The attacker hosts `evil.example` with a page containing:

```html
<form action="https://bank.example/transfer" method="POST" id="x">
  <input name="to" value="attacker-acct">
  <input name="amount" value="80000">
</form>
<script>document.getElementById('x').submit();</script>
```

Victim visits `evil.example` (phishing link, malvertising, compromised forum). Browser auto-submits, browser auto-attaches `bank.example` cookies (cross-origin cookie attachment is the default behavior unless SameSite says otherwise). Bank's server sees: valid session, valid cookie, well-formed POST. It processes the transfer.

No malware. No credential theft. No XSS payload on `bank.example`. Just abuse of the browser's ambient authority.

### Three preconditions (all required)

| Precondition | Meaning |
|---|---|
| **Cookie-based auth** | App authenticates via session cookie the browser sends automatically |
| **Predictable request** | Attacker can construct the full request — URL, params, body — without reading anything from the victim's session |
| **State-changing endpoint** | Endpoint actually does something — transfers funds, changes password, modifies role, posts content |

Break any one of these and CSRF dies.

### CSRF vs XSS vs SSRF — the three CompTIA confuses

| Attack | Trust abused | Runs where | Goal |
|---|---|---|---|
| **CSRF** | App trusts browser cookie | Victim's browser, attacker's HTML | Forge state-changing request as victim |
| **XSS** | Browser trusts app's HTML | Victim's browser, attacker's JS injected into vulnerable site | Steal session, deface, keylog, pivot to CSRF |
| **SSRF** | Server trusts its own outbound requests | Vulnerable server itself | Reach internal services (169.254.169.254, internal admin APIs) |

XSS and CSRF stack: stored XSS on the target site bypasses every CSRF defense because the attacker's payload is now running inside the trusted origin. CSRF tokens don't save you when the attacker can read them.

### Defenses, ranked

**1. SameSite cookies (the modern baseline).** Set `Set-Cookie: session=...; Secure; HttpOnly; SameSite=Lax` (or `Strict`). Browser refuses to send the cookie on cross-site POST navigations. Chrome made Lax the default in 2020. This kills the trivial CSRF case for free. `Strict` blocks top-level cross-site GETs too — better security, worse UX (user clicks a link from email, lands logged-out).

**2. Anti-CSRF tokens (synchronizer token pattern).** Server generates a random, per-session (or per-request) token, embeds it in every form. Browser submits form, server compares submitted token to session-stored token. Attacker on `evil.example` can't read the token (same-origin policy) so can't forge a valid request. This is the gold standard for legacy and high-value apps. Frameworks: Django (`{% csrf_token %}`), Rails (`protect_from_forgery`), ASP.NET (`AntiForgeryToken`), Spring (`CsrfFilter`).

**3. Double-submit cookie.** Server sets a random token as a cookie *and* requires the same value in a custom header or form field. Attacker can't read the cookie (same-origin) so can't echo it back. Cheaper than synchronizer (no server-side state), weaker against subdomain takeover.

**4. Origin / Referer header validation.** Server checks `Origin:` header against an allow-list. Modern browsers send Origin on all CORS and POST requests. Easy to add, defense in depth, not standalone — some proxies strip headers, some legacy browsers omit them.

**5. Require re-authentication for sensitive actions.** Password change, fund transfer, role assignment — re-prompt for password or MFA. Breaks the "predictable request" precondition because the attacker doesn't know the password.

**6. Custom request headers (for APIs).** Browsers won't let arbitrary cross-origin JS set custom headers without a CORS preflight. Require `X-Requested-With: XMLHttpRequest` and the cross-origin preflight fails on a misconfigured endpoint.

### What does NOT defend against CSRF

- **HTTPS / TLS** — encrypts the forged request, doesn't stop it
- **CAPTCHA on login** — login isn't the targeted endpoint
- **IP allow-listing** — request comes from the victim's IP
- **MFA at login** — session is already authenticated; CSRF rides the existing session
- **Checking POST vs GET** — attacker auto-submits forms; POST is trivial
- **HttpOnly cookies** — that's an XSS defense (stops JS reading cookies); CSRF doesn't need to read them

### CompTIA exam traps

> **CompTIA exam trap — CSRF vs SSRF.** Both have "request forgery" in the name. CSRF forges a request from the **victim's browser** to a site they're logged into. SSRF forges a request from the **vulnerable server** to a destination of the attacker's choosing (usually internal). Different attacker, different victim, different defense. Read the question for "authenticated user's browser" (CSRF) vs "server makes a request to" (SSRF).

> **CompTIA exam trap — CSRF lives under Broken Access Control.** OWASP moved it in 2021. Questions that ask "which OWASP Top 10 category does CSRF belong to" want "Broken Access Control" (A01:2021), not its own category anymore.

> **CompTIA exam trap — HttpOnly does not stop CSRF.** HttpOnly stops JavaScript from reading the cookie (an XSS mitigation). The browser still attaches the cookie automatically on cross-site requests. CompTIA loves to put HttpOnly in the answer pool for CSRF questions — it's the wrong answer.

> **CompTIA exam trap — Stored XSS bypasses CSRF tokens.** If the attacker has XSS on the target origin, they can read the token from the DOM and submit a valid request. Defense in depth: fix XSS first, then trust your CSRF tokens.

### Detection — why CSRF is hard to spot

CSRF leaves the victim's real session metadata on the request. The forensic signal is **behavioral**, not signature-based:

- **Referer mismatch** — request hits `/transfer` but Referer is `evil.example` or absent. Log Referer on sensitive endpoints.
- **Origin mismatch** — same play, more reliable (Origin is harder to spoof).
- **Impossible workflow** — user POSTs to `/admin/add-user` without ever GETting `/admin` in the same session.
- **Timing anomaly** — state-changing action seconds after a session was idle, with no preceding navigation.
- **Same session, weird User-Agent string change mid-session** — sometimes indicative, often not (mobile network switch).

WAF rules for CSRF are unreliable on their own — every CSRF-style request looks like a legitimate cross-site form post from somewhere. Behavioral baselines and endpoint-specific Origin/Referer checks at the app layer beat WAF signatures.

## SOC reality

- **The alert that fires:** rarely a "CSRF" alert. You get the *consequence* alert — "privileged role assigned outside normal change window," "wire transfer to new beneficiary," "admin password changed from non-admin IP." Then you reconstruct the session backward.
- **L1 first move:** pull the session timeline from the WAF and app logs. Look at the Referer/Origin on the state-changing POST. If it's blank or external and the endpoint should never accept that — escalate. Don't sit on it.
- **What the IR lead asks:** "Did the user actually perform this action? Can we confirm with them? Is the session token still valid? Have we revoked it?" Force a session invalidation on the suspected victim while you're still investigating.
- **Never promise leadership:** "It was definitely CSRF and not insider abuse" — you can't tell from logs alone in many cases. The forged request and the real user look identical on the wire. You need the user interview and the email/browser history to confirm.
- **Handoff:** L1 confirms the action and pulls logs → L2 reviews app-layer evidence and engages AppSec → AppSec audits the endpoint for missing tokens / SameSite / Origin checks → IR engages legal if money or PII moved. Lessons-learned ticket goes to the dev team with a CVE-style writeup and a code fix.

*Lesson from the war room: the CSRF report that came in on a Friday afternoon was "a user changed their email then immediately lost access." It wasn't account takeover via phishing. It was a CSRF on `/account/email-change` with no token, fired from a malicious ad on a logged-in tab. We'd had the endpoint in prod for four years. SameSite=Lax shipped in the next sprint. The token shipped the sprint after that. Both, because one defense is never enough.*

## Related concepts

[[XSS]] · [[SSRF]] · [[Broken Access Control]] · [[OWASP Top 10]] · [[Session Management]] · [[SameSite Cookies]] · [[Web Application Firewall]] · [[Same-Origin Policy]] · [[CORS]] · [[Synchronizer Token Pattern]] · [[MFA]] · [[Session Hijacking]] · [[Insecure Design]] · [[Security Misconfiguration]]

*Source: VIRGIL knowledge base — 2026-05-11*