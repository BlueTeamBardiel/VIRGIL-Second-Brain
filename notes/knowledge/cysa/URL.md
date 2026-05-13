# URL — Uniform Resource Locator

## What it is

In **Portal**, every portal has two ends. You see the blue ring on the wall and assume it drops you in the courtyard you saw through it. GLaDOS taught everyone that the destination painted on the wall is a lie — the orange portal can be moved while you're mid-jump, and the room behind the panel was never the room you thought it was. That's exactly what a URL does. The string in the address bar is the blue portal — the destination it actually resolves to is the orange one, and the attacker controls where it's been re-aimed.

A **URL** is a structured string that tells a client how to reach a resource: scheme, authority, path, query, fragment. In SOC work it is the single most-clicked, most-spoofed, most-logged artifact you triage. Phishing investigations, C2 hunts, proxy logs, DNS logs, email header analysis — all of it converges on a URL string and the question *"where does this actually go, and what does it do when it gets there?"*

## Why it matters

CompTIA Objective 1.3 puts URL analysis dead-center of "determine malicious activity." Every phishing ticket, every EDR web-block, every proxy alert lands on an analyst's queue as a URL. The exam tests whether you can pick apart the string, recognize obfuscation, and pivot to the right tool (WHOIS, VirusTotal, sandbox, AbuseIPDB) without detonating the link in your production browser.

In the war room, URL triage is the first ten minutes of half your tickets. Get it wrong and you either ignore a live credential-harvest campaign or you click a payload on your corporate laptop. Neither is a good day.

## Key facts

### Anatomy of a URL

```
https://user:pass@login.micr0soft.com.evil.tk:8443/account/verify?id=abc123#top
\___/   \_______/ \________________________/ \__/\____________/\______/ \_/
scheme  userinfo        authority/host       port    path        query  frag
```

| Component | What it tells you | What attackers abuse |
|---|---|---|
| **Scheme** | http, https, ftp, file, javascript, data | `javascript:` and `data:` URIs run code; `file://` reads local paths |
| **Userinfo** | `user:pass@` before host | Hides real host: `microsoft.com@evil.tk` resolves to **evil.tk** |
| **Host** | FQDN or IP | Typosquatting, homoglyphs (Cyrillic `а`), subdomain-as-brand (`paypal.com.evil.tk`) |
| **Port** | Default 80/443; explicit otherwise | Non-standard ports (8443, 4444, 8080) signal C2 or staging infra |
| **Path** | Resource path on server | Long random paths = exploit kits; `/wp-content/uploads/` = compromised WordPress |
| **Query string** | `?key=value` parameters | Base64-encoded payloads, victim ID tracking, redirect chains |
| **Fragment** | `#` client-side anchor | Never sent to server — used to smuggle data into client-side scripts |

### Reading the host right-to-left

The host parses **right-to-left**. The TLD owns everything to its left.

- `paypal.com.evil.tk` → registered domain is **evil.tk**, paypal is a subdomain attacker controls
- `secure-paypal.com` → registered domain is **secure-paypal.com**, not paypal
- `paypal.com@evil.tk` → host is **evil.tk**, paypal.com is userinfo (ignored by the resolver)

> **CompTIA exam trap:** When the question shows `https://accounts.google.com.security-update.ru/login`, the answer is *the host is security-update.ru, controlled by a .ru registrant*. CompTIA tests whether you parse right-to-left or fall for left-to-right brand recognition.

### Obfuscation techniques

Attackers don't write `evil.tk` in clear text. Recognize these:

- **URL encoding (percent-encoding)** — `%2F` = `/`, `%2E` = `.`, `%40` = `@`. `evil%2Etk` is `evil.tk`.
- **Double encoding** — `%252E` decodes to `%2E` decodes to `.`. WAFs that decode once miss it.
- **Punycode / IDN homoglyphs** — `xn--pypal-4ve.com` renders as `pаypal.com` with a Cyrillic а. Look for `xn--` in raw logs.
- **IP literals** — `http://3232235521/` is decimal form of `192.168.0.1`. Also hex (`0xC0A80001`), octal, and IPv6 bracket notation.
- **Shorteners** — bit.ly, t.co, tinyurl. Expand before clicking. CyberChef and `curl -I -L` (in a sandbox) trace the chain.
- **Open redirects** — legitimate domain hosting `?redirect=evil.tk`. Common on Google, LinkedIn, news sites. Read the *full* query string.
- **Homograph subdomain stuffing** — `login.microsoft.com.azure-auth-verify.com` — first three labels are noise to a hurried analyst.

*Every obfuscation trick exists because at some point in a SOC, someone clicked the unobfuscated version and the campaign got nuked. The attackers learned. So should you.*

### Triage workflow — never click

The cardinal rule: **defang first, then analyze**. Defanging breaks the URL so nobody auto-clicks it in chat, email, or a ticket comment.

`https://evil.tk/payload` → `hxxps://evil[.]tk/payload`

Then pivot to passive tools. Never paste a live URL into a browser on your endpoint.

| Tool | What it answers |
|---|---|
| **[[VirusTotal]]** | Has any AV/URL-scanner flagged this host or path? Last seen? Related samples? |
| **[[WHOIS]]** | Who registered the domain, when, where? Domain registered yesterday = high suspicion |
| **[[AbuseIPDB]]** | Has the resolving IP been reported for abuse? By how many parties, what kind? |
| **[[urlscan.io]]** | Renders the URL in a sandbox; gives you screenshot, DOM, network requests, redirect chain |
| **[[Joe Sandbox]] / [[Cuckoo Sandbox]] / [[Any.run]]** | Detonate the full landing page + any dropped payload |
| **Passive DNS** | What other hosts resolved to this IP? Shared infra → known campaign |
| **[[Wireshark]] / [[pcap]] from sandbox** | Beacon intervals, JA3 fingerprint, exact C2 callbacks |

### Indicators in the URL itself

What a malicious URL *looks like* before you even resolve it:

- **Newly registered domain** (NRD < 30 days) — phishing campaigns burn domains fast
- **Free / abuse-tolerant TLDs** — `.tk`, `.ml`, `.ga`, `.cf`, `.xyz`, `.top` are overrepresented
- **Brand keyword + hyphen** — `microsoft-login-verify`, `apple-id-secure`
- **Long random path** — `/4f8a2b9c1d/index.php` from exploit kit generators
- **Encoded query parameters** — base64 strings, hex blobs, especially when decoding yields PowerShell or shell commands
- **Unusual port** — 8443, 4444, 8080, 50050 (Cobalt Strike default team server)
- **Punycode `xn--` prefix** in the raw log

### URL artifacts across the SOC stack

| Source | URLs appear as | What you correlate |
|---|---|---|
| **Email headers** | `Received:`, `Return-Path:`, embedded links in body | Match against [[SPF]], [[DKIM]], [[DMARC]] alignment of sender |
| **Proxy logs** | Full URL + user + bytes + status | User who clicked, time, what loaded |
| **DNS logs** | Just the FQDN, no path | First-seen, query volume, NXDOMAIN bursts (DGA) |
| **EDR telemetry** | Process → URL (e.g., `winword.exe` → `evil.tk`) | Office reaching out is almost always bad |
| **SIEM correlation** | Joined across the above | The story: email arrived → user clicked → DNS resolved → payload downloaded → C2 beacon |

### Email-borne URLs — the 80% case

Most malicious URLs arrive embedded in email. Analysis order:

1. **Pull the raw `.eml` or message source** — never trust the rendered display
2. **Extract every URL** with `strings`, regex, or a parser — display text lies (`<a href="evil.tk">microsoft.com</a>`)
3. **Check sender authentication** — [[SPF]] pass, [[DKIM]] signature valid, [[DMARC]] aligned? If all three fail, the from-address is spoofed
4. **Compare display URL to actual `href`** — mismatch = phishing
5. **Submit URL to sandbox** — not the email body, the URL itself, to get the landing page rendered
6. **Hash any downloaded payload** — pivot the hash through VirusTotal

> **CompTIA exam trap:** [[SPF]] checks the *envelope* sender (`Return-Path`), not the `From:` header the user sees. An attacker can pass SPF on `evil.tk` while spoofing `From: ceo@yourcompany.com`. **[[DMARC]]** is what enforces alignment between SPF/DKIM and the visible From. If the question asks "what stops display-name spoofing," the answer is **DMARC**, not SPF alone.

### Scripting the boring parts

URL triage scales badly if you do it by hand. Automate:

- **[[Python]]** — `urllib.parse.urlparse()`, `tldextract` for registered-domain extraction, `requests` (in a sandbox VM) for passive header fetch
- **[[PowerShell]]** — `[System.Uri]` class, `Invoke-WebRequest -UseBasicParsing` for headers only
- **[[Regular expressions]]** — extract URLs from log blobs: `https?://[^\s<>"]+` (good enough for triage, not RFC-compliant)
- **[[Shell script]]** — `curl -sI -L --max-time 5 "$url"` to follow redirects without rendering
- **[[JSON]] / [[XML]] parsing** — VirusTotal, urlscan, AbuseIPDB all return JSON; `jq` is your friend
- **[[SOAR]] playbooks** — ingest URL → defang → enrich (VT, WHOIS, AbuseIPDB) → score → auto-block at proxy if confidence > threshold

## SOC reality

- The 3am alert reads `PROXY-BLOCK: outbound to 185.220.x.x:4444 from FINANCE-LAPTOP-07, process: winword.exe`. The URL in the alert is your starting point — but the *story* is Word reaching out, which means the document opened the door.
- L1 triage: defang the URL, run it through VirusTotal and urlscan, check proxy for any other users who hit the same host in the last 7 days. If even one other user clicked, scope just expanded — escalate.
- The IR lead's first question is never "what was the URL" — it's *"who clicked, when, and did anything execute after?"* The URL is evidence; the impact is who-touched-it-and-what-ran.
- Never tell leadership "the link was blocked, we're fine" until you've checked DNS logs and EDR for the same host across the fleet. The block at one user doesn't mean the campaign didn't land on five others through a different vector.
- Handoff: L1 enriches and defangs → L2 sandboxes the landing page and pulls payload hashes → IR scopes user impact and pushes blocks to proxy/firewall/email gateway → threat intel team adds the IOCs to the watchlist for the next campaign wave.

## Related concepts

[[Email analysis]] · [[SPF]] · [[DKIM]] · [[DMARC]] · [[Phishing]] · [[VirusTotal]] · [[WHOIS]] · [[AbuseIPDB]] · [[urlscan.io]] · [[Sandboxing]] · [[Joe Sandbox]] · [[Cuckoo Sandbox]] · [[DNS analysis]] · [[Proxy logs]] · [[Command and control]] · [[Indicators of compromise]] · [[Regular expressions]] · [[Defanging]] · [[Punycode]] · [[Typosquatting]] · [[Open redirect]] · [[SOAR]]

*Source: VIRGIL knowledge base — 2026-05-11*