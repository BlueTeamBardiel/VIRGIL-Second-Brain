```yaml
---
domain: "application-security"
tags: [csrf, web-security, attack, owasp, session-management, authentication]
---
```

# CSRF/Forgery

**Cross-Site Request Forgery (CSRF)**, also called **XSRF**, **session riding**, or **one-click attack**, is a web application vulnerability in which an attacker causes an authenticated victim's browser to submit an unwanted, state-changing request to a target site without the victim's knowledge. Unlike [[XSS]], which abuses the trust a user places in a website, CSRF abuses the **trust a website places in the user's browser** — exploiting **ambient authority** carried by [[Cookies]], [[HTTP Basic Authentication]] credentials, or [[Kerberos]] tickets that browsers attach automatically to all matching outbound requests. It is classified as **CWE-352** and has been a fixture of the [[OWASP Top 10]] since 2007.

---

## Overview

CSRF was formally documented by Peter Watkins in a 2001 Bugtraq post, though the underlying class of problem — the **confused deputy** — predates the web entirely. It rose to prominence throughout the 2000s as web applications began relying almost exclusively on session cookies for authentication without verifying the *intent* behind incoming requests. The vulnerability appeared on the [[OWASP Top 10]] as A5 in 2007 and A8 in 2013, then was dropped as a standalone category in 2017 because mainstream frameworks had begun shipping built-in mitigations by default; it is currently tracked under Broken Access Control (A01:2021) and remains on OWASP's supplemental list.

The attack exploits a fundamental browser behavior: the [[Same-Origin Policy]] restricts cross-origin *reads* but has never restricted cross-origin *writes* (requests). A page hosted on `evil.com` cannot read the HTML returned by `bank.com`, but it can freely cause the browser to issue a `POST` to `bank.com/transfer` — and the browser will attach any cookies scoped to `bank.com`. If the victim is authenticated, the bank's server receives what appears to be a legitimate, well-formed, credentialed request and processes it in full.

CSRF is strictly a **state-changing attack**. Exfiltrating data cross-origin is the province of [[XSS]] or [[CORS]] misconfigurations; CSRF's payoff is forcing unwanted side effects: transferring money, changing an account email address, adding an SSH key, resetting a password, altering router DNS settings, or administering an embedded device through its management web UI. Because the attacker never receives the server's response to the forged request, the attack is inherently "blind" — the payload must be engineered in advance to achieve the desired side effect in a single round trip.

Historically significant incidents include the **2008 ING Direct CSRF** (unauthorized fund transfers from any customer account), a **2006 Netflix CSRF** (silently modifying shipping addresses and rental queues), the **2008 uTorrent CSRF** (triggering arbitrary file downloads through a localhost web UI), and a sustained wave of **home-router CSRF attacks** in Brazil between 2011 and 2018, collectively dubbed the **GhostDNS campaign**, in which attackers used CSRF payloads hosted on ad networks to flip the DNS server setting on over 100,000 consumer routers, redirecting banking traffic through attacker-controlled resolvers for credential harvesting.

CSRF is frequently combined with other attack classes. A reflected [[XSS]] vulnerability can be used to steal or bypass CSRF tokens entirely, since same-origin script can read anything in the DOM. [[Clickjacking]] can overlay a transparent target-site frame to trigger a same-origin form submission. [[DNS Rebinding]] can convert a CSRF payload into an attack against `localhost`-bound services from a remote web page. Layered, defense-in-depth controls are therefore essential — any single mitigation can be undermined by adjacent weaknesses.

---

## How It Works

A CSRF attack requires three preconditions: **(1)** the target site uses an authentication mechanism the browser attaches automatically to outbound requests — cookies, Basic auth, NTLM, client TLS certificates; **(2)** the target endpoint accepts a state-changing request whose parameters the attacker can predict in advance; and **(3)** the victim is authenticated to the target and browses to attacker-controlled content during that session.

### Classic GET-Based CSRF

Many early web applications exposed state-changing actions via `GET` requests — a violation of RFC 7231, which requires `GET` to be safe and idempotent. If a bank exposes:

```
GET /transfer?to=attacker&amount=10000 HTTP/1.1
Host: bank.example
Cookie: session=abc123
```

The attacker embeds a zero-pixel image tag on any page the victim visits:

```html
<img src="https://bank.example/transfer?to=attacker&amount=10000"
     width="0" height="0" alt="">
```

When the browser parses the page, it fires the `GET` automatically, appending the `session` cookie because the cookie's domain attribute matches `bank.example`. The server processes the transfer without any indication of forgery.

### POST-Based CSRF via Auto-Submitting Form

Switching to `POST` is not a defense. An attacker-hosted HTML page can submit a hidden form the moment the DOM loads:

```html
<html>
<body onload="document.forms[0].submit()">
  <form action="https://bank.example/transfer" method="POST">
    <input type="hidden" name="to"     value="attacker_account">
    <input type="hidden" name="amount" value="10000">
    <input type="hidden" name="currency" value="USD">
  </form>
</body>
</html>
```

The victim sees a blank page for a fraction of a second (or nothing, if the form targets a hidden iframe); the bank processes the POST with the victim's session cookie attached.

### JSON API Endpoints

REST APIs accepting `Content-Type: application/json` appear safer because HTML forms cannot natively produce that content type — a `fetch()` call with a custom content type triggers a CORS preflight, and the server can refuse cross-origin preflights. However, if the server accepts `text/plain` or `application/x-www-form-urlencoded` bodies and parses them as JSON — a pattern that appears in some legacy microservices — an HTML form can still forge the request. The only reliable barrier for JSON APIs is requiring a **custom request header** (e.g., `X-Requested-With: XMLHttpRequest`) that browsers refuse to add to cross-origin simple requests, forcing a preflight that the attacker's origin cannot satisfy without explicit CORS consent from the target.

```bash
# Legitimate fetch with custom header (triggers preflight - safe)
curl -H "X-Requested-With: XMLHttpRequest" \
     -H "Content-Type: application/json" \
     -d '{"to":"attacker","amount":10000}' \
     https://bank.example/api/transfer
```

### Login CSRF

A subtle variant: rather than acting on the victim's session, the attacker forces the victim to authenticate using the *attacker's* credentials. If the login form has no CSRF token, the attacker pre-positions the browser to log into an account they control. Subsequent victim activity — saved payment methods, uploaded files, stored searches — is captured by the attacker simply by logging into their own account. Google's login flow was vulnerable to this in 2007.

### SameSite Cookie Attribute and Browser-Level Mitigations

The **SameSite** cookie attribute instructs the browser when to include a cookie on cross-site requests:

| Value | Behavior |
|---|---|
| `Strict` | Cookie is **never** sent on cross-site requests, including top-level navigations. Maximum protection; breaks some OAuth/SSO flows. |
| `Lax` | Cookie is sent on cross-site top-level `GET` navigations (clicking a link), but **not** on cross-site `POST`, `iframe`, `img`, `fetch`. Chrome default since 2020. |
| `None` | Cookie is sent on all requests; **requires `Secure`** attribute since 2020. Pre-2020 default behavior. |

`SameSite=Lax` defeats most classical CSRF but not top-level `GET` forgeries or attacks pivoting through a same-site subdomain that the attacker controls.

### Synchronizer Token Pattern (Anti-CSRF Token)

The canonical server-side defense embeds a cryptographically random session-bound nonce into every state-changing form and validates it server-side:

```html
<form method="POST" action="/transfer">
  <input type="hidden" name="csrf_token"
         value="7f4e1d2c9a8b6f3e0d2a1c4b9e8f7a3d">
  <input type="text"   name="to"     placeholder="Recipient">
  <input type="number" name="amount" placeholder="Amount">
  <button type="submit">Transfer</button>
</form>
```

Server validation (pseudocode):

```python
submitted_token = request.form.get("csrf_token")
session_token   = session.get("csrf_token")

if not submitted_token or submitted_token != session_token:
    abort(403, "CSRF token mismatch")
```

An attacker on `evil.com` cannot read the token from the victim's bank page because the [[Same-Origin Policy]] blocks cross-origin DOM reads. Without a valid token, the POST is rejected.

---

## Key Concepts

- **Ambient Authority**: Credentials the browser attaches *automatically* to outbound requests — session cookies, HTTP Basic auth, NTLM, and client certificates. CSRF exists entirely because of ambient authority. Bearer tokens sent in `Authorization` headers are **not** ambient (JavaScript must explicitly include them) and are therefore **not** CSRF-vulnerable by default.
- **State-Changing Request**: Any HTTP request that mutates server-side state — `POST`, `PUT`, `DELETE`, `PATCH`, or an improperly designed `GET`. RFC 7231 requires `GET` to be safe and idempotent; violating this is a root cause of trivial CSRF exploits.
- **Synchronizer Token Pattern (Anti-CSRF Token)**: The canonical CSRF defense: a per-session or per-request cryptographically random nonce embedded in forms and validated server-side before any state change is executed.
- **Double-Submit Cookie Pattern**: The CSRF token is stored both as a cookie and echoed in a request body parameter or header; the server verifies they match. Works without server-side session storage but is vulnerable if an attacker controls a subdomain and can inject cookies.
- **`SameSite` Cookie Attribute**: A browser-enforced attribute (`Strict`, `Lax`, `None`) that restricts when cookies are sent on cross-site requests. `Lax` became the Chrome default in 2020 and broke the majority of classical CSRF attack chains.
- **Confused Deputy**: The theoretical security name for the root vulnerability. The server (the deputy) is manipulated into using its authority on behalf of an attacker by processing a request forged against the victim (the principal).
- **`__Host-` Cookie Prefix**: A browser-enforced cookie naming convention that mandates `Secure`, `Path=/`, and no `Domain` attribute, preventing subdomain injection attacks that can undermine the double-submit cookie pattern.
- **CSRF vs. XSS**: These are complementary vulnerabilities. XSS executes attacker-controlled script *inside* the target origin, which means it can **read CSRF tokens** and thereby defeat any token-based CSRF defense. Any stored or reflected XSS effectively nullifies CSRF mitigations.
- **Login CSRF**: A variant that forces an unauthenticated victim to log in as the attacker, allowing the attacker to harvest subsequent victim data. Requires anti-CSRF tokens on login forms too, not only on authenticated endpoints.

---

## Exam Relevance

The **Security+ SY0-701** covers CSRF in **Domain 2.3** (application attack indicators) and **Domain 4.1** (secure software development practices). It is one of several "forgery" attack types explicitly named in the exam objectives.

**High-priority exam distinctions:**

| Concept | CSRF | SSRF | XSS |
|---|---|---|---|
| Who makes the request? | **Victim's browser** | **Target server** | **Victim's browser (via injected script)** |
| Origin of manipulation | Attacker's external page | Attacker-supplied input to server | Attacker-injected script in target page |
| Reads attacker-controlled data? | No — blind attack | Potentially | Yes |
| Defeats anti-CSRF tokens? | No | N/A | **Yes** (can read the token) |

**Common question patterns:**

- *"A user clicks a link in an email; while logged into their bank in another tab, a fund transfer occurs. What attack?"* → **CSRF**. The distinguishing factor is no script execution in the target origin — just a forged request using the existing session.
- *"What is the most effective mitigation for CSRF?"* → **Anti-CSRF tokens / synchronizer token pattern**. Distractors: input validation (wrong problem), WAF alone (insufficient), HTTPS (does not prevent CSRF), POST-only (insufficient).
- *"Which cookie attribute mitigates CSRF?"* → **`SameSite`**. Do not confuse with `HttpOnly` (prevents JavaScript cookie access, mitigates XSS theft) or `Secure` (HTTPS-only transmission).
- *"Which HTTP method is inherently CSRF-resistant?"* → **Trick question** — none are, but APIs requiring custom headers (`Authorization: Bearer ...`) are de facto resistant because the header is not ambient.

**Gotchas:** HTTPS **does not** prevent CSRF. CAPTCHAs **do** prevent it (attacker cannot solve interactively). `Referer` header validation is a **partial** mitigation only — privacy tools suppress it. `POST` alone is **not** a defense.

---

## Security Implications

CSRF converts a victim's authenticated session into a remote business-logic execution primitive. Impact depends entirely on what the target application allows authenticated users to do. Consequences range from nuisance (unwanted forum upvotes) to catastrophic account takeover (change email → trigger password reset → lock out legitimate owner), unauthorized financial transactions, or full administrative compromise of embedded network devices.

**Notable CVEs and incidents:**

- **CVE-2018-9995** — TBK DVR camera systems exposed a CSRF + authentication bypass allowing unauthenticated attackers to retrieve credentials; mass-exploited against thousands of devices.
- **CVE-2021-27239** — Netgear router CSRF enabling DNS server modification without authentication, allowing pharming attacks against LAN clients.
- **CVE-2015-7755** — Juniper ScreenOS management interface CSRF vectors.
- **CVE-2013-2645** — TP-Link routers: CSRF allowing firmware flash and admin credential change via a single malicious web page.
- **GhostDNS Campaign (2018)** — A sophisticated Brazilian threat actor used CSRF payloads embedded in malicious ads to attack over 70 router models, compromising ~100,000 devices and redirecting DNS for major Brazilian bank domains to attacker-controlled resolvers.
- **ING Direct (2008)** — CSRF allowed transfers out of any customer account; discovered by security researcher Jeremiah Grossman.
- **Netflix (2006)** — CSRF allowed arbitrary changes to a victim's DVD rental queue and mailing address.
- **jQuery CVE-2020-11022 / CVE-2020-11023** — DOM-based XSS flaws that, when chained, allowed token theft to bypass CSRF protections on applications using the vulnerable versions.

**Detection signals:** CSRF forged requests are structurally identical to legitimate ones, making them difficult to distinguish in application logs. Useful indicators include: absent or mismatched `Origin`/`Referer` headers on `POST` requests; spikes in CSRF token validation failures (403s from the anti-CSRF middleware) pointing to an active attacker probing for gaps; anomalous state changes correlated with external `Referer` values; and WAF log entries flagging missing tokens on protected endpoints.

---

## Defensive Measures

Defense in depth is essential — any single control can be undermined by adjacent vulnerabilities.

**1. Anti-CSRF Tokens (Primary Defense)**
Use the synchronizer token pattern via your framework's built-in support. Never implement your own:

```python
# Django — automatic CSRF middleware + template tag
{% csrf_token %}   # Renders hidden input; middleware validates on all POST