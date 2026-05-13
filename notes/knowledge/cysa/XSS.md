# XSS — Cross-site Scripting

## What it is

In **Smash Bros**, Kirby's whole gimmick is Inhale. Swallow Mario, you spit fireballs. Swallow Samus, you charge a beam. Swallow Pikachu, you throw lightning. Kirby doesn't have those moves — he's borrowing the victim's identity to use the victim's powers. The stage trusts the attack because it's coming from a legitimate fighter slot.

That's exactly what XSS does — the attacker doesn't hit the server, they ride into the **victim's browser** wearing the trusted site's hat and execute JavaScript with all the privileges that site has on that user.

**Technical definition.** Cross-site Scripting is a client-side injection vulnerability where untrusted input is rendered into a web page without proper output encoding or input validation, causing the victim's browser to execute attacker-controlled script in the security context (origin) of the trusted application. Because the script runs under the site's origin, it inherits that site's cookies, session tokens, DOM access, and any same-origin API access.

XSS is a **subset of injection flaws** — same family as SQLi, command injection, LDAPi — but the interpreter being abused is the user's browser, not a database engine.

## Why it matters

XSS sits in the OWASP Top 10 under **A03:2021 — Injection** (it got folded in from its old standalone slot, but CompTIA still tests it by name). It's the most common high-impact web vulnerability you'll see in real scan output, and it's the one developers most often dismiss as "just a popup." That dismissal is how session tokens end up exfiltrated to a Discord webhook.

Career relevance — every SOC analyst pulling tickets from a WAF or a DAST tool will see XSS findings weekly. You need to know how to confirm them, how to scope them, and how to push back when a developer says "we sanitize input" but they actually mean "we strip `<script>` and call it a day."

**Exam relevance:** CS0-003 Objective 2.4 — recommend controls to mitigate attacks and software vulnerabilities. XSS is named explicitly alongside reflected, persistent, and DOM variants. Expect questions that hand you scanner output and ask which control class fixes it (hint: not the firewall).

## Key facts

### The three flavors

| Type | Where the payload lives | Trigger | Blast radius |
|---|---|---|---|
| **Stored / Persistent** | Saved server-side (database, comment, profile field, support ticket) | Every user who loads the affected page | Highest — one payload, mass execution |
| **Reflected** | In the request itself (URL parameter, form post) | Victim clicks a crafted link, server echoes it back | Per-target — needs social engineering |
| **DOM-based** | Never touches the server — payload manipulates the page's DOM via client-side JS | Vulnerable JS reads from `location.hash`, `document.URL`, etc. | Per-target, harder to detect server-side |

Stored is the nuclear option. A persistent XSS in a help-desk ticket field means every support agent who opens the ticket gets their session hijacked. Reflected is phishing's accomplice — one crafted link in an email, one click, game over for that user. DOM-based is the sneaky one because the **server logs show nothing** — the payload is processed entirely in the browser by the site's own JavaScript.

### What the attacker actually does with it

People hear "XSS" and picture `alert(1)`. Real payloads do work:

- **Session hijack** — `document.cookie` exfil to attacker-controlled host (defeated by `HttpOnly` cookies, which is why that flag exists)
- **Credential harvesting** — overlay a fake login form on the real page; the origin is legitimate, the TLS lock is green, the user has zero reason to suspect
- **CSRF amplification** — XSS bypasses [[CSRF]] tokens because the script can just *read* the token from the DOM and forge a valid request
- **Keylogging** — `addEventListener('keydown', ...)` and ship keystrokes off-site
- **Browser pivot / [[BeEF]]** — hook the browser into a command framework, scan the internal network from the victim's machine
- **Worming** — the Samy MySpace worm (2005) hit a million profiles in 20 hours via stored XSS that re-propagated itself

### What a scanner finding looks like

Burp, ZAP, Acunetix, Nessus all flag XSS with telltale signatures:

- Parameter value reflected unencoded in the response body
- "CGI Generic XSS" or "Reflected XSS in parameter X" findings
- The probe string (often `<script>alert(1)</script>` or a unique canary like `xss7351`) appears unescaped between HTML tags or inside a JS context
- High false-positive rate in WYSIWYG editor fields — confirm manually before paging anyone

### Mitigations — what actually works

| Control | What it does | Where it goes |
|---|---|---|
| **Output encoding (context-aware)** | Encodes `<`, `>`, `"`, `'`, `&` based on where the data is rendered (HTML body, attribute, JS, URL, CSS) | Every output point. This is the real fix. |
| **Input validation (allow-list)** | Rejects input that doesn't match expected format | Defense in depth, not a primary control |
| **Content Security Policy (CSP)** | Browser-enforced policy that blocks inline scripts and unauthorized origins | HTTP response header |
| **HttpOnly cookies** | Blocks `document.cookie` from JS access | Cookie flag, blunts session theft |
| **Secure & SameSite cookies** | Reduces token leakage and cross-site request abuse | Cookie flag |
| **Framework auto-escaping** | React, Angular, modern templating engines escape by default — until a dev calls `dangerouslySetInnerHTML` | Use the framework correctly |
| **WAF signatures** | Catch known payload patterns at the edge | Speed bump, not a fix — trivially bypassed by encoding tricks |

The fix is **output encoding in the right context**. Sanitizing input is fine as defense-in-depth, but you can't predict every place that input gets rendered downstream. Encode at the moment of output, using the encoder for the context you're rendering into.

### CSP — the airbag

A strong [[Content Security Policy]] turns successful XSS injection into a non-event because the browser refuses to execute inline scripts or fetch from unauthorized origins. `default-src 'self'; script-src 'self'; object-src 'none'` is a reasonable starting posture. CSP doesn't *prevent* XSS — it limits what the injected script can *do*. Treat it as the airbag, not the seatbelt.

### CompTIA exam traps

> **CompTIA exam trap:** "A firewall will mitigate XSS." No. Network firewalls are L3/L4 — they don't inspect HTTP payload content. A **WAF** (web application firewall, L7) can pattern-match some XSS attempts, but the *correct* answer for mitigation is **input validation and output encoding**, not "the firewall."

> **CompTIA exam trap:** Stored vs Reflected vs DOM. Memorize the trigger: stored = saved on server, fires for every viewer; reflected = in the request, fires when victim clicks crafted link; DOM = never touches server, fires when client-side JS reads tainted source. CompTIA will give you a scenario and you pick the type.

> **CompTIA exam trap:** XSS is **client-side**. [[SQL injection]] is server-side. [[SSRF]] (server-side request forgery) makes the *server* fetch attacker-chosen URLs. [[CSRF]] (cross-site request forgery) makes the *victim's browser* send forged requests using its existing session. CompTIA loves to scramble these four. The mnemonic: XSS runs script in your browser, CSRF rides your session, SSRF rides the server's network position, SQLi talks to the database.

> **CompTIA exam trap:** "HttpOnly cookies prevent XSS." No. They prevent **session theft via XSS**. The XSS still executes — the attacker just can't grab the cookie. They can still keylog, deface, phish, and pivot.

### XSS in the family of injection flaws

CompTIA Objective 2.4 lists XSS alongside [[SQL injection]], [[command injection]], [[LDAP injection]], [[XML injection]], and [[directory traversal]]. They share a root cause: **data is being treated as code by some interpreter** because the boundary between the two wasn't enforced. The interpreter varies — browser JS engine for XSS, SQL parser for SQLi, shell for command injection, file system path resolver for directory traversal. The fix pattern is always the same: **parameterize, encode, or validate at the boundary**.

## SOC reality

- **The ticket at 3am** says "Reflected XSS detected in /search?q=" with a Burp screenshot of an alert box. L1 confirms: is the payload actually executing, or did the scanner just see the string echoed inside an HTML comment where it can't run? Half of XSS findings are false positives because the reflection lands in a non-executable context. *I have closed more "critical XSS" tickets as false positive than I have escalated real ones — confirm before you wake anyone.*

- **The L1 first action** — reproduce the finding manually in a sandboxed browser, capture the request/response pair, check whether the affected parameter requires authentication. Unauthenticated stored XSS on a customer-facing page is a different fire than authenticated reflected XSS in an admin tool.

- **What the IR lead asks** when stored XSS is confirmed live: "How long has the payload been in the database? Pull the audit log on that field. Who viewed the affected page since insertion? Are any of those sessions still active?" You're now in [[incident response]] — this is a live data exposure event, not a vulnerability finding.

- **Never promise** "we patched it" until the developer's fix is verified in production with the original payload *and* three encoding variants (URL-encoded, HTML-entity-encoded, Unicode-escaped). Devs love to fix the specific string the scanner reported and miss the class of bug.

- **The escalation path** — L1 confirms and triages, L2 scopes blast radius via log analysis (who hit the vulnerable endpoint, who rendered the stored payload), application security team owns the code fix, IR owns session invalidation and customer notification if PII was exposed. Legal gets involved if the affected data crosses regulatory thresholds — [[GDPR]] 72-hour notification clock starts when you have reasonable belief PII was accessed.

*The hard-learned lesson: XSS is not a popup. It's a foothold inside your users' browsers, executing as your application, with your application's permissions. Treat every confirmed XSS like the attacker is already logged in as one of your users — because in any meaningful sense, they are.*

## Related concepts

[[SQL injection]] · [[CSRF]] · [[SSRF]] · [[Command injection]] · [[Directory traversal]] · [[Content Security Policy]] · [[OWASP Top 10]] · [[Input validation]] · [[Output encoding]] · [[WAF]] · [[Session hijacking]] · [[BeEF]] · [[DAST]] · [[SAST]] · [[HttpOnly cookies]] · [[SameSite cookies]] · [[Injection flaws]] · [[Insecure design]] · [[Secure coding]]

*Source: VIRGIL knowledge base — 2026-05-11*