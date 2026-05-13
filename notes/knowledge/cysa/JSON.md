# JSON — JavaScript Object Notation

## What it is

In **Dark Souls**, every item you pick up has a description card — a tidy little structured block that tells you exactly what the thing is, what it does, who used to wield it, and what kind of damage scales off which stat. The Estus Flask card says one thing. The Black Knight Sword card says another. Same format every time: name, type, stats, lore. The game engine reads those cards, the player reads those cards, and nobody argues about commas. That's exactly what JSON does — it's a flat, predictable, key-value text format that humans and machines both read without fighting each other.

**Plain English:** JSON is how modern tools talk to each other. APIs return JSON. SIEM exports JSON. Threat feeds publish JSON. Sandboxes spit JSON reports. If you do SOC work for more than a week, you will read JSON.

**Technical:** JavaScript Object Notation is a lightweight, language-independent, text-based data interchange format defined by RFC 8259 / ECMA-404. Data is structured as **objects** (`{ "key": "value" }`), **arrays** (`[ "a", "b" ]`), and primitives (string, number, boolean, null). It's the dominant serialization format for REST APIs, structured logs, SOAR playbook artifacts, and threat intelligence exchange — the wire format underneath nearly every blue-team tool built after about 2012.

## Why it matters

CySA+ Objective 1.3 asks the analyst to interpret tool output. In 2026, that output is overwhelmingly JSON. VirusTotal's API returns JSON. AbuseIPDB returns JSON. Cuckoo and Joe Sandbox emit JSON reports. Splunk and Elastic store events as JSON internally. SOAR playbooks pass JSON between actions. If you can't read a nested JSON object and pull out the verdict, the hash, the C2 domain, the file score — you can't do the job.

The exam tests this two ways: (1) showing you a JSON snippet from a sandbox or threat-intel lookup and asking what it means, and (2) asking you to distinguish JSON from XML and know when each is used.

## Key facts

### The syntax — the whole language in one card

```json
{
  "alert_id": "a91f3c",
  "severity": "high",
  "src_ip": "10.4.2.17",
  "dst_ip": "185.220.101.42",
  "indicators": ["c2_beacon", "dns_tunneling"],
  "enriched": {
    "geoip": "RU",
    "asn": 9009,
    "abuse_score": 87
  },
  "verified": true,
  "notes": null
}
```

That's it. Six rules:

- **Objects** use `{}` and hold key:value pairs separated by commas
- **Arrays** use `[]` and hold ordered values separated by commas
- **Keys** are always strings, always in double quotes
- **Values** are string, number, boolean (`true`/`false`), `null`, object, or array
- **No comments allowed** (RFC 8259) — strict parsers reject `//` and `/* */`
- **No trailing commas** — strict parsers reject `{"a":1,}`

### JSON vs XML — the comparison CompTIA will test

| Feature | JSON | XML |
|---|---|---|
| Syntax | `{"key":"value"}` | `<key>value</key>` |
| Verbosity | Compact | Verbose (closing tags) |
| Schema | JSON Schema (optional) | XSD (mature, strict) |
| Comments | Not supported (RFC 8259) | Supported |
| Attributes | No — only key/value | Yes — `<tag attr="x">` |
| Namespaces | No | Yes |
| Typical use | REST APIs, SIEM, SOAR, threat feeds | SOAP, SAML, legacy enterprise, STIX 1.x |
| Parser attack surface | Smaller — no entities | XXE, billion laughs, entity expansion |

> **CompTIA exam trap:** XML is vulnerable to **XXE (XML External Entity)** injection because XML supports external entity references. JSON has no equivalent — there's no entity mechanism. If the question shows you a payload with `<!DOCTYPE foo [<!ENTITY xxe SYSTEM "file:///etc/passwd">]>`, that's XML, not JSON, and the attack is XXE. Don't mix them.

### Where JSON shows up in the SOC

**Threat intelligence enrichment** — VirusTotal, AbuseIPDB, GreyNoise, Shodan, WHOIS APIs all return JSON. The analyst reads the `malicious` count, the `reputation` score, the `last_seen` timestamp.

```json
{
  "data": {
    "attributes": {
      "last_analysis_stats": {
        "malicious": 47,
        "suspicious": 2,
        "harmless": 18
      },
      "reputation": -84
    }
  }
}
```

47 of 65 engines flagging it. That's a hash you don't argue about.

**Sandbox detonation reports** — Cuckoo Sandbox and Joe Sandbox emit JSON describing every process spawn, registry write, network connection, dropped file, and API call. You grep the JSON for `dns_requests`, `http_requests`, `processes`, `mutex` — that's how you pull IoCs out of a detonation without reading 400 pages of HTML.

**SIEM events** — Modern SIEM (Elastic, Splunk in `_raw` JSON mode, Sentinel, Chronicle) stores every event as a JSON document. ECS (Elastic Common Schema) and OCSF (Open Cybersecurity Schema Framework) are both JSON schemas that normalize fields like `source.ip`, `destination.port`, `event.action` across vendors.

**SOAR playbook artifacts** — When a SOAR platform (Tines, Splunk SOAR, XSOAR) runs a playbook, every action's input and output is JSON. The "enrich IP" action takes a JSON IP, calls the API, stores JSON output, passes it to the next action.

**Email analysis output** — Tools that parse `.eml` files emit JSON: headers, SPF/DKIM/DMARC results, URLs, attachments with hashes. You feed that JSON downstream to a hash-reputation check.

### Reading nested JSON — the actual skill

The thing analysts get stuck on is **path notation**. Tools use dot notation or JSONPath to drill into structures:

- `data.attributes.last_analysis_stats.malicious` → walks down the tree
- `indicators[0]` → first element of the indicators array
- `$..hash` (JSONPath) → every `hash` field anywhere in the document

Command-line tools every analyst should know:

- **`jq`** — the universal JSON query tool. `cat report.json | jq '.processes[].command_line'` extracts every process command line from a Cuckoo report
- **`python -m json.tool`** — pretty-prints messy JSON
- **PowerShell** — `ConvertFrom-Json` turns JSON into a navigable object: `(Get-Content report.json | ConvertFrom-Json).network.dns`

*Learning `jq` upgrades you from "I'll open it in Notepad++" to "I'll pull every C2 domain out of 200 sandbox reports in one command." Worth the afternoon.*

### JSON in email authentication — DMARC reports

DMARC aggregate reports were originally XML, but modern reporting (and most SOC tooling that ingests them) converts to JSON for analysis. A DMARC failure record in JSON form:

```json
{
  "source_ip": "203.0.113.55",
  "count": 412,
  "policy_evaluated": {
    "disposition": "quarantine",
    "spf": "fail",
    "dkim": "fail"
  },
  "header_from": "yourbank.com"
}
```

Spoofed sender, SPF and DKIM both failed, 412 attempts. That's a phishing campaign impersonating your domain, and the JSON is how the abuse desk sees it.

### Common JSON pitfalls when interpreting tool output

- **String vs number** — `"score": "87"` is a string; `"score": 87` is a number. Comparison logic breaks if you don't notice.
- **`null` vs missing key** — `"notes": null` and the key being absent entirely are different. SOAR conditionals trip on this.
- **Booleans are lowercase** — `true`/`false`, not `True`/`False`. Python's `json.dumps` handles it; hand-edited JSON breaks.
- **Escaped strings** — backslashes in Windows paths (`C:\\Users\\victim`) must be double-escaped. A Cuckoo report showing `\\` in JSON is one backslash in reality.
- **Encoded blobs** — JSON can't hold binary, so malware samples, PCAPs, and screenshots come base64-encoded inside string fields. You see a 40,000-character string starting with `TVqQAAMAAAA` — that's `MZ`, a Windows PE file, base64'd.

### CompTIA exam traps

> **Exam trap:** JSON is **data**, not **code**. CompTIA may try to bait you with "JSON is a programming language." It's not. The "JavaScript" in the name refers to its syntactic origin in JS object literals. You don't "run" JSON — you parse it. Python, PowerShell, shell scripts — those are the languages that consume JSON.

> **Exam trap:** When a scenario shows API output with `{` and `}` and key:value pairs, it's JSON. When it shows `<tag>value</tag>`, it's XML. STIX 2.x is JSON; STIX 1.x was XML. TAXII 2.x uses JSON over HTTPS. If the question mentions modern threat intel exchange, default to JSON.

> **Exam trap:** JSON has no native schema enforcement at the wire level. Just because something is "valid JSON" doesn't mean it has the fields you expect. A malicious or malformed API response can return `{}` and pass JSON validation. Your playbook must check for required keys before using them.

## SOC reality

- The 3am VirusTotal lookup response comes back as a 6,000-line JSON blob. You don't read it linearly — you `jq '.data.attributes.last_analysis_stats'` and look at the malicious count. Decision made in 8 seconds.
- The L1 analyst gets handed a Cuckoo report and freezes because it's "too big." The L2 analyst pipes it through `jq` and pulls `.network.hosts`, `.network.dns`, `.signatures[].description` in three commands. That's the skill gap, and it's worth one afternoon to close.
- SOAR playbook fails at 4am because an upstream API returned `"data": null` instead of `"data": {}`. The conditional checked for `data.id` and threw a null-dereference. *Every playbook needs a "did the API actually return what we expected?" guard before the next step runs.*
- The CISO doesn't want to see the JSON. The CISO wants "yes, it's malicious, here's the count and source." Your job is to translate the JSON into a sentence. If you can't, you don't understand the JSON yet.
- DFIR handoff: the IR lead asks for "all IoCs from the detonation as a JSON file." That means a flat object with `hashes`, `domains`, `ips`, `urls` as arrays. Not the raw Cuckoo dump. Curating the JSON is part of the job.

## Related concepts

[[XML]] · [[STIX TAXII]] · [[Cuckoo Sandbox]] · [[Joe Sandbox]] · [[VirusTotal]] · [[AbuseIPDB]] · [[SIEM]] · [[SOAR]] · [[REST API]] · [[Python]] · [[PowerShell]] · [[jq]] · [[Regular expressions]] · [[DMARC]] · [[SPF]] · [[DKIM]] · [[Threat intelligence]] · [[Indicators of compromise]] · [[Log analysis]] · [[Email analysis]]

*Source: VIRGIL knowledge base — 2026-05-11*