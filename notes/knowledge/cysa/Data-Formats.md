# Data Formats

## What it is

In **Tomb Raider** (2013), Lara picks up relics scattered across Yamatai — and every relic comes with a journal entry. The relic itself is a 3D model: rotatable, inspectable, the actual artifact. The journal entry is structured text wrapped around it: who carved it, when, what tribe, what ritual. Same underlying *story*, two different containers. The relic is the payload; the journal is the schema that tells you what you're looking at.

That's exactly what data formats do in SOC work. The event is the relic — a failed login, a process spawn, a DNS query. The format — JSON, XML, CSV, syslog — is the journal entry that wraps it so a SIEM can parse it, a script can grep it, an analyst at 3am can read it.

**Technical definition:** A data format is the structured representation used to serialize log events, API responses, threat intel feeds, and configuration data so they can be transmitted, stored, and parsed by automated tools. For CS0-003, you need to recognize the common formats on sight, understand which tools emit which formats, and know how anomalies show up differently depending on the wrapper.

## Why it matters

You will not pass CySA+ Objective 1.2 without recognizing format on sight. The objective is "analyze indicators of potentially malicious activity" — every indicator the exam shows you arrives wrapped in a format. A Sysmon event is XML. A CloudTrail log is JSON. A firewall denial is syslog. A Zeek conn.log is TSV. If you can't tell what you're looking at, you can't tell what it's saying.

In the field: the L1 analyst lives in the SIEM, which already parsed everything into normalized fields. The L2/IR analyst pulls *raw* logs because the parser dropped a field that mattered, and now you're staring at 4MB of XML at 2am trying to find why the EDR alert didn't fire. Format literacy is the difference between "I trust what Splunk showed me" and "I went to the source and proved it."

CompTIA tests this as part of 1.2 — they show you a log snippet and ask what it indicates. The snippet's format is a clue. Application logs look one way. Sysmon looks another. Web server logs another. Don't waste exam seconds figuring out which is which.

## Key facts

### The formats you must recognize on sight

| Format | Visual cue | Where it shows up |
|---|---|---|
| **JSON** | `{ "key": "value" }` — curly braces, key/value pairs, brackets `[ ]` for arrays | REST APIs, cloud logs (AWS CloudTrail, Azure Activity), EDR alerts, threat intel feeds, modern SIEM output |
| **XML** | `<tag>value</tag>` — angle brackets, opening/closing tags, attributes inside the opening tag | Windows Event Logs (Sysmon, Security.evtx exports), SOAP APIs, STIX 1.x, SCAP/OVAL vuln scan output |
| **CSV** | Comma-separated values, often with a header row | Vulnerability scanner exports (Nessus, Qualys), asset inventories, bulk indicator dumps |
| **Syslog** | `<priority>timestamp host process[pid]: message` — single line, RFC 3164 or RFC 5424 | Firewalls, routers, Linux servers, network appliances |
| **Key=value** | `src=10.1.1.5 dst=8.8.8.8 action=allow` | Palo Alto, Fortinet, older Cisco — "pipe-delimited cousin" of syslog |
| **TSV / columnar** | Tab-separated, no quotes | Zeek (Bro) logs — conn.log, dns.log, http.log |
| **YAML** | Indentation-based, `key: value`, no braces | Detection rules (Sigma), config files, Kubernetes manifests |
| **STIX/TAXII** | JSON (STIX 2.x) or XML (STIX 1.x) wrapping threat intel objects | Threat intelligence sharing — MISP, ISACs, commercial feeds |

### JSON — the modern default

The cloud era runs on JSON. AWS CloudTrail, Azure Activity Log, GCP Audit Log, Okta, every SaaS audit trail — JSON. Most EDR platforms export alerts as JSON. [[STIX-TAXII]] 2.x is JSON-based.

```json
{
  "eventTime": "2026-05-11T03:14:22Z",
  "eventName": "ConsoleLogin",
  "sourceIPAddress": "185.234.218.45",
  "userIdentity": { "userName": "svc_backup" },
  "responseElements": { "ConsoleLogin": "Success" },
  "additionalEventData": { "MFAUsed": "No" }
}
```

What an analyst reads off that in two seconds: service account logging in interactively at 3am from a sketchy IP without MFA. Three [[Indicators of Compromise]] in one event. The JSON wrapper makes it grep-able, jq-able, and easy to pipe into a [[SIEM]] correlation rule.

### XML — Windows and legacy enterprise

Windows Event Log exports are XML. If you've ever pulled `.evtx` through `wevtutil` or PowerShell `Get-WinEvent -Oldest | ConvertTo-Xml`, you've seen it. Sysmon — the gold-standard endpoint telemetry tool — emits XML.

```xml
<Event>
  <System>
    <EventID>1</EventID>
    <TimeCreated SystemTime="2026-05-11T03:14:22Z"/>
  </System>
  <EventData>
    <Data Name="Image">C:\Windows\System32\powershell.exe</Data>
    <Data Name="CommandLine">powershell.exe -EncodedCommand JABz...</Data>
    <Data Name="ParentImage">C:\Windows\System32\winword.exe</Data>
  </EventData>
</Event>
```

That's a Sysmon Event ID 1 (process create). Winword spawning encoded PowerShell is a textbook macro-dropper [[Indicators of Compromise]]. The XML is verbose but explicit — every field is named, every tag closed. Verbose is good when you're correlating across thousands of events.

*XML is heavy on the wire and slow to parse, but the explicit schema saves you when fields are optional or nested.*

### CSV — the scanner's native tongue

[[Vulnerability Scanning]] tools dump CSV because spreadsheets eat it and management lives in spreadsheets. A Nessus export hands you 40 columns: Plugin ID, CVE, CVSS Base, CVSS Temporal, Host, Port, Severity, Synopsis, Description, Solution, See Also, Plugin Output. CSV is fast to read, easy to sort, and easy to weaponize against you when a field contains an embedded comma and the row breaks. Use proper parsers, not split-on-comma.

### Syslog — the network gear lingua franca

```
<134>May 11 03:14:22 fw01 PAN-OS: 1,2026/05/11 03:14:22,001801001234,TRAFFIC,end,10.1.1.5,185.234.218.45,...
```

Firewalls, switches, Unix daemons — syslog. The leading `<134>` is the PRI value (facility × 8 + severity). RFC 3164 is the messy old format; RFC 5424 is the cleaner structured version nobody fully adopted. Syslog over UDP/514 is unreliable and unauthenticated — TLS-wrapped syslog on TCP/6514 is the modern fix.

### Format ↔ indicator mapping (Objective 1.2)

| Indicator (from CS0-003 1.2) | Where you usually see it | Native format |
|---|---|---|
| Malicious processes, abnormal OS behavior | Sysmon, EDR | XML (Sysmon), JSON (EDR) |
| Unauthorized scheduled tasks, registry anomalies | Windows Event Log, Sysmon Event ID 12/13/14 | XML |
| Beaconing, unexpected outbound, irregular P2P | Zeek conn.log, firewall logs, NetFlow | TSV (Zeek), syslog/k=v (firewalls) |
| Unusual traffic spikes, bandwidth consumption | NetFlow/IPFIX, firewall counters | Binary flow records → JSON/CSV when exported |
| Data exfiltration, activity on unexpected ports | Firewall, proxy, DLP | syslog, k=v, JSON |
| Rogue devices, scans/sweeps | DHCP logs, NAC, IDS | syslog, JSON (Suricata EVE) |
| New accounts, unauthorized privileges | Windows Security log (4720, 4728, 4732), AD audit | XML (evtx), JSON (cloud IAM) |
| Application logs — unexpected output, anomalous activity | Web server, app-specific | Mixed — JSON/syslog/custom |
| Social engineering, obfuscated links | Email gateway, proxy | JSON (most modern), syslog |
| File system changes, drive capacity, memory/CPU consumption | Sysmon Event ID 11, performance counters | XML, JSON |

The takeaway: **the indicator is format-agnostic, but the parser is not.** A beaconing detection rule written for Zeek TSV will not fire on a Palo Alto k=v feed without rewriting.

### CompTIA exam traps

> **CompTIA exam trap:** A log snippet with `<EventID>4624</EventID>` is **Windows Event Log XML**, not generic XML config. Event 4624 = successful logon. Event 4625 = failed. Event 4720 = new account created. Don't get distracted by the XML and miss the event ID.

> **CompTIA exam trap:** JSON and YAML look similar at a glance — both are key/value. JSON has `{`, `}`, `"`, `,`. YAML has indentation and `:` only. If you see `key: value` with no quotes and no braces, it's YAML — usually a [[Sigma]] detection rule or a config file, not a log.

> **CompTIA exam trap:** STIX 2.x is JSON. STIX 1.x is XML. TAXII is the transport protocol, not the format. If the question asks "what format are STIX indicators delivered in?" — the modern answer is JSON over TAXII 2.x HTTPS.

> **CompTIA exam trap:** "Application logs" on the exam doesn't mean a specific format — it means *whatever the application chose to write*. Apache writes CLF (Common Log Format) text. IIS writes W3C extended format. A custom Java app might write JSON or unstructured text. The exam tests whether you recognize that application logs require *application-specific* parsing, unlike OS logs which are standardized.

### Obfuscation hides inside the format

[[Threat Actors]] know analysts grep for known-bad strings. So they hide.

- **Base64 inside JSON `CommandLine` fields** — PowerShell `-EncodedCommand` is the classic. Decode it before judging it.
- **Hex-encoded URLs in syslog** — proxy logs sometimes URL-encode the full request; `%2e%2e%2f` is `../`
- **Unicode and homoglyph attacks in JSON string fields** — `аpple.com` (Cyrillic а) vs `apple.com`
- **Multi-line strings in XML CDATA blocks** — `<![CDATA[ ... ]]>` tells the parser to ignore tags inside, attackers use it to smuggle payloads through XML-aware filters

*The format is a transport, not a verdict. Decode before you decide.*

## SOC reality

- **3am alert, raw log pull.** SIEM alert fires: "PowerShell encoded command." You click through. The parsed fields look fine. You pull the raw Sysmon XML from the endpoint and find the parent process — Outlook.exe. Parser dropped ParentImage. You just caught a phishing → macro → C2 chain because you went to the raw format.
- **L1 first action:** acknowledge alert, check the parsed SIEM view for the obvious fields (user, host, source IP, action). Escalate to L2 if anything looks off. L2 pulls raw logs in native format.
- **The CISO asks:** "Do we have the raw logs preserved?" — not the SIEM-normalized version, the original. Chain of custody and forensic admissibility both depend on the unaltered original. If your SIEM is the only copy, you have a problem.
- **Never promise leadership** that "the SIEM caught everything." SIEMs parse what their rules know how to parse. A new log source emitting a format the parser doesn't recognize will sit in the index as unparsed blob text, searchable only by full-text grep, invisible to correlation rules. Tuning gap = detection gap.
- **The handoff:** L1 → L2 includes the raw log artifact, not just the SIEM URL. L2 → IR includes the raw log, the parser config, and the timestamp range. IR → legal includes the original file, hash, and chain of custody form.

## Related concepts

[[SIEM]] · [[Log Sources]] · [[Sysmon]] · [[Windows Event Logs]] · [[STIX-TAXII]] · [[Indicators of Compromise]] · [[Threat Intelligence]] · [[Zeek]] · [[Sigma]] · [[NetFlow]] · [[Vulnerability Scanning]] · [[Chain of Custody]]

*Source: VIRGIL knowledge base — 2026-05-11*