```markdown
---
domain: "application-security"
tags: [csrf, web-security, owasp, attack, session-management, authentication]
---
# Cross-Site Request Forgery (CSRF)

**Cross-Site Request Forgery** (**CSRF**, pronounced "sea-surf," sometimes written **XSRF**) is a web application attack that coerces an authenticated user's browser into submitting an unwanted, state-changing HTTP request to a site where the victim currently holds an active session. It exploits the browser's automatic attachment of [[HTTP Cookies]] and other ambient credentials, abusing the asymmetry in the [[Same-Origin Policy]] between *reading* cross-origin responses (forbidden by default) and *sending* cross-origin requests (historically permitted). CSRF is sometimes called a **"confused deputy"** attack because the browser — acting as a trusted intermediary for the user — is manipulated into acting on behalf of an attacker without the user's knowledge.

---

## Overview

CSRF was formally described in the early 2000s, with Peter Watkins widely credited with coining the term in 2001. It rose to prominence as web applications became stateful and dependent on cookie-based authentication. It appeared in the **OWASP Top 10** from 2007 through 2013 (ranked as high as #5) and, while dropped as a standalone entry in the 2017 revision due to rising framework-level mitigations, the underlying vulnerability class persists and is now tracked under **A01: Broken Access Control** and **A05: Security Misconfiguration**. It remains an active concern wherever legacy applications, custom authentication schemes, or misconfigured [[SameSite Cookies]] are encountered.

The attack exploits a foundational property of HTTP and browsers: when a browser contacts `bank.example`, it automatically attaches every cookie scoped to `bank.example`, regardless of which page *originated* the request. If a victim is authenticated to `bank.example` and visits `evil.example` in another tab — or clicks a phishing link — an attacker-controlled page can trigger requests to `bank.example` carrying the victim's valid session cookie. If the server authenticates the request solely by inspecting the cookie, it cannot distinguish a legitimate user-initiated action from an attacker-forged one.

CSRF is fundamentally different from [[Cross-Site Scripting (XSS)]]. XSS involves injecting and executing attacker-controlled JavaScript *within* the victim site's own origin, granting access to DOM, cookies, and responses. CSRF operates *from an external origin* and does not require script execution on the target site. Critically, CSRF is a **write-only** or **fire-and-forget** attack: the Same-Origin Policy prevents the attacker from reading responses to the forged requests. This makes CSRF most destructive against endpoints that perform state mutations — fund transfers, password changes, account privilege escalation, DNS reconfiguration, user creation, and settings modification.

Historical incidents establish real-world impact. In 2008, researcher Vicente Aguilera Diaz demonstrated a CSRF attack against Gmail's filter-creation endpoint, allowing an attacker to silently configure mail forwarding for any authenticated user. In 2012, researcher Egor Homakov exploited a CSRF combined with mass assignment in GitHub, adding an arbitrary SSH public key to any user's account. Home and small-business router administration panels have been repeatedly targeted — attackers forge requests to modify DNS resolver settings, enabling persistent [[DNS Hijacking]] and [[Pharming]] attacks. Botnets including Muhstik and Mirai variants incorporated CSRF exploits against consumer router firmware in 2018 to facilitate large-scale DNS redirection.

Modern browsers have meaningfully reduced the default attack surface. In 2020, Chrome established `SameSite=Lax` as the default for cookies without an explicit attribute, followed by Firefox and Edge. Under `Lax`, the session cookie is omitted on cross-site POST requests and subresource loads, neutralizing the majority of classical CSRF vectors without any application code change. However, CSRF remains a live concern for applications that explicitly set `SameSite=None` (required for legitimate third-party embedding scenarios), applications relying on subdomain-scoped cookies, legacy frameworks predating SameSite, and non-browser API consumers.

---

## How It Works

A CSRF attack requires three preconditions: (1) the victim holds an active authenticated session on a target site, (2) that site relies on ambient credentials — cookies, HTTP Basic Auth, TLS client certificates, or Windows Integrated Authentication — without additional per-request proof of user intent, and (3) the attacker can induce the victim's browser to issue a request, typically by luring the victim to an attacker-controlled page.

### Attack Flow (Step by Step)

1. Victim authenticates to `https://bank.example`; server sets a session cookie.
2. Victim visits `https://evil.example/attack.html` — via phishing email, malicious ad, or compromised third-party site — while still logged in.
3. `attack.html` contains HTML or JavaScript that initiates a cross-origin HTTP request to `bank.example`.
4. The browser automatically appends the `bank.example` session cookie to the outbound request.
5. `bank.example` validates the cookie, finds a live session, and processes the forged request as though the user initiated it.

### GET-Based CSRF

If a vulnerable endpoint accepts state-changing operations via HTTP GET — a common anti-pattern in legacy applications — the attack requires nothing more than an `<img>` tag:

```html
<!-- Hosted on evil.example/attack.html -->
<img
  src="https://bank.example/transfer?to=attacker&amount=10000"
  width="0" height="0"
  style="display:none">
```

The browser fetches the "image," silently executing the transfer. No JavaScript is required, and no visible element appears on screen.

### POST-Based CSRF

POST endpoints are equally vulnerable if no token is enforced. An attacker hosts an auto-submitting form:

```html
<form id="xsrf" action="https://bank.example/transfer" method="POST">
  <input type="hidden" name="to"     value="attacker">
  <input type="hidden" name="amount" value="10000">
</form>
<script>document.getElementById('xsrf').submit();</script>
```

HTML forms can POST to any origin without CORS restrictions, using the three CORS "simple" content types: `application/x-www-form-urlencoded`, `multipart/form-data`, and `text/plain`. No preflight OPTIONS request is sent for these types, so the browser submits immediately with full cookies.

### JSON-Body CSRF

APIs accepting `Content-Type: application/json` normally trigger a CORS preflight (OPTIONS request), providing a natural gating point. However, if a server accepts `text/plain` as a proxy for JSON, an attacker can bypass the preflight:

```html
<!-- Enctype text/plain encodes the body as: key=value with no URL encoding -->
<form action="https://api.example/v1/users" method="POST" enctype="text/plain">
  <input name='{"role":"admin","user":"attacker","x":"' value='legitimate"}'>
</form>
<script>document.forms[0].submit();</script>
```

The body sent becomes:
```
{"role":"admin","user":"attacker","x":"=legitimate"}
```
If the server parses this loosely, the injection succeeds.

### Login CSRF

An inverted variant: the attacker forges a *login* request using the attacker's own credentials, causing the victim's browser to become authenticated to the attacker's account. The victim then unknowingly uploads files, performs searches, or enters payment details that the attacker can subsequently review by logging back in with their own credentials. This variant is often overlooked because it targets the login form itself rather than an authenticated action.

### The Forged HTTP Request in Detail

The following shows exactly what arrives at the target server during a POST-based CSRF. The only observable differences from a legitimate request are the `Origin` and `Referer` headers:

```http
POST /transfer HTTP/1.1
Host: bank.example
Origin: https://evil.example
Referer: https://evil.example/attack.html
Cookie: SESSIONID=abc123; HttpOnly
Content-Type: application/x-www-form-urlencoded
Content-Length: 27

to=attacker&amount=10000
```

A server that validates only the `Cookie` header will process this request without error. Only servers that also validate `Origin`, `Referer`, or a CSRF token will reject it.

---

## Key Concepts

- **Ambient Authority**: Credentials that the browser attaches automatically based solely on the request destination (cookies, Basic Auth, Kerberos/NTLM, TLS client certs), regardless of which page originated the request. CSRF fundamentally exploits ambient authority — the attacker never needs to know or steal the credential.
- **Confused Deputy Problem**: A security concept in which a privileged agent (the browser) is tricked by a less-privileged caller (the attacker's page) into misusing its authority on behalf of a legitimate principal (the authenticated user). CSRF is the canonical web-era confused deputy — the browser holds the "keys" and is manipulated into using them.
- **Synchronizer Token Pattern**: The classical server-side CSRF defense. The server generates a cryptographically random, unpredictable token per session (or per form), embeds it as a hidden field, and verifies it on every state-changing request. An attacker on a different origin cannot read the token due to Same-Origin Policy enforcement, so they cannot forge a valid request.
- **Double-Submit Cookie**: A stateless CSRF token variant — the server sets a random value as both a cookie and a form/query parameter and verifies they match on submission. Cheaper than server-side session storage but weaker against attackers who can write cookies (e.g., via subdomain compromise or network interception).
- **SameSite Cookie Attribute**: A cookie flag with three values — `Strict` (cookie sent only for same-site navigations), `Lax` (cookie sent on top-level navigations and same-site requests but withheld on cross-site POSTs and subresource loads, now the browser default), and `None` (cookie sent in all contexts, requires `Secure`). `Lax` and `Strict` mitigate the majority of classical CSRF without application-code changes.
- **Origin Header Validation**: Checking the `Origin` header (or `Referer` as fallback) against an allowlist of known, expected origins. While not sufficient as a standalone defense (headers can be absent or spoofed in edge cases), it is a lightweight defense-in-depth measure easily added at the reverse-proxy or application tier.
- **Login CSRF**: A CSRF attack targeting the authentication form rather than a post-login action, tricking the victim into operating inside the attacker's account. Mitigated by including anti-CSRF tokens on login forms, a step many developers neglect.
- **State-Changing Request**: Any HTTP request that creates, modifies, or deletes server-side data. CSRF defenses must protect all such endpoints; read-only `GET` requests must not perform mutations (a REST design requirement that also eliminates the simplest CSRF vector).

---

## Exam Relevance

For **CompTIA Security+ SY0-701**, CSRF is tested under **Domain 2.3** (explaining types of vulnerabilities) and **Domain 4.1** (applying application security techniques):

- **Core definition you must know**: CSRF forces an authenticated user's browser to send an unwanted HTTP request to a trusted site by exploiting automatic cookie transmission. One sentence, exam-ready.
- **CSRF vs. XSS — the most common distractor pair**: XSS injects malicious script *into* the trusted site's origin; CSRF abuses the victim's session *from* an external origin. If a scenario describes an attacker inserting script visible on the target page → XSS. If a scenario describes a victim clicking a link and an action occurring on a site they're already logged into → CSRF.
- **CSRF vs. SSRF**: [[Server-Side Request Forgery (SSRF)]] abuses the *server* making outbound HTTP requests (internal network pivoting); CSRF abuses the *browser* making requests. These appear as paired answer choices — know the direction of the forged request.
- **Mitigations CompTIA expects**: anti-CSRF tokens (synchronizer tokens), SameSite cookie attribute, re-authentication for sensitive actions, validating `Origin`/`Referer` headers, and requiring custom request headers for AJAX APIs.
- **"Confused deputy"** — if this phrase appears in a question about web attacks, the answer is almost certainly CSRF.
- **Scenario recognition**: "User received an email, clicked a link, and their account settings were changed without their knowledge while they were logged in" → CSRF. "User visited a page and saw a pop-up or alert box with injected content" → XSS. "User was redirected to a fake login page" → [[Phishing]] or [[Clickjacking]].
- **Gotcha**: CSRF tokens and CAPTCHA both require user interaction. Don't confuse CAPTCHA (bot prevention) with CSRF tokens (forged-request prevention) — they solve different problems and the exam occasionally presents them as equivalent.
- **Framework defaults**: CompTIA expects awareness that major frameworks (Django, Spring, ASP.NET Core, Rails) include CSRF protection by default — a common application security best practice.

---

## Security Implications

CSRF's impact scales directly with the privilege of the victim session and the sensitivity of the targeted endpoint. A successful CSRF attack against an administrator session can create new privileged accounts, disable audit logging, exfiltrate data indirectly by reconfiguring delivery channels, or install backdoors in application settings. Against end-user sessions it enables unauthorized financial transactions, unauthorized data submission, social-engineering pivots, and identity theft.

### Notable CVEs and Incidents

- **CVE-2018-10562 / CVE-2018-10561** — Dasan GPON home routers; unauthenticated command injection combined with CSRF allowed full device takeover. Exploited by Muhstik and Mirai botnet variants to reflash firmware and redirect DNS globally.
- **CVE-2019-13143** — Multiple D-Link router models; CSRF permitted remote administrative actions (including DNS and firewall changes) without user interaction, affecting millions of home networks.
- **CVE-2021-22116** — RabbitMQ Management UI; CSRF on administrative endpoints could trigger broker-level actions including user creation and permission modification.
- **CVE-2020-8163 / CVE-2020-8164** — Ruby on Rails; CSRF-adjacent flaws in request handling reinforcing why framework upgrades matter.
- **2008 Gmail Filter CSRF** (researcher: Vicente Aguilera Diaz) — Gmail's filter-create endpoint accepted forged cross-origin POST requests; attackers could silently configure mail forwarding for any authenticated Gmail user, enabling large-scale surveillance.
- **2012 GitHub SSH Key CSRF** (researcher: Egor Homakov) — A CSRF attack combined with Rails mass-assignment allowed adding an attacker's SSH public key to an arbitrary GitHub user, granting repository push access.
- **2006 ING Direct CSRF** — Demonstrated money transfers initiated from attacker-controlled pages against the bank's authenticated sessions.

### Detection Signals

CSRF leaves minimal forensic traces because the forged request is syntactically valid and carries a real session. Investigative signals include:

- Requests to state-changing endpoints with `Origin` or `Referer` values that do not match the expected application domain.
- Absence of expected custom headers (e.g., `X-CSRF-Token`, `X-Requested-With`) on requests that the legitimate front-end always includes.
- State-change events occurring outside normal user navigation flows (e.g., no preceding GET to the corresponding form page in the same session).
- Anomalous spikes in sensitive-action endpoints (password resets, privilege changes) from sessions with atypical referrer paths.
- [[Web Application Firewall (WAF)]] rules in the OWASP Core Rule Set (CRS), specifically rules in the 920xxx family, can flag missing or mismatched `Origin`/`Referer` on POST requests — useful as a detection layer, though insufficient as a primary control.

---

## Defensive Measures

Defense in depth is the standard approach; no single control is universally sufficient. The following measures should be layered.

### 1. Anti-CSRF Tokens — Synchronizer Token Pattern

Generate a cryptographically random (minimum 128-bit) token per session or per form render. Embed it as a hidden field and require it on all state-changing requests. Reject requests where it is absent or incorrect.

Major framework implementations:

| Framework | Mechanism |
|---|---|
| Django | `{% csrf_token %}` in templates; `