# DMARC — Domain-based Message Authentication, Reporting, and Conformance

## What it is

In **Breath of the Wild**, when you walk up to a Sheikah Shrine, the pedestal reads the Sheikah Slate. If the slate is authentic — the right runes, the right signature, registered to Link — the door slides open. If something walks up with a forged slate, the shrine stays sealed and Purah and Robbie get a log entry at the Tech Lab telling them somebody just tried to spoof a Hero of Hyrule. Authentication, plus a reporting channel back to the people who care.

That's exactly what DMARC does. Email arrives claiming to come from `paypal.com`. DMARC tells the receiving mail server: check the slate (SPF and DKIM), confirm it aligns with the domain on the envelope, and if it fails — quarantine it, reject it, or let it through but tell the real owner of `paypal.com` that somebody just tried to forge their identity.

**Technical definition:** DMARC is a DNS-based email authentication policy and reporting protocol (RFC 7489) that builds on top of [[SPF]] (Sender Policy Framework) and [[DKIM]] (DomainKeys Identified Mail). It does three things SPF and DKIM alone don't:

1. **Alignment** — requires that the domain authenticated by SPF or DKIM matches the domain in the visible `From:` header (the one the user actually sees).
2. **Policy** — tells receivers what to do when authentication fails: `none`, `quarantine`, or `reject`.
3. **Reporting** — sends aggregate (`rua`) and forensic (`ruf`) reports back to the domain owner so they can see who's spoofing them and how often.

DMARC lives as a TXT record at `_dmarc.example.com`.

## Why it matters

Phishing and business email compromise (BEC) are the top initial-access vectors year over year. The FBI IC3 puts BEC losses in the billions annually. The cheap version of phishing — spoofing the `From:` header to look like the CEO — gets stopped by DMARC at policy `reject`. The expensive version — lookalike domains, compromised supplier accounts — DMARC doesn't catch, but it forces attackers up the cost curve.

For CySA+, DMARC sits inside **Objective 1.3** under email analysis and impersonation defense. You will see DMARC on the exam paired with SPF and DKIM, and CompTIA will absolutely ask you to interpret a DMARC record, identify which policy is in effect, or explain why an email failed authentication despite SPF passing (alignment failure — the classic trap).

In the SOC, DMARC reports are how you discover that your own marketing team is sending campaigns from a third-party SaaS that you never authorized in SPF. Half the time DMARC tuning is an internal hygiene problem, not an attacker problem.

## Key facts

### The DMARC record

A DMARC record is a DNS TXT record at `_dmarc.<domain>`. Example:

```
_dmarc.example.com. IN TXT "v=DMARC1; p=reject; rua=mailto:dmarc-agg@example.com;
ruf=mailto:dmarc-forensic@example.com; adkim=s; aspf=s; pct=100; fo=1"
```

| Tag | Meaning | Common values |
|-----|---------|---------------|
| `v` | Version (required, must be first) | `DMARC1` |
| `p` | Policy for the domain | `none`, `quarantine`, `reject` |
| `sp` | Policy for subdomains | same options as `p` |
| `rua` | Aggregate report URI (XML, daily) | `mailto:...` |
| `ruf` | Forensic/failure report URI (per-message) | `mailto:...` |
| `adkim` | DKIM alignment mode | `r` (relaxed, default) or `s` (strict) |
| `aspf` | SPF alignment mode | `r` (relaxed, default) or `s` (strict) |
| `pct` | Percentage of failing mail to apply policy to | `0`–`100` |
| `fo` | Forensic options | `0`, `1`, `d`, `s` |

### How DMARC evaluates a message

1. Receiver pulls the `From:` header domain (the "header from" or "RFC5322.From").
2. Receiver checks **SPF**: does the `MAIL FROM` (envelope sender, RFC5321) match an authorized IP in the sender's SPF record?
3. Receiver checks **DKIM**: does the message carry a valid DKIM signature whose `d=` domain corresponds to the sender?
4. Receiver checks **alignment**: does SPF-pass domain OR DKIM-pass domain match the header-from domain?
5. **DMARC passes if at least one of SPF or DKIM passes AND aligns.** Both can fail individually as long as one passes-and-aligns.
6. If DMARC fails, apply policy `p` to `pct` percent of failing mail.
7. Send aggregate XML report to `rua` (typically once per day per reporting receiver).

### Alignment — the part everyone misses

SPF and DKIM each authenticate a domain. DMARC requires that domain to **align** with the `From:` header the user sees.

- **Relaxed alignment (`r`)** — organizational domain must match. `mail.example.com` aligns with `example.com`.
- **Strict alignment (`s`)** — exact domain match required. `mail.example.com` does NOT align with `example.com`.

This is why a phishing email can pass SPF (the attacker's server is authorized for the attacker's domain) and still fail DMARC (the `From:` header says `paypal.com` but SPF authenticated `attacker.com`).

### Policy progression — the real-world deployment path

Nobody flips DMARC to `reject` on day one. The deployment path is always:

1. **`p=none`** with `rua` reporting — monitor mode. Collect data on who's sending as you. Fix SPF/DKIM for legitimate senders (marketing platforms, ticketing systems, HR tools).
2. **`p=quarantine; pct=10`** — start small. Send 10% of failures to spam folders. Watch reports.
3. **`p=quarantine; pct=100`** — full quarantine.
4. **`p=reject`** — receivers drop failing mail at the SMTP transaction. Attacker gets a bounce. User never sees it.

> **CompTIA exam trap:** `p=none` is NOT a defensive policy. It only enables reporting. A domain at `p=none` is functionally unprotected from spoofing — receivers will deliver failing mail as if DMARC weren't published. CompTIA will hand you a scenario where DMARC is "deployed" with `p=none` and ask why the spoofed CEO email got through. The answer is: monitoring mode does not enforce.

### Aggregate vs forensic reports

| | Aggregate (`rua`) | Forensic (`ruf`) |
|---|---|---|
| Frequency | Daily, batched per reporting org | Per-failure, real-time |
| Format | [[XML]] (gzipped) | AFRF (RFC 5965) or [[JSON]] |
| Content | Counts of pass/fail per source IP | Redacted copy of the failing message |
| Privacy | Low — just metadata | High — actual message content, often disabled by receivers |
| SOC use | Source-IP discovery, shadow IT detection | Active spoofing investigation when available |

Aggregate reports are the workhorse. You parse the XML, identify source IPs sending as your domain, and either authorize them (add to SPF, deploy DKIM) or hunt them as adversaries. Tools like dmarcian, Valimail, or homegrown Python parsers do this at scale.

### What DMARC does NOT defend against

- **Lookalike domains** — `paypa1.com`, `paypal-secure.com`, `paypal.com.attacker.tld`. DMARC only protects domains where it's published. Use [[WHOIS]] monitoring, certificate transparency logs, and domain takedown services for these.
- **Compromised legitimate accounts** — if the attacker takes over a real `vendor.com` mailbox, DMARC passes. This is BEC and it's what kills companies.
- **Display-name spoofing** — `From: "CEO Name" <attacker@gmail.com>`. DMARC validates the domain, not the display name. Many mobile clients show only the name. User-awareness control, not DMARC.
- **Reply-to manipulation** — DMARC doesn't authenticate `Reply-To:`. Attacker sets `Reply-To:` to their inbox; victim's reply goes to the attacker even after passing DMARC.

### Tools the SOC actually uses

- **MXToolbox / dmarcian / EasyDMARC** — quick DNS lookup, record validation.
- **`dig TXT _dmarc.example.com`** — the on-call answer at 3am.
- **Python with `dmarc` or `parsedmarc` libraries** — parse aggregate XML at scale.
- **[[VirusTotal]]** — pivot on sender IPs and message hashes when investigating a phish that slipped through.
- **[[AbuseIPDB]]** — reputation check on the source IPs DMARC reports surface.
- **Email gateway logs (Proofpoint, Mimecast, M365 Defender)** — show the DMARC verdict per message: `dmarc=pass`, `dmarc=fail (p=reject)`, etc., in the `Authentication-Results:` header.

### Reading the Authentication-Results header

```
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bounce@example.com designates 192.0.2.1 as permitted sender) smtp.mailfrom=bounce@example.com;
       dkim=pass header.i=@example.com header.s=selector1;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=example.com
```

`dis=NONE` means no disposition was applied — the message passed. `dis=QUARANTINE` or `dis=REJECT` shows enforcement. This header is your forensic gold when triaging a phishing report.

### CompTIA exam traps

> **Trap 1 — SPF pass ≠ DMARC pass.** A message can have `spf=pass` and still get `dmarc=fail` because of alignment. The SPF check passed for `attacker.com` but the `From:` header says `bank.com`. Different domains, no alignment, DMARC fails. CompTIA loves this scenario.

> **Trap 2 — DMARC requires SPF OR DKIM to pass-and-align, not both.** Forwarded mail often breaks SPF (the forwarder's IP isn't in the original sender's SPF). DKIM survives forwarding because the signature is on the message body. DMARC passes if DKIM passes-and-aligns. This is why DKIM matters even when SPF "works."

> **Trap 3 — `pct` only applies to `quarantine` and `reject`, not to `none`.** And the unaffected percentage falls back to the next-lower policy, not to no action.

> **Trap 4 — Subdomain policy (`sp`) is inherited from `p` if not explicitly set.** If `p=reject` but you never set `sp`, subdomains get `reject` too. Locks out legitimate subdomain senders you forgot about.

## SOC reality

- The phishing ticket lands in the queue at 9:47am: "I got an email from the CFO asking me to buy gift cards." First move: pull the full headers, scan for `Authentication-Results`, check the DMARC verdict. If `dmarc=pass`, the CFO's account is probably compromised — escalate to IR fast. If `dmarc=fail` and the gateway delivered it anyway, the gateway is misconfigured — that's a control failure.
- The CISO asks: "Are we protected against email spoofing of our domain?" The honest answer is the policy string. `p=none` means no. `p=quarantine` means mostly. `p=reject` means yes — for your domain only. You are not protected against lookalikes or BEC.
- DMARC aggregate reports become a shadow-IT inventory. You will find marketing sending from a SaaS nobody told IT about, sales using a third-party scheduler that signs as you, and an old AWS SES configuration from a project that ended two years ago.
- Never promise leadership "we have DMARC, we can't be phished." DMARC defends one specific attack: exact-domain spoofing of authenticated channels. The user clicking the lookalike-domain link doesn't care that your DMARC record exists.
- L1 triages the phish report. L2 pulls the headers and DMARC verdict. IR opens a case if internal account compromise is suspected. Legal and comms get the call if customer-facing fraud is confirmed.

*The DMARC report is not a defense — it's a confession. Every line in the XML is somebody sending as you, legitimately or not. Read it.*

## Related concepts

[[SPF]] · [[DKIM]] · [[Email header analysis]] · [[Phishing]] · [[Business Email Compromise]] · [[Impersonation]] · [[DNS]] · [[WHOIS]] · [[VirusTotal]] · [[AbuseIPDB]] · [[Email gateway]] · [[Indicators of Compromise]] · [[XML]] · [[JSON]]

*Source: VIRGIL knowledge base — 2026-05-11*