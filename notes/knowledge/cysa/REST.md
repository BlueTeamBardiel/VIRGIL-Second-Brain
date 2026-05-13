# REST — Representational State Transfer

## What it is

In **Forza Horizon**, when you fast-travel to a new festival site, the game doesn't reload the entire map state. Your car position, your credits, your wheelspin count, your event progress — each of those is a separate resource the game knows how to fetch, update, or send back to the cloud. You ping a specific URL ("give me my garage"), the server hands back a structured response, you act on it, the connection closes. The server doesn't remember who you are between calls — every request you make carries its own credentials and context. That's exactly what REST does — it's a stateless way for one program to ask another program for a specific resource, get a structured answer back, and move on.

**Plain English:** REST is the dominant pattern for how modern APIs talk. Client sends an HTTP request to a URL representing a resource. Server sends back JSON (usually) or XML. Stateless — every request stands alone.

**Technical (CS0-003):** **Representational State Transfer** is an architectural style for distributed systems, built on HTTP. Clients interact with resources (identified by URIs) via standard HTTP verbs — GET, POST, PUT, PATCH, DELETE. Responses are typically [[JSON]] or [[XML]]. REST is stateless, cacheable, and layered. For a CySA+ analyst, REST is how your SOAR platform talks to your EDR, how your SIEM pulls threat intel from a feed, how AbuseIPDB and VirusTotal expose their reputation data, and how an attacker exfils data over what looks like normal API traffic.

## Why it matters

REST is the connective tissue of the modern SOC. CS0-003 Objective 1.3 doesn't list "REST" as a standalone bullet, but it's underneath nearly every tool you touch: [[VirusTotal]] lookups, [[AbuseIPDB]] reputation checks, [[WHOIS]] enrichment, [[SOAR]] playbook actions, EDR query APIs, ticketing system integrations. If you write a Python script to enrich an alert, you're calling REST. If you build a SOAR workflow that auto-isolates a host, you're calling REST.

It also matters defensively. **Attackers love REST** because it looks like business traffic — HTTPS on 443, JSON payloads, valid TLS certs. C2 channels over REST APIs (Slack webhooks, Discord, Telegram, Dropbox, GitHub gists) blend into the noise. If your detection logic only flags "weird ports" and "unsigned binaries," REST-based C2 walks right past you.

Exam-relevant because Objective 1.3 covers scripting (Python, PowerShell), data formats (JSON, XML), and tool integration — and REST is the spine connecting all three.

## Key facts

### The HTTP verbs and what they do

| Verb | Action | Idempotent? | SOC example |
|------|--------|-------------|-------------|
| **GET** | Retrieve a resource | Yes | Pull alert details from SIEM API |
| **POST** | Create a resource | No | Submit a file hash to VirusTotal |
| **PUT** | Replace a resource | Yes | Update an EDR isolation policy |
| **PATCH** | Modify part of a resource | No | Change one field on a SOAR ticket |
| **DELETE** | Remove a resource | Yes | Close an incident in the ticketing system |

Idempotent = running it twice has the same effect as running it once. Matters when a script retries on timeout — you don't want PATCH retried five times and the ticket priority bumped five times.

### Response codes the analyst actually cares about

- **200 OK** — success, payload returned
- **201 Created** — POST worked, new resource exists
- **204 No Content** — success but nothing to return (common on DELETE)
- **400 Bad Request** — your payload is malformed; check your JSON
- **401 Unauthorized** — bad or missing API key
- **403 Forbidden** — key is valid but lacks permission
- **404 Not Found** — resource doesn't exist (or your URI is wrong)
- **429 Too Many Requests** — rate-limited; back off
- **5xx** — server's problem, not yours; retry with exponential backoff

*A SOAR playbook that doesn't handle 429s correctly will hammer the VirusTotal API at 4am, get the org's key throttled, and silently break enrichment across every alert in queue. I have watched this happen.*

### JSON — what you'll see 95% of the time

```json
{
  "ip": "185.220.101.47",
  "abuseConfidenceScore": 100,
  "countryCode": "DE",
  "usageType": "Data Center/Web Hosting/Transit",
  "isTor": true,
  "totalReports": 1847
}
```

That's an [[AbuseIPDB]] response. Key-value pairs, nested objects, arrays. Python `json.loads()` turns it into a dict, you walk the keys, you make a decision.

### XML — what you'll see when the API is old

```xml
<response>
  <ip>185.220.101.47</ip>
  <abuseConfidenceScore>100</abuseConfidenceScore>
  <isTor>true</isTor>
</response>
```

Same data, heavier syntax, parsed with `xml.etree.ElementTree` or `lxml`. Microsoft, SOAP-era apps, and some compliance feeds (STIX/TAXII 1.x) still use XML. CompTIA tests that you know XML and JSON are interchangeable data formats — same information, different envelope.

### Authentication patterns

- **API key in header** — `Authorization: Bearer <key>` or `X-API-Key: <key>`. Most common.
- **API key in URL** — older, less secure; key shows in logs and browser history.
- **OAuth 2.0** — token-based, scoped, expires. Used by Microsoft Graph, Google, Slack.
- **HMAC signatures** — AWS-style; key signs the request, server verifies.

When you onboard a new feed into the SOC, the first thing you do is figure out which of these it uses and where the key gets stored. **API keys belong in a secrets manager, not in the script.** Hardcoded keys in GitHub repos are an OSINT goldmine for attackers.

### REST in the SOC toolchain

| Tool | What REST does for you |
|------|------------------------|
| [[VirusTotal]] | Hash, URL, IP, domain reputation lookups |
| [[AbuseIPDB]] | IP abuse confidence scores |
| [[WHOIS]] APIs | Domain registration enrichment |
| [[Shodan]] | External attack-surface enumeration |
| SIEM (Splunk, Elastic, Sentinel) | Query logs, push events, manage detections |
| [[SOAR]] platforms | Orchestrate every other tool via REST |
| EDR (CrowdStrike, SentinelOne, Defender) | Isolate hosts, query process trees, retrieve files |
| Ticketing (Jira, ServiceNow) | Create, update, close incidents |
| Threat intel (MISP, OTX, Anomali) | Pull IoCs into the SIEM |

The pattern is always the same: analyst hits an alert → enrichment script fires REST calls to 5-10 of these tools in parallel → response JSONs get stitched into a context block → analyst reads the verdict in one screen instead of pivoting through ten tabs. That's the whole job of a Tier 1 SOAR workflow.

### Sample Python enrichment — what the day-to-day looks like

```python
import requests

headers = {"Key": API_KEY, "Accept": "application/json"}
params = {"ipAddress": "185.220.101.47", "maxAgeInDays": 90}

r = requests.get("https://api.abuseipdb.com/api/v2/check",
                 headers=headers, params=params, timeout=10)

if r.status_code == 200:
    data = r.json()
    score = data["data"]["abuseConfidenceScore"]
    if score > 75:
        escalate(data)
elif r.status_code == 429:
    backoff_and_retry()
```

Eight lines. That's an enrichment. Multiply by every IoC in every alert and you understand why every SOC in 2026 lives or dies by its API integration hygiene.

### REST as a C2 and exfil channel

Attackers use REST because it's invisible inside HTTPS:

- **Slack/Discord/Telegram webhooks** as C2 dead drops
- **Dropbox/Google Drive APIs** for staging and exfil
- **GitHub gists** for payload retrieval and beacon configs
- **Pastebin/Ghostbin** for IoC distribution to malware
- **Cloud provider APIs** (AWS S3, Azure Blob) abused with stolen keys

Detection lives in [[user behavior analysis]] and [[pattern recognition]] — not in port blocking. Look for: unusual API endpoints contacted from server workloads, anomalous request volumes, off-hours API activity, beaconing intervals to legitimate services.

### CompTIA exam traps

> **CompTIA exam trap:** JSON vs XML. They are both **data serialization formats** used by APIs. JSON is lighter and more common in REST; XML is heavier and common in SOAP/legacy. CompTIA will ask which one an API "uses" — the answer is usually "depends on the API," but if forced to pick, REST defaults to **JSON**, SOAP defaults to **XML**.

> **CompTIA exam trap:** REST vs SOAP. REST is an **architectural style** (uses HTTP verbs, stateless, usually JSON). SOAP is a **protocol** (XML-only, has its own envelope schema, can run over multiple transports). CompTIA loves to ask which is "stateless" — REST.

> **CompTIA exam trap:** Stateless does NOT mean "no authentication." It means the server doesn't remember anything between requests. Every REST call still must carry its own auth token. Candidates conflate "stateless" with "anonymous" and lose the point.

> **CompTIA exam trap:** HTTP status codes. **401 = unauthenticated** (no/bad credentials), **403 = unauthorized** (good credentials, wrong permissions). CompTIA will test this exact distinction.

## SOC reality

- At 3am, the alert that wakes you isn't "REST traffic detected" — it's "endpoint beaconing to api.telegram.org every 47 seconds." That's REST being abused as C2. You won't see "REST" in the log; you'll see HTTPS to a legitimate-looking domain on 443. The tell is the **rhythm**, not the protocol.
- L1 analyst's first move on any alert is enrichment. That means firing REST calls to VirusTotal, AbuseIPDB, WHOIS, and the internal asset DB before touching the escalation button. If your enrichment SOAR playbook is broken, your MTTD doubles.
- CISO question on incident calls: *"Was data exfiltrated and over what channel?"* If the answer is "REST API to a third-party SaaS we don't have visibility into," you have a hard conversation ahead about egress monitoring and CASB coverage.
- Never promise leadership "we've blocked the C2" when the C2 is REST over HTTPS to a legitimate cloud provider. You can block the specific URI/host, but the attacker spins up a new endpoint in 20 minutes. Containment is the host, not the channel.
- Handoff: L1 enriches and tags, L2 confirms the behavioral pattern (beaconing intervals, request size deltas, user-agent anomalies), IR pulls packet captures with [[Wireshark]] and decrypts where TLS inspection exists. If TLS inspection doesn't exist on that egress path, the conversation pivots to the network team and the next quarter's budget.

## Related concepts

[[JSON]] · [[XML]] · [[SOAR]] · [[VirusTotal]] · [[AbuseIPDB]] · [[WHOIS]] · [[Python]] · [[PowerShell]] · [[Shell script]] · [[Regular expressions]] · [[User behavior analysis]] · [[Pattern recognition]] · [[Command and control]] · [[Endpoint detection and response]] · [[Wireshark]] · [[Packet capture]] · [[SIEM]] · [[Log analysis and correlation]] · [[STIX/TAXII]]

*Source: VIRGIL knowledge base — 2026-05-11*