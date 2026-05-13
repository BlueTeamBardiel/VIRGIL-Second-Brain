# SPF — Sender Policy Framework

## What it is

In **DOTA 2**, you check the scoreboard before mid lane and see the enemy Pudge is supposedly "level 6 in lane" — except your offlaner has been watching that lane the whole time and Pudge hasn't been there. Someone is lying about where they are. The map says one thing, the actual server state says another. SPF is the same check for email: the sender's envelope claims `mail-server.paypal.com`, but DNS publishes a list of IPs that are actually allowed to send for `paypal.com`. If the sending IP isn't on that list, the claim is a lie.

In plain English: SPF is a DNS-published allowlist of mail servers permitted to send email on behalf of a domain. The receiving mail server queries DNS for the domain in the envelope's `MAIL FROM`, gets back the SPF record, and checks whether the connecting IP is allowed.

Technical definition: **Sender Policy Framework** (RFC 7208) is an email authentication mechanism published as a DNS TXT record. It lets a domain owner declare which IP addresses are authorized to send mail using that domain in the SMTP envelope `MAIL FROM` (the **return-path**, not the visible `From:` header). The receiver checks the connecting SMTP client IP against the published policy and produces a result: `pass`, `fail`, `softfail`, `neutral`, `none`, `temperror`, or `permerror`.

## Why it matters

Phishing is the entry vector for the majority of intrusions you'll triage. Business email compromise (BEC) cost organizations billions before SPF/DKIM/DMARC became table stakes. As a CySA+ analyst, you don't deploy SPF — you read it. You pull a suspicious email's headers, see `spf=fail` or `spf=softfail`, and that's your first signal that the sender is impersonating a domain they don't own. Conversely, you'll see `spf=pass` on phishes that abuse lookalike domains, and you need to know SPF doesn't validate the visible `From:` header — only the envelope sender. That gap is where attackers live.

**Exam relevance:** Objective 1.3 explicitly lists SPF, DKIM, and DMARC under email analysis. CompTIA tests whether you can read a header, interpret an authentication result, and explain why SPF alone isn't enough. Expect questions where SPF passes but the email is still malicious — and you need to identify why.

## Key facts

### The DNS record

SPF lives in a DNS **TXT record** at the apex of the domain. One record per domain. Example:

```
paypal.com.  TXT  "v=spf1 ip4:173.0.84.0/24 include:_spf-1.paypal.com -all"
```

Breakdown:

| Token | Meaning |
|---|---|
| `v=spf1` | Version identifier — must be first |
| `ip4:` / `ip6:` | Authorized IPs / CIDR ranges |
| `a` | Authorize the domain's A record |
| `mx` | Authorize the domain's MX hosts |
| `include:` | Pull in another domain's SPF policy (delegated senders like SendGrid, M365) |
| `~all` | Softfail anything else (suspicious but accept) |
| `-all` | Hardfail anything else (reject) |
| `?all` | Neutral — no opinion |
| `+all` | Pass everything — **never legitimate**, treat as misconfigured or hostile |

### The seven result codes

| Result | Meaning | What you do |
|---|---|---|
| `pass` | IP is authorized | Sender is who they claim — for the envelope |
| `fail` | IP not authorized, policy says `-all` | Reject or quarantine |
| `softfail` | IP not authorized, policy says `~all` | Suspicious, often delivered to spam |
| `neutral` | Policy says `?all` | No assertion |
| `none` | Domain has no SPF record | Can't verify — common with small domains |
| `temperror` | DNS timeout, retry later | Transient |
| `permerror` | SPF record is malformed | Misconfiguration, often >10 DNS lookups |

### The 10-lookup limit

SPF caps DNS lookups at **10**. Every `include:`, `a`, `mx`, `ptr`, `exists`, and `redirect` counts. Big enterprises with M365 + Salesforce + Mailchimp + Zendesk blow past this constantly, which produces `permerror` — and `permerror` is treated by most receivers as `none`, silently disabling protection. *I learned this the hard way watching a Fortune 500 think they were protected for three years while their SPF was `permerror`-ing at every check.*

### How SPF, DKIM, and DMARC stack

SPF alone is weak because it only validates the **envelope** `MAIL FROM`, not the visible `From:` header the user sees. An attacker can pass SPF for `attacker-controlled.com` while displaying `From: ceo@yourcompany.com` in the email client.

[[DKIM]] (DomainKeys Identified Mail) cryptographically signs message headers and body with a private key; the public key lives in DNS. It survives forwarding better than SPF.

[[DMARC]] (Domain-based Message Authentication, Reporting, and Conformance) ties SPF and DKIM together with a critical addition: **alignment**. DMARC requires that the domain SPF passed on (envelope) matches the domain in the visible `From:` header. It also publishes a policy (`p=none`, `p=quarantine`, `p=reject`) and an `rua=` address for aggregate reports.

> **CompTIA exam trap:** SPF authenticates the envelope `MAIL FROM` (return-path), not the `From:` header the user sees in their mail client. An email can pass SPF and still be impersonating someone — that's why DMARC exists. If the question shows SPF passing but the email is still phishing, the answer involves DMARC alignment or display-name spoofing, not SPF failure.

### Reading an email header

When you pull a header in your SOC tooling or by viewing source, you'll see something like:

```
Authentication-Results: mx.google.com;
       spf=fail (google.com: domain of bounce@malicious.tk
         does not designate 198.51.100.7 as permitted sender)
         smtp.mailfrom=bounce@malicious.tk;
       dkim=none;
       dmarc=fail (p=reject) header.from=paypal.com
Received: from mail.malicious.tk (mail.malicious.tk [198.51.100.7])
```

Three things to extract:
1. **`spf=` result** and the IP that triggered it
2. **`smtp.mailfrom=`** — the envelope sender (what SPF checked)
3. **`header.from=`** — the visible From (what the user saw, what DMARC aligns against)

If `smtp.mailfrom` and `header.from` are different domains, you're looking at envelope spoofing — a classic phishing pattern.

### Tools you'll actually use

| Tool | Purpose |
|---|---|
| `dig TXT domain.com` | Pull the live SPF record |
| `nslookup -type=TXT domain.com` | Same, Windows-friendly |
| MXToolbox SPF check | Web UI, counts lookups, flags `permerror` |
| [[WHOIS]] | Who registered the sending domain, when (new domain = suspicious) |
| [[VirusTotal]] | Submit IPs, URLs, attachments — check reputation |
| [[AbuseIPDB]] | Community reputation for the connecting IP |
| [[Wireshark]] | Capture SMTP traffic to see envelope at the wire level |
| [[Sandbox]] (Cuckoo, Joe Sandbox) | Detonate attachments and links from the suspect email |

### SPF in the phishing triage workflow

1. **Pull the full header.** Not the "from" line — the raw header.
2. **Read `Authentication-Results`.** SPF, DKIM, DMARC verdicts in one block if the receiver added them.
3. **Compare `smtp.mailfrom` to `header.from`.** Mismatch = envelope spoofing.
4. **Resolve the sending IP.** WHOIS, AbuseIPDB, VirusTotal. New ASN, residential IP, recently registered domain — all flags.
5. **Hash and detonate attachments.** SHA-256, submit to VirusTotal, then [[Cuckoo Sandbox]] or [[Joe Sandbox]] if detection is sparse.
6. **Extract embedded URLs.** `strings` against the email body, regex for `https?://`, defang, submit to URL sandbox.
7. **Pivot in SIEM.** Did anyone else in the org get this sender? Did anyone click? [[User and entity behavior analytics|UEBA]] — did the recipient just do something abnormal after receiving it?

### Common SPF failure scenarios — not all are malicious

| Scenario | Why SPF fails | Malicious? |
|---|---|---|
| Forwarded mail (alumni alias, mailing list) | Forwarder rewrites path but original IP fails | No — known limitation |
| Marketing vendor not added to SPF | New SaaS sender, IT forgot the `include:` | No, but fix it |
| `permerror` from >10 lookups | Misconfigured policy | No, but security is silently broken |
| Lookalike domain (`paypaI.com` with capital I) | SPF passes for the attacker's *real* lookalike domain | **Yes** — SPF can't save you here |
| Compromised sender's legitimate server | SPF passes because the IP is authorized | **Yes** — SPF doesn't detect account takeover |

> **CompTIA exam trap:** A `softfail` (`~all`) result is not the same as `fail` (`-all`). Softfail says "probably not legitimate but I'm not certain" — most receivers deliver to spam rather than reject. Hardfail says "reject this." CompTIA will give you a scenario with `~all` and ask whether the message will be delivered. Answer: usually yes, to the spam folder.

> **CompTIA exam trap:** SPF, DKIM, and DMARC are easy to swap on the exam. SPF = IP authorization in DNS. DKIM = cryptographic signature. DMARC = alignment policy + reporting that ties the other two to the visible From. If the question asks about *cryptographic* validation, it's DKIM. If it asks about *which IPs can send*, it's SPF. If it asks about *what the user actually sees in their inbox*, it's DMARC alignment.

## SOC reality

- The phishing report ticket lands in the queue. You don't get to read the email — you read its header in a JSON blob your email security gateway dumped into the SIEM. Look for the `Authentication-Results` field first; SPF/DKIM/DMARC verdicts are right there.
- L1 first action: extract sender domain, sender IP, recipient list, attachment hashes, embedded URLs. Run the IP through AbuseIPDB and VirusTotal. If SPF failed and the domain is <30 days old per WHOIS, you're escalating.
- The IR lead asks: "How many users got it? How many clicked? Did anyone enter credentials? Did anyone open the attachment? Is the sender domain in our allowlist by accident?" The last question burns more orgs than you'd think — someone added a vendor to bypass filtering and forgot.
- Never tell the CISO "we blocked it because SPF failed." SPF failing means *the envelope* was spoofed. The CISO will ask why your DMARC policy is `p=none` and the malicious email still hit inboxes. Know your own org's DMARC policy before you take the call.
- Handoff: L1 confirms the indicators, L2 pulls the SIEM pivot for everyone who received the same campaign, IR coordinates user notification and credential resets if anyone clicked. Email security team gets a ticket to add the sender domain and IP to the block list and update the org's SPF if a legitimate vendor was the trigger.

## Related concepts

[[DKIM]] · [[DMARC]] · [[DNS]] · [[WHOIS]] · [[Phishing]] · [[Business Email Compromise]] · [[Email Header Analysis]] · [[VirusTotal]] · [[AbuseIPDB]] · [[Cuckoo Sandbox]] · [[Joe Sandbox]] · [[Indicators of Compromise]] · [[SIEM]] · [[Sandboxing]] · [[Impersonation]] · [[User and entity behavior analytics]]

*Source: VIRGIL knowledge base — 2026-05-11*