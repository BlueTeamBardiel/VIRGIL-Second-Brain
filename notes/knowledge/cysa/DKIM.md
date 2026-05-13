# DKIM — DomainKeys Identified Mail

## What it is

In **Hitman**, Agent 47 walks into Sapienza wearing a stolen lab coat with a cloned ID badge. The guards check the badge against their list — and let him into the bioweapon lab. The badge is real. The man wearing it isn't. Now imagine the same scene, but the badge has a tamper-evident seal that can only be produced by ICA's printer, and every guard carries a UV light that verifies that seal in two seconds. 47 doesn't get in. The disguise doesn't matter — the signature doesn't match.

That's DKIM. Plain English: it's a cryptographic signature stamped into every outbound email by the sending domain's mail server, which receiving mail servers verify against a public key published in DNS. If the signature checks out, the message hasn't been tampered with in transit and the sending domain is genuinely the one it claims to be.

Technical definition: **DomainKeys Identified Mail (DKIM)** is an email authentication standard (RFC 6376) that uses asymmetric cryptography to let a domain take responsibility for a message. The sending MTA signs selected header fields and the message body with a private key. The signature is inserted as a `DKIM-Signature:` header. The receiving MTA fetches the matching public key from `<selector>._domainkey.<domain>` via DNS TXT record, recomputes the hash, and verifies the signature. Pass, fail, or none — that result is then fed to [[DMARC]] for the policy decision.

DKIM is one of the three email authentication legs — [[SPF]] proves the sending IP is authorized, DKIM proves the message wasn't tampered with and the domain owns it, [[DMARC]] tells the receiver what to do when SPF or DKIM fails and provides reporting.

## Why it matters

Email is the front door for [[phishing]], business email compromise, and most initial-access [[social engineering]]. A SOC analyst staring at a "suspicious email" ticket spends the first ninety seconds in the headers — and the DKIM result is the load-bearing field. A `dkim=pass` from the real domain with a matching `From:` rules out most spoofing instantly. A `dkim=fail` or `dkim=none` on a payroll-change request is your cue to call the user before the wire goes out.

CS0-003 lives this in **Objective 1.3** — email analysis under "Common techniques" for determining malicious activity. CompTIA expects you to read a raw email header, identify the DKIM signature, interpret the result, and pair it with SPF and DMARC to reach a conclusion. Header analysis is a guaranteed performance-based question style.

Career-wise: every Tier 1 SOC role that touches the email queue lives in DKIM/SPF/DMARC results. If you can't read them, you're guessing.

## Key facts

### How the signature is built

The sending MTA performs these steps:

1. Canonicalize the headers and body (normalize whitespace, line endings) per the chosen canonicalization algorithm — `simple` or `relaxed`.
2. Hash the canonicalized body (SHA-256 typically).
3. Select the headers to sign (always `From:`, usually `Subject:`, `Date:`, `To:`, `Message-ID:`).
4. Sign the hash with the domain's private RSA or Ed25519 key.
5. Insert the result as a `DKIM-Signature:` header.

The receiver reverses it: fetch the public key from DNS, decrypt the signature, recompute both hashes, compare. Any single bit changed in transit — by a malicious relay or a well-meaning mailing list that rewrote the subject line — breaks the signature.

### The DKIM-Signature header — tag by tag

```
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
    d=paypal.com; s=pp-dkim1; t=1715472000;
    h=from:to:subject:date:message-id;
    bh=Lj8s9...=; b=Hk2dF...=
```

| Tag | Meaning | Why it matters |
|-----|---------|----------------|
| `v=` | Version (always 1) | Sanity check |
| `a=` | Algorithm (`rsa-sha256`, `ed25519-sha256`) | `rsa-sha1` is deprecated and a finding |
| `c=` | Canonicalization (header/body) | Tampering tolerance |
| `d=` | **Signing domain** | The domain *taking responsibility* — compare to `From:` |
| `s=` | Selector | DNS lookup prefix |
| `h=` | Headers signed | If `From:` isn't here, the signature means nothing |
| `bh=` | Body hash | Body integrity |
| `b=` | Signature | The actual crypto |

**The `d=` tag is the one CompTIA will ask about.** A message can have a valid DKIM signature where `d=` is `mailer-relay-cheap.ru` and the `From:` is `ceo@yourcompany.com`. DKIM passes. The user gets phished anyway. That's why **DMARC alignment** exists — it requires `d=` to match the `From:` domain.

### The DNS side

The public key lives at a TXT record: `<selector>._domainkey.<domain>`.

```
pp-dkim1._domainkey.paypal.com.  IN TXT  "v=DKIM1; k=rsa; p=MIIBIjANBg..."
```

You can pull this in seconds:

```bash
dig +short TXT pp-dkim1._domainkey.paypal.com
nslookup -type=TXT pp-dkim1._domainkey.paypal.com
```

In PowerShell:

```powershell
Resolve-DnsName -Type TXT -Name "selector1._domainkey.contoso.com"
```

If the TXT record is missing, the receiver returns `dkim=permerror` or `dkim=none`. If the key is present but the signature math fails, `dkim=fail`.

### DKIM results in Authentication-Results

The receiving MTA writes the verdict into the `Authentication-Results:` header — this is what you read in triage:

```
Authentication-Results: mx.google.com;
    spf=pass smtp.mailfrom=paypal.com;
    dkim=pass header.d=paypal.com header.s=pp-dkim1;
    dmarc=pass (p=REJECT) header.from=paypal.com
```

| Result | What happened |
|--------|---------------|
| `dkim=pass` | Signature valid, body intact, domain owns it |
| `dkim=fail` | Signature present but invalid — tampered or wrong key |
| `dkim=none` | No DKIM signature on the message |
| `dkim=permerror` | DNS record malformed or missing |
| `dkim=temperror` | DNS lookup failed temporarily |

`dkim=none` is not the same as `dkim=fail`. A message with no signature can't be tampered with by definition — there's nothing to tamper. CompTIA loves this distinction.

### DKIM vs SPF vs DMARC — the three legs

| Control | Proves | Mechanism | Breaks on |
|---------|--------|-----------|-----------|
| [[SPF]] | Sending IP is authorized for the envelope-from domain | DNS TXT listing authorized IPs | Forwarding |
| **DKIM** | Message body and signed headers are intact; signing domain owns the signature | Asymmetric crypto + DNS public key | Body modification, signature stripping |
| [[DMARC]] | `From:` domain alignment with SPF or DKIM, plus policy | DNS TXT with `p=none/quarantine/reject` + reporting | Misconfiguration |

You need all three. SPF dies on forwarding. DKIM survives forwarding but dies on body modification (mailing list footers). DMARC ties them together and tells receivers what to do on failure — and just as importantly, sends you the **DMARC aggregate reports** (`rua=`) in XML format that show every source sending mail as your domain. Those reports are how you find the marketing-automation tool nobody told the security team about.

### CompTIA exam traps

> **CompTIA exam trap:** DKIM does NOT encrypt the message. It signs. The body is still plaintext on the wire. If the question asks about email confidentiality, the answer is S/MIME or PGP, not DKIM. DKIM = integrity + authenticity, not confidentiality.

> **CompTIA exam trap:** A `dkim=pass` does not mean the email is legitimate. It means the signing domain in `d=` validly signed the message. An attacker can register `paypa1-secure.com`, set up DKIM properly, and get `dkim=pass header.d=paypa1-secure.com`. The signature is real. The domain is the lookalike. Read the `d=` value, not just the verdict.

> **CompTIA exam trap:** DKIM alignment is a DMARC concept, not a DKIM concept. Vanilla DKIM only requires that `d=` matches a valid DNS key — it does not require `d=` to match the `From:` header. The alignment check is what DMARC layers on top.

### Hashing, signatures, and why this is in the "tools and techniques" objective

DKIM is a working example of the cryptographic primitives CS0-003 expects you to recognize in the wild: SHA-256 hashing for the body (`bh=`), asymmetric signing for authenticity (`b=`), and DNS as the public key distribution mechanism. When you `dig` a DKIM record, you're doing the same DNS reconnaissance you'd do with [[WHOIS]], [[AbuseIPDB]], or [[VirusTotal]] — pulling public infrastructure data to build context on a sender. The same regex skills you use to extract IoCs from logs apply here: grep the `Received:` chain, the `Return-Path:`, the `d=` value, the `Authentication-Results:` block.

## SOC reality

Reading email headers is a daily exercise. Here's what it actually looks like:

- **The ticket.** "User says they got a suspicious email about a payroll update." You pull the original message — most enterprise mail clients have a "View source" or "Show original" option — and paste it into a header analyzer or grep through it directly.

- **First three lines you read.** `Authentication-Results:` (SPF, DKIM, DMARC verdicts), `From:` (display name vs actual address), `Received:` chain (does the path make sense or did this come from a residential ISP in a country we don't do business with?).

- **The trap that hits new analysts.** `dkim=pass header.d=mailgun.org` on a message claiming to be from your CEO. DKIM passed — for Mailgun's domain. The attacker used a legitimate mass-mail service. Check alignment with `From:`. If they don't match, DMARC should have caught it; if DMARC is `p=none`, nobody caught it and the user did get the email.

- **What the IR lead asks.** "How many recipients? Did anyone click? Pull the URL through [[Joe Sandbox]] or [[Cuckoo]]. Get me the sending IP and the `d=` domain so I can block both at the gateway and submit to threat intel."

- **The handoff.** L1 confirms phish, blocks sender + URL at the secure email gateway, purges remaining copies from inboxes via the mail platform's search-and-delete (Microsoft's Content Search + Purge, Google's Investigation Tool). L2 / IR pulls EDR telemetry on anyone who clicked. Legal gets a heads-up if PII was in scope.

*The signature isn't the whole story. The `d=` value is. A pass verdict on the wrong domain is a phish that got promoted to "trusted" by your own headers.*

## Related concepts

[[SPF]] · [[DMARC]] · [[Email header analysis]] · [[Phishing]] · [[Business email compromise]] · [[Social engineering]] · [[DNS]] · [[WHOIS]] · [[VirusTotal]] · [[AbuseIPDB]] · [[Joe Sandbox]] · [[Cuckoo Sandbox]] · [[Hashing]] · [[Asymmetric cryptography]] · [[SIEM]] · [[Secure email gateway]] · [[SOAR]] · [[Indicators of compromise]]

*Source: VIRGIL knowledge base — 2026-05-11*