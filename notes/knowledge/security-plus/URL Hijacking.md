---
domain: "attack-techniques"
tags: [url-hijacking, social-engineering, phishing, domain-abuse, web-security, typosquatting]
---
# URL Hijacking

**URL hijacking** (also called **typosquatting** or **brandjacking**) is an attack technique where a threat actor registers domain names that closely resemble legitimate URLs, exploiting typographical errors, character substitutions, or confusable Unicode glyphs to intercept users who mistype or misread a web address. The attack preys on human error and visual similarity rather than technical exploitation of a target system, making it a form of [[Social Engineering]] with significant implications for [[Phishing]] and credential theft. By controlling a lookalike domain, attackers redirect victims to malicious infrastructure without ever compromising the legitimate site.

---
## Overview

URL hijacking sits at the intersection of domain registration abuse, social engineering, and web fraud. Unlike vulnerabilities that require exploiting code, URL hijacking exploits the gap between what a user *intends* to visit and what they *actually* type or click. The attack surface is enormous: every popular brand, banking institution, government portal, and software vendor represents a target. Registering a domain costs as little as $0.99/year, meaning the barrier to entry for this attack is extraordinarily low compared to the potential reward.

The technique has existed since the early commercial internet. One of the first documented examples was the registration of `whitehouse.com` (a pornography site) alongside the government's legitimate `whitehouse.gov`, exploiting users who guessed the wrong top-level domain. As internet use expanded globally, typosquatting evolved to encompass homograph attacks (using visually identical Unicode characters), combosquatting (appending words like `-login`, `-secure`, or `-support` to brand names), and soundsquatting (registering domains that sound phonetically similar to legitimate ones).

Attackers use hijacked URLs for several distinct purposes. The most common is **credential harvesting**: the fake site mirrors the legitimate login page of a bank, email provider, or corporate VPN, capturing usernames and passwords. Others monetize traffic through **pay-per-click advertising**, redirecting the mistaken user to ad-laden pages and earning revenue. Some hijacked domains distribute **malware**, automatically pushing drive-by download exploits when the user lands on the page. A smaller subset engages in **corporate espionage**, registering internal-sounding domains (e.g., `corp-intranet-login.com`) to intercept employee credentials.

The scale of the problem is measurable. A 2020 study by researchers at Palo Alto Networks identified over 13,000 active typosquatting domains targeting the top 500 Alexa sites. During the COVID-19 pandemic, thousands of domains mimicking health agencies (WHO, CDC) and vaccine information portals were registered within days of major announcements — the majority were immediately weaponized for phishing or malware delivery. The ICANN Uniform Domain-Name Dispute-Resolution Policy (UDRP) provides a legal recourse mechanism, but enforcement is slow and international jurisdiction issues frequently impede takedowns.

Beyond individual users, URL hijacking poses supply chain risks. Package managers like npm and PyPI have been targeted through **dependency confusion** and **typosquatting of package names**, where developers mistype a package name and inadvertently install a malicious substitute. The 2021 `colourama` package (a typosquat of `colorama` on PyPI) installed a cryptocurrency clipboard hijacker on developer machines, illustrating how the attack extends beyond web browsers into software development toolchains.

---
## How It Works

### Phase 1: Target Reconnaissance

The attacker selects a high-value target domain — typically one with millions of daily visitors or one associated with financial transactions or credential entry. They analyze the target's name for common typographic error patterns.

```
Target: www.bankofamerica.com

Candidate typosquats:
  bankofamerica.com     → bankofamercia.com   (transposition: r/c swap)
  bankofamerica.com     → bankofarnerica.com  (substitution: m → rn)
  bankofamerica.com     → bankofamerica.net   (TLD confusion)
  bankofamerica.com     → bank0famerica.com   (numeral substitution: o → 0)
  bankofamerica.com     → bankofamerica-login.com  (combosquatting)
```

### Phase 2: Domain Registration

The attacker registers one or more of the identified domains through any ICANN-accredited registrar. Registration is often done through privacy protection services (WHOIS masking) to conceal attacker identity. Tools like `dnstwist` can automate the enumeration of candidate domains:

```bash
# Install dnstwist
pip install dnstwist

# Generate typosquat candidates for a target domain
dnstwist --registered bankofamerica.com

# Output includes:
# original       bankofamerica.com         1.2.3.4
# addition       bankofamericas.com        5.6.7.8   REGISTERED
# transposition  bankofamreica.com         --
# homoglyph      bankofаmerica.com         9.10.11.12 REGISTERED (Cyrillic 'а')
# subdomain      www.bankofamerica.com.attacker.net
```

### Phase 3: Infrastructure Setup

Once the domain is registered, the attacker configures web hosting:

1. **Clone the target website** using `wget` or `HTTrack` to mirror the legitimate site's HTML, CSS, and JavaScript
2. **Modify form action URLs** to POST credentials to the attacker's collection server
3. **Configure TLS certificates** using free services like Let's Encrypt — the padlock icon no longer implies legitimacy
4. **Set up credential logging** with a PHP or Python backend

```php
<?php
// Attacker's credential harvester (example for educational awareness)
// Logs POST data and redirects victim to real site
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $log_entry = date('Y-m-d H:i:s') . ' | ' . 
                 'User: ' . $_POST['username'] . ' | ' .
                 'Pass: ' . $_POST['password'] . ' | ' .
                 'IP: ' . $_SERVER['REMOTE_ADDR'] . "\n";
    file_put_contents('/var/log/harvest.txt', $log_entry, FILE_APPEND);
    // Redirect victim to real site to avoid suspicion
    header('Location: https://www.legitsite.com/login?error=1');
    exit();
}
?>
```

4. **Configure MX records** if the goal includes email interception — receiving emails misdirected to the typosquatted domain by employees or partners who mistype the organization's email domain.

### Phase 4: Traffic Delivery

The attacker drives traffic via:
- **Organic mistyping**: simply waiting for users to make errors
- **Phishing emails**: embedding the typosquat URL in convincing messages
- **SEO poisoning**: optimizing the fake site to rank in search results for brand queries
- **Ad network abuse**: buying keyword ads that appear above the legitimate site in search results

### Phase 5: Homograph Attacks (IDN Homograph)

Internationalized Domain Names (IDN) allow Unicode characters in domain names. Some Unicode characters are visually indistinguishable from ASCII:

```
Legitimate:  apple.com          (Latin 'a' U+0061)
Attack:      аpple.com          (Cyrillic 'а' U+0430)

Browser display: Both appear as "apple.com" in many fonts
Punycode form of attack domain: xn--pple-43d.com
```

Modern browsers display the Punycode representation if a domain mixes scripts, but single-script homograph attacks against non-ASCII TLDs remain effective.

---
## Key Concepts

- **Typosquatting**: The core technique of registering misspelled variants of legitimate domain names, exploiting predictable human typing errors such as transpositions (`teh` → `the`), omissions, doublings, and adjacent-key substitutions based on keyboard layout.
- **Combosquatting**: A variant where attackers append or prepend common words to a legitimate brand name — `paypal-secure.com`, `microsoft-support.net`, `amazon-login.co` — to create a plausible-sounding URL that users may not recognize as illegitimate.
- **IDN Homograph Attack**: Exploitation of Unicode's Internationalized Domain Names standard, where characters from non-Latin scripts (Cyrillic, Greek, Armenian) that are visually identical to Latin letters are used to register domains indistinguishable to the human eye.
- **Brandjacking**: The broader category encompassing all forms of impersonating a brand's online identity, including URL hijacking, social media account impersonation, and fake mobile apps — used to steal customer trust and divert commercial activity.
- **Soundsquatting**: A lesser-known variant exploiting homophones and text-to-speech patterns, where domains phonetically similar to the target (`flickr.com` → `flicker.com`) are registered, primarily targeting voice-driven navigation and users who hear URLs rather than read them.
- **Dependency Confusion / Package Typosquatting**: Extension of URL hijacking into software supply chains, where malicious packages with names similar to popular libraries are published on public registries (npm, PyPI, RubyGems), targeting developers who mistype package names in install commands.
- **Doppelganger Domain**: A domain that is identical to a legitimate internal or external domain but uses a different TLD or adds a subdomain prefix — particularly dangerous for corporate environments where `corp.company.com` versus `corp-company.com` differences are subtle.

---
## Exam Relevance

**SY0-701 Domain Mapping**: URL hijacking appears under **Domain 2.0 (Threats, Vulnerabilities, and Mitigations)**, specifically under social engineering techniques and indicators of malicious activity. It also intersects with **Domain 4.0 (Security Operations)** when discussing URL filtering and DNS-based controls.

**Common Question Patterns**:
- Questions will present a scenario where a user receives an email with a link to `arnazon.com` or `paypa1.com` and ask you to identify the attack type — the answer is **typosquatting** or **URL hijacking**.
- You may be asked to distinguish URL hijacking from **DNS hijacking** (which modifies DNS records on legitimate infrastructure) — URL hijacking uses *registered lookalike domains*, while DNS hijacking corrupts *legitimate DNS resolution*.
- Expect scenario questions asking which control prevents users from accessing typosquatted domains: the answer is **DNS filtering / URL filtering** (e.g., Cisco Umbrella, Pi-hole with blocklists) combined with **security awareness training**.

**Gotchas**:
- Do not confuse **URL hijacking** with **clickjacking** (UI redress attacks using iframes) — they are distinct attack types despite both involving deceptive URLs/interfaces.
- A TLS padlock on a typosquatted site does NOT make it legitimate. The cert only proves the domain owns the certificate, not that the domain is trustworthy. This is a common exam distractor.
- **Homograph attacks** may be presented as a separate concept — know that they are a *subcategory* of URL hijacking using Unicode characters.
- The SY0-701 exam may present URL hijacking as a precursor to **credential harvesting** — recognize the kill chain relationship.

---
## Security Implications

### Attack Vectors and Impact

URL hijacking enables a broad range of downstream attacks. Credential theft is the most direct: users who enter login details into a mirrored phishing page hand over credentials without any malware being delivered to their machine — bypassing endpoint detection entirely. These credentials are then used in **account takeover (ATO)** attacks, sold on dark web markets, or leveraged for business email compromise (BEC).

### Real-World Incidents

**PayPal typosquatting (ongoing)**: Security researchers have consistently documented hundreds of active domains targeting PayPal users. Domains like `paypa1.com`, `paypai.com`, and `paypal-secure.com` have been used to harvest financial credentials at scale.

**2020 U.S. Election Typosquatting Campaign**: A report by DomainTools identified over 550 election-related typosquatting domains registered in the months before the 2020 U.S. election, targeting voter information sites and campaign donation pages.

**npm Package Typosquatting (CVE context)**: The `crossenv` package (typosquat of `cross-env`) was discovered in 2017 to steal environment variables — including cloud credentials and API keys — from the build environments of developers who mistyped the package name. This prompted npm to implement automated typosquatting detection.

**Operation Cobalt Kitty**: The APT group OceanLotus registered doppelganger domains mimicking internal corporate domains of their targets, successfully intercepting email traffic and credentials from employees who sent mail to the wrong domain.

### Detection Indicators

- WHOIS records showing recently registered domains with privacy protection enabled
- Domains with low Alexa rank but high SSL certificate issuance volume
- DNS queries from internal hosts to newly-seen external domains (detectable via DNS logging)
- Browser security warnings for IDN Punycode rendering
- Certificate Transparency logs showing new certs for brand-similar domains

---
## Defensive Measures

### For Organizations

**1. Proactive Domain Registration (Defensive Registration)**
Register common typosquats of your own domain before attackers do. This is standard practice for major brands. Tools like `dnstwist` help enumerate candidates:
```bash
dnstwist --format csv yourdomain.com > typosquats.csv
# Review and register high-risk variants through your registrar
```

**2. DNS/URL Filtering**
Deploy DNS filtering solutions that maintain blocklists of known malicious and typosquatted domains:
- **Cisco Umbrella** — cloud-based DNS security with ML-driven threat categorization
- **Pi-hole + threat intelligence feeds** (homelab-appropriate)
- **Quad9 (9.9.9.9)** — free recursive DNS with malicious domain blocking built-in

**3. Certificate Transparency Monitoring**
Monitor CT logs for certificates issued to domains similar to your brand:
```bash
# Using certstream to watch CT logs in real time
pip install certstream
certstream --full | grep -i "yourbrand"

# Alternative: use Facebook's Certificate Transparency Monitoring tool
# https://developers.facebook.com/tools/ct/
```

**4. DMARC, DKIM, and SPF**
Configure email authentication to prevent attackers from using lookalike domains to send phishing emails that appear to originate from your organization:
```
# SPF record example
yourdomain.com. TXT "v=spf1 include:_spf.google.com ~all"

# DMARC record (reject policy)
_dmarc.yourdomain.com. TXT "v=DMARC1; p=reject; rua=mailto:dmarc@yourdomain.com"
```

**5. Security Awareness Training**
Train users to:
- Hover over links before clicking to inspect the actual URL
- Use bookmarks for frequently visited sensitive sites rather than typing URLs
- Recognize that HTTPS/padlock does not equal legitimate
- Be suspicious of login pages reached via email links regardless of URL appearance

**6. Browser Extensions and Endpoint Controls**
- Deploy browser extensions like **Netcraft Extension** or corporate web proxies that flag newly registered domains
- Configure endpoint DNS settings to use filtered resolvers
- Implement **Web Application Firewalls** and inline URL inspection on corporate proxies

**7. UDRP / Legal Action**
For confirmed cases of malicious typosquatting targeting your brand, file a UDRP complaint with ICANN or pursue action under the **Anti-Cybersquatting Consumer Protection Act (ACPA)** in U.S. jurisdiction.

---
## Lab / Hands-On

### Exercise 1: Enumerate Typosquat Candidates with dnstwist

```bash
# Install on Kali or Ubuntu
sudo apt install dnstwist
# OR
pip3 install dnstwist

# Run against a target (use your own lab domain)
dnstwist --registered --threads 8 --format json lab.local > results.json

# Check for registered domains in output
dnstwist example.com | grep -E "REGISTERED|MX|A "

# Fuzzing modes available:
# addition, subtraction, transposition, replacement,
# homoglyph, hyphenation, subdomain, various TLDs
```

### Exercise 2: Inspect