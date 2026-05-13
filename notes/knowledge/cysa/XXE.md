# XXE — XML External Entity

## What it is

In **Death Stranding**, Sam picks up a cargo manifest from a delivery terminal. The manifest is a printed paper that says "fetch these crates from that locker." Sam doesn't question it — he reads the references, walks to the locker, picks up whatever's inside, and carries it back. Now imagine someone slips a forged manifest into the terminal that reads "fetch the contents of Bridges' private server room and bring them to me at this MULE camp." Sam, being a deliveryman and not a security guard, complies. He hand-delivers classified BB data straight to the enemy.

That's XXE. The XML parser is Sam — it follows references in the document without asking whether it should.

**XXE (XML External Entity)** is an injection flaw against XML parsers that resolve **external entity references** inside a document. An attacker submits crafted XML containing a `<!DOCTYPE>` declaration with an `ENTITY` that points at a local file, an internal URL, or an attacker-controlled host. The parser dutifully fetches that resource and embeds it into the parsed output — which is then returned to the attacker, leaked through an error, or sent outbound to a server they control.

It sits in OWASP Top 10 under **A05: Security Misconfiguration** (it was its own category in 2017, folded into misconfig in 2021 because the root cause is "you left external entity resolution enabled when you didn't need it").

## Why it matters

XXE is a force multiplier. A single malformed XML upload can give you:

- **Local file disclosure** — `/etc/passwd`, `web.config`, AWS credentials in `~/.aws/credentials`, private keys
- **SSRF** — pivot to internal services, cloud metadata endpoints (`169.254.169.254`), Redis, internal admin panels
- **Denial of service** — billion laughs / quadratic blowup attacks that exhaust memory
- **Remote code execution** — rare, but possible via PHP `expect://` wrapper or chained gadget

CySA+ Objective 2.4 expects you to recommend the right control. The right control for XXE is almost always the same one sentence: **disable DTD processing and external entity resolution in the parser configuration.** It's not a WAF rule, it's not input validation, it's a parser flag. CompTIA tests whether you know this.

Bigger picture: XXE is the canonical example of **insecure design meeting security misconfiguration**. Legacy XML parsers shipped with external entities enabled by default. SOAP, SAML, DOCX, SVG, RSS, XMP metadata in images — all XML, all parsed somewhere, all potentially vulnerable. A SAML auth endpoint that parses your `SAMLResponse` insecurely is an XXE on your identity provider integration. That's a bad day.

## Key facts

### The mechanic

XML supports **entities** — reusable references inside a document. `&amp;` is an internal entity. External entities pull content from elsewhere:

```xml
<?xml version="1.0"?>
<!DOCTYPE foo [
  <!ENTITY xxe SYSTEM "file:///etc/passwd">
]>
<user><name>&xxe;</name></user>
```

The parser resolves `&xxe;` by reading `/etc/passwd` and substituting its contents into `<name>`. If the application echoes that field back — error message, JSON response, rendered page — the file content lands in the attacker's browser.

### Variants

| Variant | How it works | What the attacker gets |
|---|---|---|
| **In-band (classic)** | Entity content reflected directly in response | File contents, internal HTTP responses |
| **Out-of-band (OOB / blind)** | Entity points to attacker-controlled server; data exfiltrated over DNS or HTTP | Works when response is suppressed |
| **Error-based** | Force parser to error and include entity content in the error message | File contents leaked through stack traces |
| **Billion laughs (DoS)** | Nested entities expand exponentially: `&lol9;` resolves to a billion `lol`s | Memory exhaustion, parser crash |
| **XXE-to-SSRF** | Entity points to `http://internal-host/` or cloud metadata | Internal network reconnaissance, IAM credential theft |

### Where XXE actually lives

Anywhere XML gets parsed by code you didn't audit:

- **SAML responses** (federated SSO) — high-value because it's an auth boundary
- **SOAP/XML-RPC APIs** — older enterprise APIs
- **Office documents** (.docx, .xlsx are zipped XML), **SVG**, **EPUB**, **GPX**, **KML**, **RSS/Atom feeds**
- **Configuration imports** — XML-based settings upload
- **PDF metadata** parsing via XMP
- Anywhere a developer wrote `parseXml(userInput)` without reading the parser docs

### Mitigation — the actual answer

The CompTIA-correct answer and the SOC-correct answer are the same: **disable DTD processing in the parser**. Per OWASP:

| Language / Parser | Hardening flag |
|---|---|
| Java — `DocumentBuilderFactory` | `setFeature("http://apache.org/xml/features/disallow-doctype-decl", true)` |
| Java — `SAXParserFactory` | Same flag; also disable external general + parameter entities |
| .NET — `XmlReader` | `XmlReaderSettings.DtdProcessing = DtdProcessing.Prohibit` |
| .NET — `XmlDocument` | Set `XmlResolver = null` |
| Python — `lxml` | `etree.XMLParser(resolve_entities=False, no_network=True)` |
| Python — `xml.etree` | Use `defusedxml` instead |
| PHP — `libxml` | `libxml_disable_entity_loader(true)` (deprecated PHP 8+, off by default) |
| Node.js | Use `fast-xml-parser` with safe defaults; avoid `libxmljs` defaults |

Defense-in-depth, in order of effectiveness:

1. **Disable DTD / external entity resolution** at parser config (the actual fix)
2. **Patch / update parser libraries** — older versions have unsafe defaults
3. **Use safer formats** — accept JSON instead of XML if the use case allows
4. **Schema validation** with a whitelist, not just well-formedness checks
5. **Egress filtering** — block the parser host from making outbound DNS/HTTP to arbitrary destinations (kills OOB exfil and SSRF pivots)
6. **WAF rules** — last resort, easy to bypass with encoding tricks. Don't rely on this as primary control.

### Related injection family (CompTIA loves these mix-ups)

| Attack | Where | Vector |
|---|---|---|
| **[[XXE]]** | XML parser | External entity reference |
| **[[SQL injection]]** | DB query | Unsanitized SQL string |
| **[[XSS]]** | Browser DOM | Unsanitized JS/HTML |
| **[[SSRF]]** | Server-side HTTP client | Unvalidated URL fetch |
| **[[LFI]] / [[RFI]]** | Server-side file include | Unsanitized file path |
| **[[Directory traversal]]** | Filesystem read | `../` path manipulation |
| **[[CSRF]]** | Authenticated session | Cross-origin forged request |

XXE often chains into SSRF, LFI, and sometimes RCE. It's rarely the final objective — it's the foothold.

### CompTIA exam traps

> **CompTIA exam trap:** XXE is *not* fixed by input validation or WAF rules. The right answer is **disable DTD processing / external entity resolution in the parser**. If you see "deploy a WAF" or "sanitize user input" as an XXE mitigation answer, look for the parser-config option instead — that's the keeper.

> **CompTIA exam trap:** XXE looks like SQL injection in the question stem ("an attacker submits crafted input that causes the server to disclose internal files"), but the **payload contains `<!DOCTYPE`, `<!ENTITY`, or `SYSTEM`**. That's the giveaway. SQL injection payloads have `'`, `UNION SELECT`, `--`. Match the payload syntax to the vulnerability class.

> **CompTIA exam trap:** OWASP 2017 listed XXE as its own A4 category. OWASP 2021 folded it under **A05: Security Misconfiguration**. If the question references OWASP categories, check which version is being asked about. Most current exam material uses 2021.

> **CompTIA exam trap:** XXE-to-SSRF questions describe the attacker reaching `169.254.169.254` (AWS metadata) or `localhost:port` from a public endpoint. The root cause is XXE; the *impact* is SSRF; the *fix* is still at the parser. Don't pick "block 169.254.169.254 at the firewall" as the primary control — that's compensating, not corrective.

## SOC reality

- **What the alert looks like at 3am:** EDR flags `java` or `python` on the web tier making outbound DNS lookups to `*.burpcollaborator.net` or `*.oastify.com` — classic OOB XXE callbacks. Or WAF flags `<!DOCTYPE` and `SYSTEM` in a POST body. Or your DLP catches `/etc/passwd`-like strings leaving the web tier in an HTTP response.

- **First L1 action:** Pull the full request and response from the WAF or proxy. Confirm the XML payload contains an external entity declaration. Identify which endpoint accepted it. Check whether the response leaked file content or whether the server made outbound connections. *Do not assume "blocked by WAF" means safe — WAFs miss XXE constantly when the payload is encoded or uses parameter entities.*

- **What the IR lead asks:** "What did the parser read? Did anything go outbound? Which credentials live on that host? Was the SAML endpoint the one hit?" — because XXE on a SAML responder is a federation-wide incident, not a web app bug.

- **What never to promise leadership:** "It was just a scan, nothing was exfiltrated." If the parser resolves external entities and you can't prove the response stream was empty, you have to assume disclosure. *XXE without egress logging is a forensic black hole — you can't prove a negative when the parser silently fetched a file and dumped it into an error response that was never logged.*

- **Handoff point:** L1 confirms payload signature → L2 reviews app logs and parser config → AppSec / dev team confirms which parser is in use and whether DTDs are disabled → IR scopes blast radius (what files were readable by the service account, what internal hosts were reachable). If a SAML or auth-adjacent component is involved, identity team and legal join immediately.

- **The fix conversation with engineering:** "Set `disallow-doctype-decl` to true and redeploy" sounds like a one-line change. In a monorepo with 40 services using 6 different XML libraries, it's a two-sprint hardening project. Push for a CI rule that fails the build on insecure parser instantiation. *The vulnerability is one flag; the remediation is organizational discipline.*

## Related concepts

[[OWASP Top 10]] · [[SSRF]] · [[LFI]] · [[RFI]] · [[Directory traversal]] · [[SQL injection]] · [[XSS]] · [[CSRF]] · [[Insecure design]] · [[Security misconfiguration]] · [[SAML]] · [[Input validation]] · [[WAF]] · [[Egress filtering]] · [[Defense in depth]] · [[CVSS]] · [[Vulnerability scanning]]

*Source: VIRGIL knowledge base — 2026-05-11*