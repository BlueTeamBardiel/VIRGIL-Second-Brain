# SMTP — Simple Mail Transfer Protocol

## What it is

In **Breath of the Wild**, when you light a torch at a campfire and run it across Hyrule to ignite a brazier in some forgotten shrine, the flame doesn't care who lit it originally. It just propagates. Anyone could have lit that torch — a Bokoblin, a traveler, you. The flame is the flame. Now imagine the same fire-relay logic, but for messages between mail servers, designed in 1982 when nobody was thinking about Yiga Clan impersonators. That's **SMTP** — a trust-by-default flame-passing protocol that became the backbone of every phishing campaign you'll ever triage.

Plain English: SMTP is how mail servers hand mail to each other. It is plain-text, trust-everything, and authenticates nothing about the sender by default. Every anti-phishing control you've ever heard of — **[[SPF]]**, **[[DKIM]]**, **[[DMARC]]** — exists because SMTP itself refused to grow up.

Technical: SMTP is the application-layer protocol defined by RFC 5321 for the submission and relay of email between Mail Transfer Agents (MTAs). It runs over TCP on:

- **Port 25** — server-to-server relay (MTA → MTA)
- **Port 587** — authenticated client submission (MUA → MTA), STARTTLS expected
- **Port 465** — SMTPS, implicit TLS submission (resurrected from deprecation)

The protocol exchanges header-and-body messages via a command sequence: `HELO/EHLO`, `MAIL FROM`, `RCPT TO`, `DATA`, `.`, `QUIT`. None of these commands cryptographically bind the sender's identity to the message. That gap is the entire attack surface.

## Why it matters

Email is still the #1 initial access vector. Verizon DBIR has put phishing in the top three vectors every year since they started counting. As a CySA+ analyst, you will spend more time triaging suspicious email than almost any other ticket type. CompTIA objective **CS0-003 1.3** explicitly lists **email analysis** — headers, impersonation, embedded links, DKIM, SPF, DMARC — as malicious-activity tooling you must know cold.

The exam tests whether you can read a raw header, identify which auth mechanism failed, and decide if the message is spoofed, forwarded, or legitimate. The job tests whether you can do that in under 90 seconds while the user who clicked the link is still on the phone.

## Key facts

### The SMTP envelope vs the header — the trap that catches every junior analyst

Email has **two** "from" fields. CompTIA loves this.

| Layer | Field | Set by | User sees it? |
|---|---|---|---|
| Envelope | `MAIL FROM` (Return-Path) | Sending MTA | No |
| Header | `From:` | Sending client | Yes |

The envelope `MAIL FROM` is what SPF checks. The header `From:` is what the user reads in Outlook. A spoofer can set these to different domains. SPF can pass on the envelope while the visible `From:` says `ceo@yourcompany.com`. That's why DMARC exists — it enforces **alignment** between the two.

> **CompTIA exam trap:** SPF validates the envelope sender (`MAIL FROM` / Return-Path), NOT the header `From:`. A phish can pass SPF and still spoof the visible sender. DMARC is what closes that gap by requiring alignment.

### The three email authentication mechanisms

**[[SPF]] — Sender Policy Framework**
- DNS TXT record listing IP addresses authorized to send mail for a domain
- Receiving MTA checks: "did this connection come from an IP on the sender's SPF list?"
- Result tags: `pass`, `fail`, `softfail`, `neutral`, `none`, `permerror`, `temperror`
- Breaks on forwarding (the forwarder's IP isn't on the original sender's SPF list)

**[[DKIM]] — DomainKeys Identified Mail**
- Sending MTA signs selected headers + body hash with a private key
- Public key published in DNS at `selector._domainkey.domain.tld`
- Receiver verifies signature → confirms the message wasn't tampered with in transit and originated from a server with that private key
- Survives forwarding (the signature travels with the message)

**[[DMARC]] — Domain-based Message Authentication, Reporting, and Conformance**
- DNS TXT record at `_dmarc.domain.tld`
- Tells receivers: "if SPF and/or DKIM fail **and** don't align with the header `From:` domain, do this"
- Policies: `p=none` (monitor), `p=quarantine` (junk folder), `p=reject` (drop)
- Generates aggregate (`rua`) and forensic (`ruf`) reports back to the domain owner

> **CompTIA exam trap:** DMARC requires that **at least one** of SPF or DKIM passes **AND** aligns with the header `From:` domain. Alignment is the magic word. SPF-pass with a misaligned domain = DMARC fail.

### Reading a header — the analyst workflow

Mail headers are read **bottom-up**. The bottom `Received:` line is the first hop (closest to sender); the top is the last hop (your MTA). Each hop adds its own header on top.

What to extract from a suspicious header:

1. **`Received:` chain** — does the path make sense? Did the message come from an IP in a country your CEO doesn't fly to?
2. **`Authentication-Results:`** — your MTA's verdict on SPF/DKIM/DMARC. This is the first thing to read.
3. **`From:` vs `Return-Path:`** — do they align? Misalignment is the spoof tell.
4. **`Reply-To:`** — different from `From:`? Classic BEC tell. The user sees a familiar name, hits reply, and the reply goes to the attacker's gmail.
5. **`Message-ID:`** — should match the sending domain's MTA format. Mismatches scream relay-through-spammer-infrastructure.
6. **`X-Originating-IP:`** or `X-Sender-IP:` — actual source IP. Run it through **[[AbuseIPDB]]** and **[[WHOIS]]**.

### The phishing analyst toolkit (CS0-003 1.3 tools)

| Tool | What it does in email triage |
|---|---|
| **[[VirusTotal]]** | Hash the attachment, paste the URL — get aggregate AV / sandbox / reputation verdicts |
| **[[Joe Sandbox]] / [[Cuckoo Sandbox]]** | Detonate the attachment or URL in an isolated VM, observe behavior, capture C2 IoCs |
| **[[Wireshark]]** | Packet capture of the SMTP session itself — see `MAIL FROM`, the EHLO banner, STARTTLS upgrade |
| **[[AbuseIPDB]]** | Reputation check on the originating IP |
| **[[WHOIS]]** | Domain registration age — a `From:` domain registered 4 days ago is a phish until proven otherwise |
| **`strings`** | Pull readable ASCII/Unicode from a suspicious attachment without detonating it |
| **Hashing (`sha256sum`)** | Generate IoCs to pivot on across SIEM, EDR, and intel feeds |
| **Regex** | Extract URLs, IPs, hashes from raw email dumps for bulk triage |
| **Python / PowerShell / shell** | Parse `.eml` files at scale, query DMARC reports (XML/JSON), automate header extraction |

### Common SMTP-borne attacks

- **Phishing** — generic credential or malware bait, broadcast
- **Spear phishing** — targeted, researched, names the victim's manager
- **Business Email Compromise (BEC)** — impersonates an executive, requests wire transfer or gift cards; often no malware, just social engineering
- **Whaling** — BEC variant aimed at C-suite or finance leads
- **Lookalike domains** — `rnicrosoft.com` (rn vs m), `microsoft.co` (TLD swap), Cyrillic homoglyphs
- **Display name spoofing** — `From: "CEO Name" <attacker@gmail.com>` — Outlook shows only the display name on mobile
- **Reply-chain hijacking** — attacker steals a real mailbox, replies to a real thread with a malicious attachment. Highest success rate of any phish.
- **Open relay abuse** — a misconfigured MTA that relays mail for anyone. Should not exist in 2026 but routinely does.

### DMARC reports — the XML/JSON pivot

DMARC aggregate reports (`rua=`) arrive daily as zipped XML. They tell you which IPs are sending mail claiming to be your domain, and whether they passed SPF/DKIM/alignment. Parsing these is a CS0-003-relevant scripting task — **Python** with `xml.etree`, or a SIEM ingest pipeline. The reports surface:

- Shadow IT senders (marketing tool nobody told you about)
- Active spoofing campaigns against your brand
- Misaligned legitimate senders that need DKIM signing added

> **CompTIA exam trap:** A DMARC `p=reject` policy with no monitoring period will break legitimate mail. The correct rollout is `p=none` → analyze reports → fix legit senders → `p=quarantine` → `p=reject`. Tested as a sequencing question.

### What an SMTP packet capture actually shows

If you `tcpdump` port 25 or open a `.pcap` in Wireshark with the filter `smtp`, you see the literal protocol exchange:

```
S: 220 mx.target.com ESMTP
C: EHLO attacker.example
S: 250-mx.target.com Hello
C: MAIL FROM:<spoofed@yourcompany.com>
S: 250 OK
C: RCPT TO:<victim@target.com>
S: 250 Accepted
C: DATA
C: From: "CEO" <ceo@yourcompany.com>
C: Subject: Urgent wire
...
```

If STARTTLS was negotiated, the capture goes opaque after the upgrade. That's why some orgs run TLS-inspecting mail gateways at the perimeter.

## SOC reality

- **The L1 ticket:** user forwards an email to `phishing@company.com`. Your queue tool extracts headers, hashes attachments, defangs URLs, and presents a verdict pane. Your job: confirm the verdict, hunt for **other recipients** in the mail logs, and check if anyone clicked.
- **The CISO's first question** is never "was it phishing?" It's *"who clicked, and what did they enter?"* Scope before classification.
- **Never tell leadership "we blocked it"** until you've pivoted on the sender IP, the URL domain, and the attachment hash across every mail log, proxy log, and EDR telemetry source. One blocked recipient does not mean the campaign missed.
- **Mail gateway logs (Proofpoint, Mimecast, M365 Defender) feed the [[SIEM]].** Correlate the inbound SMTP event with the user's [[EDR]] process tree. PowerShell child of WINWORD.EXE within five minutes of mail delivery is your IoC chain.
- **Escalation point:** L1 confirms phish and pulls similar messages. L2 enriches with sandbox detonation and threat intel. **[[IR]]** team takes over if any user submitted credentials or executed payload — at that point you're chasing **[[command and control]]** beacons and **[[impossible travel]]** logins, not email anymore.

## Related concepts

[[SPF]] · [[DKIM]] · [[DMARC]] · [[Phishing]] · [[BEC]] · [[Email header analysis]] · [[VirusTotal]] · [[Joe Sandbox]] · [[Cuckoo Sandbox]] · [[Wireshark]] · [[AbuseIPDB]] · [[WHOIS]] · [[DNS]] · [[SIEM]] · [[EDR]] · [[SOAR]] · [[Impossible travel]] · [[Command and control]] · [[Sandboxing]] · [[STIX/TAXII]]

*Source: VIRGIL knowledge base — 2026-05-11*