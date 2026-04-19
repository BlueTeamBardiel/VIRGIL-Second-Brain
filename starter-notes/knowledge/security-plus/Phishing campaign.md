---
domain: "attack"
tags: [phishing, social-engineering, email-security, credential-theft, cyber-threats, awareness]
---
# Phishing campaign

A **phishing campaign** is a coordinated **social engineering attack** in which threat actors send fraudulent communications — most commonly email — designed to deceive recipients into revealing sensitive information, installing [[malware]], or performing actions that compromise security. The term derives from "fishing," reflecting how attackers cast wide nets hoping targets will "take the bait." Phishing is the foundational layer beneath many major breaches and is closely related to [[credential harvesting]], [[business email compromise (BEC)]], and [[ransomware]] delivery.

---

## Overview

Phishing campaigns are among the most prevalent and cost-effective attack vectors available to adversaries, ranging from unsophisticated mass-blast operations to highly targeted, intelligence-driven attacks. According to the Verizon Data Breach Investigations Report (DBIR), phishing consistently appears as one of the top initial access techniques across all industry sectors. The fundamental principle exploits human psychology — urgency, authority, fear, curiosity, or greed — rather than purely technical vulnerabilities, making it effective regardless of how robust an organization's technical defenses are.

Campaigns exist on a spectrum of sophistication. At the lowest end, bulk phishing (sometimes called "spray and pray") sends millions of generic messages — fake bank alerts, package delivery notifications, password reset prompts — relying on statistical probability to ensnare victims. At the highest end, **spear phishing** targets specific individuals using personalized information gathered from OSINT sources like LinkedIn, corporate websites, and social media. **Whaling** is spear phishing aimed specifically at senior executives. **Vishing** (voice phishing) and **smishing** (SMS phishing) extend the same deception into telephone and text message channels.

The infrastructure supporting a phishing campaign typically involves registered lookalike domains, cloned websites, phishing kits (pre-packaged HTML/PHP credential-harvesting pages), email delivery infrastructure (often abused legitimate services or bulletproof hosting), and command-and-control (C2) servers to receive stolen data. Adversaries frequently abuse legitimate cloud services — Google Forms, Microsoft SharePoint, Dropbox — to host malicious content, leveraging their trusted reputations to bypass reputation-based filters.

Notable real-world examples include the 2016 Podesta email breach (spear phishing via a fake Google security alert), the 2020 Twitter Bitcoin scam (insider-assisted vishing), and the 2021 Colonial Pipeline ransomware attack, where initial access was traced to compromised credentials — likely obtained through phishing. The FBI's IC3 reports that phishing and related frauds cause billions of dollars in losses annually, making it the single most reported cybercrime category.

From an adversarial perspective, phishing maps to MITRE ATT&CK under **T1566 — Phishing**, with sub-techniques including T1566.001 (Spearphishing Attachment), T1566.002 (Spearphishing Link), and T1566.003 (Spearphishing via Service). Understanding this taxonomy is essential for defenders implementing detection and response playbooks.

---

## How It Works

### Phase 1: Reconnaissance

Attackers gather target information using OSINT tools before constructing believable lures:

```bash
# theHarvester — collect emails, domains, subdomains from public sources
theHarvester -d targetcorp.com -b google,linkedin,bing -l 500

# recon-ng — modular OSINT framework
recon-ng
> marketplace install all
> modules load recon/domains-contacts/whois_pocs
> options set SOURCE targetcorp.com
> run
```

Tools used: **Maltego**, **Hunter.io**, **LinkedIn scraping**, **Shodan**, **WHOIS**, **Google Dorks**.

### Phase 2: Infrastructure Setup

Attackers register lookalike domains and configure delivery infrastructure:

- **Typosquatting examples**: `paypa1.com`, `target-corp.com`, `secure-bankofamerica.com`
- **Homograph attacks**: Using Unicode characters that visually resemble ASCII (е = Cyrillic е vs. Latin e)
- **Subdomain abuse**: `login.microsoft.com.phisherdomain.com` (the legitimate-looking part is a subdomain)

```bash
# Configure a malicious MX record and SPF to make outbound mail appear legitimate
# DNS zone file entry (attacker-controlled domain)
@   IN  MX  10 mail.evilcorp.com.
@   IN  TXT "v=spf1 ip4:203.0.113.5 ~all"

# Using Gophish (open-source phishing framework) — legitimate red team tool
# Start Gophish server
./gophish
# Access admin panel at https://localhost:3333
# Default credentials: admin / gophish (change immediately in lab)
```

### Phase 3: Phishing Kit Deployment

A **phishing kit** is a ZIP archive containing cloned HTML, CSS, JS, and PHP scripts that capture submitted credentials and forward them to the attacker:

```php
<?php
// Simplified example of credential capture script (for lab/educational purposes)
$username = $_POST['username'];
$password = $_POST['password'];
$ip       = $_SERVER['REMOTE_ADDR'];
$timestamp = date('Y-m-d H:i:s');

// Log to file
file_put_contents('logs.txt', "$timestamp | $ip | $username | $password\n", FILE_APPEND);

// Redirect victim to legitimate site to avoid suspicion
header('Location: https://legitimate-site.com/login-error');
exit();
?>
```

The kit is deployed to a compromised or rented web server, often behind a reverse proxy (Nginx/Apache) with a valid TLS certificate obtained via Let's Encrypt — giving the site a padlock icon that many users mistakenly equate with legitimacy.

### Phase 4: Email Delivery

Attackers craft emails to maximize deliverability and click-through rates:

```
From: IT Security <security-alerts@secure-targetcorp.com>
To: john.doe@targetcorp.com
Subject: URGENT: Unusual sign-in activity detected on your account

Dear John,

We have detected an unusual sign-in to your Microsoft 365 account from:
  Location: Kyiv, Ukraine
  IP: 185.220.101.47
  Time: 2024-01-15 03:22 UTC

If this was not you, please verify your identity immediately:
[SECURE YOUR ACCOUNT NOW]  <-- hyperlink to phishing page

This link expires in 2 hours.

IT Security Team
TargetCorp Inc.
```

**Technical delivery mechanisms:**
- **SMTP relay abuse**: Compromised SMTP servers or purchased mailing list services
- **Legitimate service relay**: Sending via SendGrid, Mailchimp (abusing free tiers)
- **Open relay exploitation**: Port 25 SMTP servers without authentication
- **Thread hijacking** (used in Emotet campaigns): Injecting replies into legitimate email threads

### Phase 5: Payload Delivery or Credential Capture

Two primary objectives after the victim clicks:

1. **Credential harvesting**: Victim enters username/password on cloned site; data exfiltrated via HTTP POST or email
2. **Malware delivery**: Attachment executes (macro-enabled Office doc, LNK file, ISO containing executable) — establishes foothold for [[lateral movement]]

```
# Common malicious attachment types
.docm / .xlsm   — VBA macro-enabled Office documents
.lnk            — Windows shortcut executing PowerShell
.iso / .img     — Disk image bypassing Mark of the Web (MOTW)
.html           — HTML smuggling (encodes payload in base64 decoded by browser JS)
.pdf            — Embedded JavaScript or links
.zip → .exe     — Archive containing renamed executable
```

### Phase 6: Exfiltration and Persistence

Stolen credentials are immediately tested against real services (credential stuffing) and sold on dark web markets, or used to establish persistence within the target environment.

---

## Key Concepts

- **Spear Phishing**: A targeted variant of phishing that uses personally identifiable or contextually relevant information about the victim — their name, employer, colleagues, or recent activities — to dramatically increase the credibility of the lure. Spear phishing has a far higher success rate than generic bulk campaigns.

- **Pretexting**: The creation of a fabricated scenario (pretext) to justify the request being made of the victim — e.g., impersonating IT support, a vendor, or a government agency. Pretexting provides the narrative framework within which phishing lures are embedded.

- **Phishing Kit**: A pre-packaged set of web files (HTML, CSS, JavaScript, PHP) that clones a legitimate website's login page and captures credentials submitted by victims. Kits are sold or shared on dark web forums and can be deployed in minutes, lowering the technical barrier to launching campaigns.

- **Typosquatting / Lookalike Domain**: The registration of a domain name visually or phonetically similar to a trusted brand (e.g., `arnazon.com`, `paypa1.com`, `rnicrosoft.com`) intended to deceive users who either misread the domain or are directed there by a phishing link.

- **Adversary-in-the-Middle (AiTM) Phishing**: A sophisticated technique where the phishing page acts as a reverse proxy between the victim and the legitimate service. The attacker captures session cookies in real-time, bypassing multi-factor authentication. Frameworks like **Evilginx2** and **Modlishka** implement this technique.

- **HTML Smuggling**: A technique where malicious payloads are encoded within an HTML file using JavaScript Blob objects. When the victim opens the attachment in a browser, the JavaScript assembles and downloads the payload locally, bypassing network-based inspection that never sees the assembled file.

- **Vishing / Smishing**: Extensions of phishing into voice (vishing) and SMS (smishing) channels. Vishing often involves impersonating bank fraud departments or technical support. Smishing exploits the higher trust users place in text messages and the difficulty of inspecting links on mobile screens.

---

## Exam Relevance

**SY0-701 Domain Mapping**: Phishing falls primarily under **Domain 2.0 — Threats, Vulnerabilities, and Mitigations** (2.2: Explain common threat vectors and attack surfaces; 2.4: Given a scenario, analyze indicators of malicious activity).

**Common question patterns:**

- **Identify attack type from scenario**: If a question describes an email sent to a CEO impersonating the CFO requesting a wire transfer → **whaling** or **BEC**. If it's a mass email with generic content → **phishing**. Targeted with personal details → **spear phishing**.
- **Distinguish phishing variants**: Know the differences: phishing (bulk/generic), spear phishing (targeted individual), whaling (C-suite target), vishing (voice), smishing (SMS), pharming (DNS poisoning redirecting legitimate URLs).
- **Identify the vector, not just the method**: Questions may describe consequences (user entered credentials on fake site) and ask you to identify the initial attack vector — answer: phishing.
- **Defensive control questions**: "What BEST prevents phishing emails from reaching users?" → **Email filtering / Secure Email Gateway (SEG)** + **DMARC/DKIM/SPF**. "What trains users to identify phishing?" → **Security awareness training** + **simulated phishing exercises**.

**Gotchas:**
- **Pharming ≠ Phishing**: Pharming involves DNS cache poisoning or hosts file modification to redirect legitimate URLs — no deceptive link required. Students confuse these on exams.
- **Vishing uses no email**: Vishing is conducted entirely by phone. A question describing a phone call from "IT support" requesting a password is vishing, not phishing.
- **HTTPS padlock does NOT mean safe**: The exam may test that TLS/HTTPS only means the connection is encrypted, not that the site is legitimate. Phishing sites routinely have valid TLS certificates.
- **MFA is not a complete defense against AiTM**: The exam increasingly references that even MFA can be bypassed by session hijacking techniques in advanced phishing scenarios.

---

## Security Implications

### Attack Surface

The human element is the primary attack surface. No firewall or IDS directly prevents a determined user from entering their credentials on a convincing phishing page. Organizations with poor security culture, inadequate email filtering, and no MFA are particularly vulnerable.

### Notable Incidents and CVEs

- **2016 DNC / Podesta Breach (APT28 / Fancy Bear)**: A spear phishing email impersonating a Google security alert tricked John Podesta's aide into clicking a credential-harvesting link. The resulting Gmail account compromise had significant geopolitical consequences. No CVE, but illustrates the real-world impact of a single click.

- **2020 SolarWinds (initial access via phishing)**: While the primary SolarWinds compromise involved supply chain attacks, initial network access in several victim organizations was attributed to phishing campaigns delivering [[Cobalt Strike]] beacons.

- **Operation Phish Phry (2009)**: FBI operation targeting 100 individuals in the US and Egypt for stealing over $1.5 million via banking phishing campaigns — one of the largest cybercrime prosecutions at the time.

- **2021 Ubiquiti Breach**: BEC/social engineering attack where an insider-assisted scenario led to the theft of $46.7 million via fraudulent wire transfer requests — a real-world whaling/BEC phishing outcome.

- **CVE-2021-40444 (MSHTML Remote Code Execution)**: Exploited via malicious Office documents delivered by phishing campaigns; allowed code execution without macros being enabled, complicating traditional defenses.

- **AiTM Phishing Campaigns (2022–2024, Microsoft Threat Intelligence)**: Large-scale campaigns using Evilginx2-based infrastructure to bypass MFA on Microsoft 365 accounts, compromising over 10,000 organizations in documented incidents. Tracked under threat actor cluster **Storm-1167**.

### Detection Indicators

- Emails with mismatched `From:` display name vs. actual sending address
- URLs containing brand names as subdomains of unfamiliar TLDs
- Recently registered domains (< 30 days old)
- SPF/DKIM/DMARC failures on inbound email
- Unusual login events following email delivery (impossible travel, new device, new IP)
- HTTP POST requests to unknown external hosts from internal workstations shortly after an email is opened

---

## Defensive Measures

### Email Authentication (Technical Controls)

Configure **SPF**, **DKIM**, and **DMARC** on all organizational domains — these are the three pillars of email sender authentication:

```dns
; SPF Record — specifies authorized sending IPs
targetcorp.com.  IN  TXT  "v=spf1 include:_spf.google.com ip4:203.0.113.10 -all"

; DMARC Record — policy for handling failures
_dmarc.targetcorp.com.  IN  TXT  "v=DMARC1; p=reject; rua=mailto:dmarc-reports@targetcorp.com; ruf=mailto:forensics@targetcorp.com; pct=100"

; DKIM is configured in your mail server (e.g., Postfix + OpenDKIM)
; Publish public key as DNS TXT record:
mail._domainkey.targetcorp.com.  IN  TXT  "v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA..."
```

**Policy**: Set DMARC to `p=reject` (not just `p=none` or `p=quarantine`) to actively block spoofed emails. Begin with `p=none` to collect reports, then escalate.

### Secure Email Gateway (SEG)

Deploy a commercial or open-source SEG to filter malicious content:
- **Commercial**: Proofpoint, Mimecast, Microsoft Defender for Office 365, Cisco Secure Email
- **Open-source**: rspamd, SpamAssassin (less capable but usable in homelabs)

Configure:
- URL rewriting and sandboxed link following (time-of-click protection)
- Attachment sandboxing (detonate suspicious files in isolated environment)
- Impersonation protection (flag emails claiming to be from executives)
- Block macros in Office attachments from external senders

### Multi-Factor Authentication (MFA)

Deploy MFA universally, prioritizing: