# Session Hijacking

## What it is

In **Doom**, when you grab the BFG-9000, the game doesn't ask you to prove you're Doomguy every time you pull the trigger. You picked it up, it's yours, it fires until you drop it or die. Now imagine a demon could yank that weapon out of your hands mid-fight — same BFG, same ammo, now pointed at your face. That's session hijacking. The web server already trusts the session token; it doesn't care who's holding it. Whoever holds the token *is* the user, until that token expires or gets revoked.

In plain English: a **session** is the server's way of remembering you after you log in, so you don't have to re-authenticate on every click. The server hands you a token (usually a cookie), and on every subsequent request you wave that token at the door. **Session hijacking** is any attack where an adversary obtains that token and uses it to impersonate you — no password needed, no MFA prompt, no anomaly because from the server's perspective it's the same valid session.

Technical definition: session hijacking is the unauthorized acquisition and use of a valid session identifier (session ID, session cookie, JWT, OAuth bearer token) to gain authenticated access to a system without possessing the underlying credentials. The attack bypasses authentication entirely by stealing the *artifact* of a completed authentication.

## Why it matters

Authentication is a one-time event. Authorization rides on the session token for the rest of the session lifetime. That means a stolen token sidesteps every control you put on the login page — password complexity, MFA, geo-fencing, impossible travel detection — because none of those controls re-evaluate after the token is issued. Most apps don't bind tokens to anything verifiable (IP, device fingerprint, TLS channel), so a token lifted off a coffee-shop Wi-Fi works just as well from Belarus.

For CySA+ (Objective 2.2), session hijacking shows up when you're reading output from web app scanners — **[[Burp Suite]]**, **[[OWASP ZAP]]**, **[[Nikto]]**, **[[Arachni]]** — and you see findings like "session cookie missing Secure flag," "session ID predictable," "session does not regenerate after authentication." Those aren't theoretical lint warnings. Each one is a documented path to an account takeover.

## Key facts

### How sessions actually work

| Component | What it does | Where it lives |
|---|---|---|
| **Session ID** | Random opaque string the server uses to look up session state | Server-side (in memory, Redis, DB) |
| **Session cookie** | Carries the session ID to the client | Browser cookie jar |
| **JWT (stateless)** | Self-contained signed token holding claims; no server lookup | Cookie or `Authorization: Bearer` header |
| **OAuth access token** | Bearer credential for API authorization | Authorization header, sometimes cookie |

The server's contract: "Show me this token, get this user's permissions." It doesn't care *how* you got the token. That's the whole vulnerability class.

### The four ways tokens get stolen

**1. Cross-site scripting ([[XSS]])** — attacker injects JavaScript that reads `document.cookie` and exfiltrates it. If the cookie isn't flagged `HttpOnly`, JS can read it. Stored XSS in a comment field will harvest tokens from every user who loads the page.

**2. Insecure cookies in transit** — cookie without the `Secure` flag gets sent over plain HTTP. Anyone on the path (rogue access point, ISP-level adversary, compromised router) sniffs it. This was the classic **Firesheep** attack circa 2010 — Facebook session cookies plucked off coffee-shop Wi-Fi with a Firefox extension.

**3. Local compromise** — malware on the endpoint reads the browser's cookie store directly. Stealers like RedLine, Raccoon, and Lumma do exactly this — they dump Chrome's `Cookies` SQLite database, decrypt it with the local DPAPI key, and ship the cookies to a C2. This is why corporate Gmail accounts get owned even with MFA: the stealer takes the post-MFA session, not the password.

**4. Network interception / MITM** — TLS downgrade, certificate spoofing, or sitting on a path where TLS isn't enforced. Less common now but still alive in IoT, internal apps with self-signed certs nobody validates, and any place where users click through cert warnings.

There's a fifth, less common: **session fixation**. Attacker sets a known session ID on the victim (via a crafted link, an XSS, or a subdomain cookie), waits for the victim to log in, then uses the now-authenticated known ID. Defeated by regenerating the session ID at login.

### What an attacker does with the token

```
GET /api/account/profile HTTP/1.1
Host: bank.example.com
Cookie: SESSIONID=8f3a9c2d1e7b4f06...
```

Replay that request from anywhere. The server returns the victim's profile. No password challenge, no MFA, no friction. From the server's logs, it looks like a normal request — same cookie, same user-agent if the attacker bothered to spoof it. The only tell is usually the source IP, and that's it.

### Mitigations — what actually defends a session

| Defense | What it stops |
|---|---|
| **`Secure` flag** | Cookie only sent over HTTPS — kills passive network sniffing |
| **`HttpOnly` flag** | JavaScript can't read the cookie — kills XSS exfiltration |
| **`SameSite=Strict` or `Lax`** | Cookie not sent on cross-site requests — kills [[CSRF]] and some hijack vectors |
| **HSTS** | Browser refuses HTTP entirely — kills downgrade attacks |
| **Session regeneration on auth** | New session ID issued at login — kills session fixation |
| **Short session lifetime + idle timeout** | Stolen token expires fast |
| **Token binding (channel binding, device fingerprint)** | Token only valid from original TLS channel or device |
| **Re-auth for sensitive actions** | Money transfer, password change, MFA settings — require fresh auth |
| **Anomaly detection on session use** | Same token from two countries in five minutes — kill the session |

For JWTs specifically: short expiry, refresh-token rotation, signature validation (don't accept `alg: none`, don't accept algorithm confusion attacks), and a revocation list for compromised tokens. Stateless tokens are a pain to revoke — that's the tradeoff.

### What the scanners actually flag

When you're reading **[[Burp Suite]]** or **[[ZAP]]** output (Objective 2.2 territory):

- **"Cookie without Secure flag"** — token can leak over HTTP
- **"Cookie without HttpOnly flag"** — JS can read it, XSS becomes account takeover
- **"Cookie without SameSite attribute"** — CSRF and cross-site leakage possible
- **"Session token in URL"** — gets logged in proxies, browser history, Referer headers
- **"Session ID does not change after login"** — session fixation possible
- **"Predictable session ID"** — token is guessable (incrementing integer, weak PRNG)
- **"Session does not expire"** — stolen token works forever

**[[Nikto]]** will catch missing flags on Set-Cookie headers. **[[Arachni]]** and **[[OWASP ZAP]]** will actively test for fixation and predictability. **[[Nessus]]** and **[[OpenVAS]]** catch cookie misconfiguration in their web app modules. **[[Metasploit]]** has auxiliary modules to harvest cookies once you're on-path.

### CompTIA exam traps

> **CompTIA exam trap:** Session hijacking vs session fixation — they're related but distinct. *Hijacking* steals an existing authenticated session. *Fixation* forces the victim to use an attacker-chosen session ID *before* they authenticate, then rides it after login. The mitigation for fixation is specifically **session ID regeneration at authentication** — a Secure/HttpOnly cookie alone won't stop fixation.

> **CompTIA exam trap:** `Secure` and `HttpOnly` flags do different things and CompTIA loves swapping them. **`Secure` = HTTPS-only transmission** (network defense). **`HttpOnly` = no JavaScript access** (XSS defense). A cookie needs both. Knowing only one is the wrong answer.

> **CompTIA exam trap:** MFA does **not** prevent session hijacking after the fact. MFA gates the *creation* of the session. Once the token exists, MFA is out of the loop. This is why infostealer malware is so effective against MFA-protected accounts — it steals the post-MFA cookie.

> **CompTIA exam trap:** A "session token in the URL" finding is not a low-severity cosmetic issue. URLs get logged everywhere — web server access logs, upstream proxies, browser history, Referer headers leaking to third-party sites. Treat it as a credential disclosure.

## SOC reality

- The 3am alert isn't "session hijacking detected." It's **"user logged in from $COUNTRY_A and $COUNTRY_B within 4 minutes"** in the impossible-travel rule, or **"unusual user-agent for service account"** in the UEBA dashboard. Session hijacking is almost always discovered by *consequence* — anomalous activity on a session — not by the theft itself.

- L1 first action: confirm it's not a VPN flap or a mobile-data handoff (those generate impossible-travel false positives constantly). If the geo gap is real and the second login is doing things the user doesn't normally do — pulling reports, changing forwarding rules, downloading SharePoint sites — escalate to L2 and **revoke the session immediately**. Don't wait for confirmation. Killing a session is cheap; letting an exfil run is not.

- The IR lead's first three questions: *"Which session? When was it created? What has it accessed since?"* If you can't answer those from your IdP and proxy logs, your session telemetry is the gap to fix before the next incident.

- Never tell leadership "we've reset their password and we're good." Password reset doesn't kill existing sessions on most platforms unless you explicitly revoke tokens / sign out all devices. *I learned that one watching a stealer victim get re-owned 20 minutes after the helpdesk "fixed" the account by rotating the password.*

- The handoff to legal/HR: if the hijacked session accessed regulated data (PII, PHI, cardholder data), notification timelines start the moment you confirm unauthorized access — not when you finish investigating. The session log *is* the evidence. Preserve it before the retention window rotates it out.

## Related concepts

[[XSS]] · [[CSRF]] · [[Cookies — Secure HttpOnly SameSite]] · [[OAuth and JWT]] · [[Burp Suite]] · [[OWASP ZAP]] · [[Nikto]] · [[Arachni]] · [[Metasploit]] · [[Impossible Travel Detection]] · [[UEBA]] · [[Infostealer Malware]] · [[MFA Bypass Techniques]] · [[Session Fixation]] · [[Web Application Vulnerabilities]]

*Source: VIRGIL knowledge base — 2026-05-11*