```markdown
---
domain: "application-security"
tags: [attack, web-security, owasp, authentication, session-management, csrf]
---
# Cross-Site Request Forgery

**Cross-Site Request Forgery (CSRF)**, also called **XSRF**, **session riding**, or **one-click attack**, is a web vulnerability in which an attacker causes an authenticated user's browser to submit an unwanted, state-changing request to a target application. It exploits the **implicit trust** a site places in the user's browser rather than the trust a user places in the site — the inverse relationship that distinguishes it from [[Cross-Site Scripting]]. CSRF is enabled by the browser's automatic transmission of **ambient authentication** — [[Cookies]], HTTP Basic credentials, NTLM tokens, and [[TLS]] client certificates — with every matching request, regardless of which origin initiated it.

---

## Overview

CSRF emerged as a documented attack class in the late 1990s and was formally described by Peter Watkins in a Bugtraq post in June 2001. It rose to prominence in the mid-2000s as web applications became increasingly stateful and cookie-based sessions became ubiquitous. The vulnerability consistently appears in the OWASP Top Ten (A8 in 2013, later folded into "Broken Access Control" in OWASP Top Ten 2021) and is tracked as **CWE-352**. Although modern browsers and frameworks have materially reduced its prevalence, legacy applications, internal tools, IoT devices, and home routers remain frequent victims.

The fundamental cause is that HTTP is stateless, and web applications authenticate users through credentials stored in the browser — typically session cookies. The browser attaches these credentials to any request destined for the target origin, whether initiated by the user, a legitimate script on the site, or a malicious page on a third-party domain. If the server cannot distinguish between a request initiated by the user's deliberate interaction and one initiated by a foreign page, an attacker controlling that foreign page can cause the user to perform actions as themselves: transfer funds, change email addresses, elevate accounts, reconfigure routers, or add administrative users.

CSRF is particularly dangerous because it requires no vulnerability in the victim's browser, no malware, and no credential theft. The victim only needs to be authenticated to the target site and to load an attacker-controlled resource — a malicious page, an embedded advertisement, a forum post with an image tag, or even an email rendered in a web-based mail client. High-impact historical incidents include a 2008 campaign against home routers that altered DNS settings via forged admin requests, the **Gmail mail-filter CSRF** disclosed in 2007 (which silently enabled email forwarding to an attacker-controlled address), and numerous router-firmware CVEs affecting D-Link, Netgear, and TP-Link devices.

The attack is **blind** in its classic form: the attacker's page causes the browser to send a request but, due to the [[Same-Origin Policy]], cannot read the response. This means CSRF is normally leveraged for state changes — POST, PUT, DELETE, account modification — rather than data exfiltration. When combined with [[Cross-Site Scripting]] or a [[CORS]] misconfiguration, however, the boundary blurs: an attacker who has script execution on the target origin can read anti-CSRF tokens, and a permissive `Access-Control-Allow-Origin` header can allow cross-origin response reads.

CSRF belongs to a broader family of **confused deputy** problems, where a trusted intermediary — the browser — is manipulated into misusing its authority on behalf of an attacker. This framing, first articulated by Norm Hardy in 1988, explains why effective defenses must rely on **explicit intent verification** rather than authentication alone.

---

## How It Works

A classical CSRF attack involves four actors: the victim user, the victim's browser, the target application, and the attacker-controlled site.

**Step-by-step attack flow:**

1. The victim authenticates to `https://bank.example.com` and receives a session cookie (`Set-Cookie: Session=abc123; HttpOnly`).
2. Without logging out, the victim visits `https://evil.example.net` in another tab or window.
3. The attacker's page contains HTML or JavaScript that issues a forged request to `bank.example.com`.
4. The browser, seeing that the destination matches the stored cookie's domain, automatically attaches the `Session` cookie to the request.
5. The bank's server validates the session cookie, finds it valid, and executes the requested state change — wire transfer, password reset, email change.

**A GET-based CSRF payload** is the simplest form. If a vulnerable endpoint accepts state changes via GET (a violation of RFC 9110 idempotency requirements), merely embedding an image in any page or email the victim views is sufficient:

```html
<!-- Served from evil.example.net -->
<img src="https://bank.example.com/transfer?to=attacker&amount=10000"
     width="0" height="0" alt="">
```

The browser loads the image, fires the GET request, and attaches the victim's session cookie. No JavaScript or user interaction is required beyond loading the page.

**A POST-based CSRF payload** uses a self-submitting form, which the browser's CORS preflight rules do not block for standard `Content-Type` values:

```html
<html>
  <body onload="document.forms[0].submit()">
    <form action="https://bank.example.com/transfer" method="POST">
      <input type="hidden" name="to"     value="attacker">
      <input type="hidden" name="amount" value="10000">
    </form>
  </body>
</html>
```

Content-Type is critical here. The browser's default form encodings — `application/x-www-form-urlencoded`, `multipart/form-data`, and `text/plain` — are classified by CORS as **simple requests** and do **not** trigger an `OPTIONS` preflight. This means no pre-flight warning reaches the server. Only endpoints that correctly enforce `Content-Type: application/json` and do not accept text/plain equivalents provide meaningful resistance to this vector.

**A JSON-based CSRF** can sometimes be forced by abusing `text/plain` encoding to deliver a valid JSON body:

```html
<form action="https://api.example.com/v1/user"
      method="POST"
      enctype="text/plain">
  <!-- Constructs body: {"email":"attacker@evil.net","ignore":"="} -->
  <input name='{"email":"attacker@evil.net","ignore":"' value='"}'>
</form>
```

If the server parses the body as JSON without enforcing `Content-Type: application/json` strictly, the attack succeeds.

**Protocols and ports:** CSRF operates over whatever transport the target uses — typically HTTPS on TCP/443 — but, because the attack executes inside the victim's browser, it works equally well against intranet services on RFC 1918 addresses (e.g., router admin panels at `192.168.1.1` on TCP/80 or TCP/8080). This makes CSRF against internal infrastructure a recurring threat in both enterprise and homelab environments, sometimes paired with **DNS rebinding** to access otherwise isolated services.

**What CSRF cannot do (without additional primitives):** Due to the [[Same-Origin Policy]], the attacker's JavaScript cannot read the response from `bank.example.com`, cannot access that site's cookies or `localStorage`, and cannot extract anti-CSRF tokens embedded in the target's own HTML. This single constraint is why properly implemented synchronizer tokens are effective — the attacker would need to read a page from the target origin to learn the token, which SOP prevents.

---

## Key Concepts

- **Ambient Authentication**: Credentials — session cookies, HTTP Basic auth headers, client certificates, Kerberos tickets — that the browser attaches automatically to requests for a given origin, regardless of the request's initiating origin. This automatic attachment is the root enabler of CSRF; the attack does not steal credentials, it rides them.
- **Synchronizer Token Pattern**: The canonical defense. The server generates a cryptographically random, per-session (or per-form) token, embeds it in every form as a hidden field and in every AJAX request as a custom header, and rejects any state-changing request that lacks or mismatches the token. Because [[Same-Origin Policy]] prevents the attacker's page from reading the token from the target's HTML, it cannot be forged without a separate XSS or CORS vulnerability.
- **Double-Submit Cookie**: A stateless variant of the token defense. The server issues a random value as a cookie and requires the same value to appear in a request header or form field. The server compares both values without maintaining server-side storage. It is weaker than the synchronizer pattern if cookies on the target domain can be written by a subdomain attacker.
- **SameSite Cookie Attribute**: An HTTP cookie flag (`SameSite=Strict`, `Lax`, or `None`) that instructs the browser to omit the cookie from cross-site requests. `SameSite=Lax` (Chrome's default since 2020) allows the cookie on top-level GET navigations but withholds it on cross-site POST, image-load, iframe, and AJAX requests. This was the single largest real-world reduction in CSRF exposure since the attack class was named.
- **Origin and Referer Header Validation**: Checking the `Origin` header (present on non-GET CORS requests and always sent by modern browsers on cross-site POSTs) against a server-side allowlist. `Referer` is a weaker fallback; it can be absent when `Referrer-Policy: no-referrer` is set, and its presence must not be required as that would break legitimate users.
- **Confused Deputy Problem**: A theoretical framing in which an authorized agent (the browser) is tricked into misusing its authority on behalf of a third party (the attacker). CSRF is a textbook instance: the browser is authorized to act for the user, but acts for the attacker instead.
- **Login CSRF**: A variant targeting the login flow rather than an authenticated action. The attacker forces the victim's browser to authenticate to the target site using the **attacker's credentials**. The victim then unknowingly uses the attacker's session, causing the victim's activities (searches, file uploads, form submissions) to be logged under the attacker's account for later review.

---

## Exam Relevance

For the **Security+ SY0-701**, CSRF appears in **Domain 2 (Threats, Vulnerabilities, and Mitigations)** and is frequently tested in application security scenarios.

**Key distinctions the exam tests:**

- **CSRF vs. [[Cross-Site Scripting]]**: XSS injects and executes attacker code within the victim's browser in the target site's own origin context, breaking confidentiality and integrity. CSRF submits a forged request from a different origin using the victim's existing credentials, primarily breaking integrity. The critical exam gotcha: **XSS defeats CSRF token defenses** — if an attacker has script execution on the target site, they can read the anti-CSRF token from the DOM and include it in the forged request.
- **CSRF vs. [[Session Hijacking]]**: Session hijacking steals the session identifier itself (via sniffing, XSS, or prediction). CSRF never reveals the session token to the attacker — it merely exploits the token's automatic transmission.
- **CSRF vs. [[Server-Side Request Forgery|SSRF]]**: Despite similar naming, these are unrelated. SSRF makes the *server* issue requests to attacker-chosen targets. CSRF makes the *victim's browser* issue requests to the target server. Do not conflate them.

**Common exam question patterns:**
- A scenario describes a user who is logged in and clicks a link in an email, after which an unexpected account change occurs — this is CSRF.
- A question asks which header can help verify request origin — correct answers include `Origin` and `Referer`.
- A question asks for the primary defense against CSRF — the expected answer is **anti-CSRF tokens (synchronizer token pattern)**.
- Multi-select questions may credit both anti-CSRF tokens and SameSite cookies as valid defenses.

**Gotcha:** GET requests that trigger state changes are inherently vulnerable regardless of other controls. The exam treats "use POST for state changes" as a necessary precondition, not sufficient alone.

---

## Security Implications

CSRF exploits consistently target any state-changing HTTP endpoint that relies solely on session cookies for authorization. Real-world incidents and CVEs illustrate the attack's scope:

- **Gmail Mail-Filter CSRF (2007)** — Researcher Petko D. Petkov (PDP) demonstrated that a forged request to Gmail's filter-creation endpoint could silently add a mail-forwarding rule, allowing an attacker to receive copies of all inbound email for a victim who visited a malicious page while logged in.
- **ING Direct CSRF (2008)** — Allowed inter-account fund transfers to be initiated without user consent. One of the first financial-sector CSRF incidents to receive public disclosure.
- **Home Router DNS Hijacking (2008–2016)** — Malvertising networks embedded zero-pixel images referencing router admin URLs (e.g., `http://192.168.1.1/save.cgi?...`) with pre-filled DNS settings. Routers using default credentials with no CSRF tokens were reconfigured to use attacker-controlled DNS resolvers, enabling phishing and MITM attacks against entire households. Affected vendors included D-Link, TP-Link, and Linksys. This campaign directly motivated ISP and browser decisions to treat private IP addresses differently in cross-origin contexts.
- **Samy Worm (2005)** — While primarily an XSS self-propagating worm on MySpace, it used CSRF-style forged POST requests to add the attacker as a friend on behalf of every visitor, reaching one million profiles in under 20 hours.
- **CVE-2020-11110 (Grafana CSRF)** — A CSRF vulnerability in Grafana's user invitation endpoint allowed an attacker to add arbitrary users as administrators via a forged request.
- **CVE-2022-29710 (TP-Link TL-WR940N)** — CSRF in the router's admin interface allowed unauthenticated network-adjacent attackers to reconfigure the device through a victim admin's browser.

**Detection signals:**
- `Origin` or `Referer` headers in server access logs that do not match the expected application domain on state-changing requests.
- Unusual `Content-Type` values for endpoints that should only accept JSON (e.g., `text/plain` to a REST API).
- Account modifications — password change, email change, added admin users — correlated with no UI session activity in application logs immediately prior.
- [[Web Application Firewall]] rules triggering on missing or invalid anti-CSRF tokens.

**Severity:** Impact depends entirely on what the forged request does. A CSRF on a low-privilege search endpoint is negligible. A CSRF on a password-change, privilege-grant, fund-transfer, or device-reconfiguration endpoint is **critical severity** and typically rates CVSS 8.0–9.0.

---

## Defensive Measures

Effective CSRF defense requires **layered controls**. No single mechanism is sufficient in isolation.

**1. Anti-CSRF Tokens (Synchronizer Token Pattern)**

Generate a 128-bit+ cryptographically random token per session, embed it in every state-changing form and AJAX request header, and validate it server-side on every non-idempotent request.

Framework implementations:
- **Django**: `{% csrf_token %}` in templates; `CsrfViewMiddleware` (enabled by default) enforces it globally.
- **Ruby on Rails**: `protect_from_forgery with: :exception` in `ApplicationController`.
- **Spring Security**: `CsrfFilter` is active by default since version 4.0; token is injected via `_csrf` form field or `X-CSRF-TOKEN` header.
- **ASP.NET Core**: `[ValidateAntiForgeryToken]` attribute on controllers; `@Html.AntiForgeryToken()` in Razor views.
- **Express.js**: Use `csrf-csrf` (the `csurf` package is deprecated) or implement the double-submit cookie pattern.

**2. SameSite Cookie Attribute**

Set on every authentication cookie:

```http
Set-Cookie: SessionId=abc123; SameSite=Lax; Secure; HttpOnly; Path=/
```

Use `SameSite=Strict` for admin or high-privilege interfaces where top-level cross-site navigation carrying the cookie is unacceptable. Be aware that `SameSite=Lax` still allows GET-based top-level navigations to carry the cookie, so it does not protect GET endpoints that mutate state.

**3. Origin Header Validation**

Validate the `Origin` header on all state-changing requests