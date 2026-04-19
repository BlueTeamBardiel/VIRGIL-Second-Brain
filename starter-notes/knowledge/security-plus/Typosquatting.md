---
domain: "attack-techniques"
tags: [typosquatting, social-engineering, phishing, domain-hijacking, supply-chain, malware]
---
# Typosquatting

**Typosquatting** (also called **URL hijacking** or **brandjacking**) is a form of [[Social Engineering]] attack where adversaries register domain names that are deliberate misspellings, character substitutions, or phonetic equivalents of legitimate, high-traffic websites. The goal is to intercept users who make typographical errors when entering URLs, redirecting them to malicious content, credential-harvesting pages, or unwanted advertising. Typosquatting exploits the intersection of human error and the [[Domain Name System (DNS)]], and has expanded beyond web browsing into [[Package Manager Attacks]] targeting software dependency ecosystems.

---

## Overview

Typosquatting emerged in the late 1990s alongside the commercialization of the internet. As major brands established web presences, opportunists discovered that registering slightly misspelled domain names was trivially cheap and potentially lucrative. Early typosquatters primarily monetized traffic through advertising revenue, serving ads to confused visitors who had typed `gooogle.com` instead of `google.com`. The practice quickly evolved as threat actors recognized the potential for credential theft, malware distribution, and corporate espionage.

The economics of typosquatting are straightforward: generic top-level domain (gTLD) registrations cost as little as $0.99–$12 per year, while a single successful phishing operation against corporate employees can yield credentials worth thousands of dollars. Attackers can register hundreds of typo variants for a fraction of the cost of a single penetration test, making it an asymmetric and cost-effective attack strategy. Even major corporations with dedicated brand protection teams find it impossible to preemptively register every possible misspelling across all available TLDs.

Typosquatting has expanded dramatically beyond traditional web browsers. The **dependency confusion** and **combosquatting** variants now target software package ecosystems including PyPI (Python), npm (Node.js), RubyGems, and NuGet. In these contexts, a developer running `pip install reqeusts` instead of `pip install requests` might silently install a malicious package that exfiltrates environment variables, SSH keys, or cryptocurrency wallet files. The 2021 `ua-parser-js` npm package compromise and the 2022 `PyPI` malware campaigns demonstrated how effective this variant is against developer workflows.

Modern typosquatting operations are frequently sophisticated, multi-stage campaigns. Attackers perform reconnaissance against target organizations, identify key personnel and their browsing habits, purchase typo domains, configure them with SSL/TLS certificates (making them appear legitimate with the padlock icon), and deploy pixel-perfect clones of the target site. The entire infrastructure can be stood up in under an hour using cloud services and automated tooling, then torn down immediately after credential harvesting to evade detection and attribution.

Regulatory responses have been mixed. The **Anticybersquatting Consumer Protection Act (ACPA)** of 1999 in the United States provides legal remedies for trademark holders, and ICANN's **Uniform Domain-Name Dispute-Resolution Policy (UDRP)** offers an arbitration mechanism. However, these processes are slow, expensive, and largely ineffective against attackers operating from jurisdictions with weak IP enforcement. The result is an ongoing arms race between brand protection services and typosquatters.

---

## How It Works

### Attack Lifecycle

Typosquatting follows a consistent operational pattern regardless of whether it targets browser-based navigation or software package managers.

#### Phase 1: Target Selection and Reconnaissance

The attacker identifies a high-value target — a banking site, corporate VPN login portal, popular software package, or cloud provider console. They enumerate the target's traffic volume, brand recognition, and user demographics using tools like SimilarWeb or public DNS data.

```bash
# Enumerate DNS records of the target to understand infrastructure
dig +all example.com
dig MX example.com
dig NS example.com

# Use whois to identify registrar and registration patterns
whois example.com
```

#### Phase 2: Typo Variant Generation

The attacker generates a list of plausible typo variants using several mutation strategies:

**Common Mutation Types:**
1. **Character omission** — `gogle.com` (missing letter)
2. **Character transposition** — `googel.com` (swapped adjacent letters)
3. **Character duplication** — `gooogle.com` (repeated letter)
4. **Adjacent key substitution** — `foogle.com` (F is adjacent to G on QWERTY)
5. **Homoglyph/homograph substitution** — `goog1e.com` (numeral 1 replacing lowercase L)
6. **TLD substitution** — `example.org` instead of `example.com`
7. **Combosquatting** — `example-login.com`, `secure-example.com`
8. **Soundalike domains** — `eksample.com`
9. **Missing hyphen** — `my-bank.com` vs `mybank.com`

Automated tools generate these variants at scale:

```bash
# dnstwist: The standard tool for typosquatting domain generation
pip install dnstwist

# Generate variants for a target domain
dnstwist --registered example.com

# Output with DNS resolution, GeoIP, and MX records
dnstwist --registered --json --nameservers 8.8.8.8 example.com > variants.json

# Check for registered variants with MX records (indicates active mail use)
dnstwist --registered --mxcheck example.com
```

```bash
# URLCrazy: Alternative tool for typo variant generation
apt install urlcrazy
urlcrazy -p example.com
```

#### Phase 3: Domain Registration and Infrastructure Setup

```bash
# Batch registration via registrar APIs (example using namecheap API concept)
# Attackers use automation to register dozens of variants simultaneously

# Check availability of generated variants
for domain in $(cat variants.txt); do
    whois $domain | grep -q "No match" && echo "AVAILABLE: $domain"
done
```

After registration, attackers provision infrastructure:
- **SSL/TLS certificates** from Let's Encrypt (free, automated, legitimate-looking)
- **Web hosting** on cloud providers (AWS, DigitalOcean, Cloudflare Workers)
- **Pixel-perfect site clones** using `httrack` or `wget --mirror`
- **Credential capture backends** using tools like Gophish or custom PHP/Python

```bash
# Cloning a target website for a phishing page (for authorized red team testing only)
wget --mirror --convert-links --adjust-extension --page-requisites \
     --no-parent https://example.com -P ./cloned-site/

# Obtain a TLS certificate for the typo domain
certbot certonly --standalone -d typo-domain.com
```

#### Phase 4: Payload Delivery

Once a victim navigates to the typo domain:
- **Credential harvesting**: Form submissions captured and relayed to attacker
- **Drive-by download**: Malicious scripts exploit browser vulnerabilities
- **Watering hole**: Legitimate-looking page that injects malware into downloads
- **Package malware**: For PyPI/npm variants, malicious `setup.py` or `install` scripts execute on `pip install`

```python
# Example of malicious setup.py in a typosquatted package (illustrative)
# This type of code has appeared in real PyPI typosquatting incidents
import subprocess
import os

def exfiltrate():
    import socket
    import platform
    data = {
        'host': socket.gethostname(),
        'os': platform.system(),
        'user': os.getenv('USER', 'unknown'),
    }
    # Real attacks send this to attacker-controlled server
    pass

from setuptools import setup
exfiltrate()  # Executes at install time, before user runs any code

setup(name='reqeusts', version='2.28.0', ...)
```

#### Phase 5: Monetization or Escalation

Harvested credentials are used for account takeover, sold on dark web markets, or used as an entry point for lateral movement within a corporate network.

---

## Key Concepts

- **Combosquatting**: A typosquatting variant where legitimate brand names are combined with common words (`-login`, `-secure`, `-account`, `-verify`) to create convincing phishing domains. Studies have shown combosquatting domains are 100× more prevalent than traditional typosquatting and significantly more effective at deceiving users.

- **IDN Homograph Attack**: A sophisticated form of typosquatting exploiting **Internationalized Domain Names (IDN)**, where Unicode characters visually identical to ASCII letters (e.g., Cyrillic `а` U+0430 vs Latin `a` U+0061) are used to register domains that appear identical to the target in a browser address bar. The domain `аpple.com` using a Cyrillic 'а' is a different domain than `apple.com`.

- **Dependency Confusion (Namespace Confusion)**: A supply-chain variant discovered by researcher Alex Birsan in 2021, where a public package with the same name as an internal private package but a higher version number causes package managers to download the public (malicious) version instead of the internal one. This is distinct from simple typosquatting but shares the namespace exploitation model.

- **Brandjacking**: The broader category encompassing typosquatting, where an attacker appropriates a brand's identity — including domain names, social media handles, and app store listings — to deceive users or damage the brand's reputation.

- **ACPA (Anticybersquatting Consumer Protection Act)**: U.S. federal law (15 U.S.C. § 1125(d)) enacted in 1999 that allows trademark holders to sue typosquatters for statutory damages of $1,000–$100,000 per domain, plus attorney fees. Requires proving bad faith intent to profit from the trademark.

- **UDRP (Uniform Domain-Name Dispute-Resolution Policy)**: ICANN's administrative mechanism allowing trademark holders to challenge infringing domain registrations through arbitration bodies (WIPO, NAF). Faster and cheaper than litigation but limited to transfer or cancellation — no monetary damages.

- **Doppelganger Domain**: A specific typosquatting technique targeting subdomains, where attackers register the parent domain portion of a common internal subdomain. For example, if employees access `mail.company.com`, an attacker registers `mailcompany.com` to intercept mistyped URLs.

---

## Exam Relevance

### SY0-701 Domain Mapping
Typosquatting appears under **Domain 2.0: Threats, Vulnerabilities, and Mitigations** — specifically within social engineering techniques and URL-based attacks. It also surfaces in supply chain attack discussions.

### Common Question Patterns

**Scenario-type questions** typically present a situation like:
> *"A user reports receiving an email with a link to `paypa1.com`. The user clicks the link and enters their credentials. What type of attack occurred?"*
> **Answer: Typosquatting** (combined with phishing)

**Distinguishing questions** ask you to differentiate typosquatting from related concepts:
- **Typosquatting vs. Pharming**: Pharming redirects users from the *correct* URL via DNS poisoning or hosts file modification; typosquatting requires the user to type the *wrong* URL
- **Typosquatting vs. URL Hijacking**: URL hijacking is a synonym; both terms are acceptable
- **Typosquatting vs. Domain Hijacking**: Domain hijacking involves taking control of a *legitimate* domain's registration; typosquatting registers a *new* lookalike domain

### Key Gotchas
- The exam may refer to typosquatting as **"URL hijacking"** — treat them as identical
- Homograph/IDN attacks are a *subset* of typosquatting but may be called out separately
- Know that HTTPS/SSL on a typosquatted site does **not** make it legitimate — the padlock only means the connection is encrypted, not that the site is trustworthy
- Package-based typosquatting (PyPI, npm) is a **supply chain attack** vector, which is heavily tested in SY0-701

### Memory Aid
**"Type a wrong URL, reach the wrong place"** — The attack depends entirely on the victim making an error OR trusting a misleading link that navigates to the typo domain.

---

## Security Implications

### Attack Vectors and Impact

**Credential Theft**: Typosquatted banking, email, and corporate VPN login pages are among the most effective phishing vectors because they require no email-based lure — the victim self-navigates to the malicious site, bypassing many email security controls.

**Malware Distribution**: Typo domains serve malicious files disguised as legitimate software downloads. A user visiting `microsofft.com` seeking Windows updates might download trojanized installers. This vector bypasses email attachment scanning entirely.

**Corporate Email Interception (Doppelganger Domains)**: Research by Godai Group demonstrated that attackers who register doppelganger domains for Fortune 500 companies can passively receive corporate emails. Employees and business partners who omit the dot before a subdomain (`corpmail` vs `corp.mail`) send emails to the attacker-controlled domain. Over six months of monitoring, researchers collected hundreds of thousands of misdirected corporate emails containing sensitive business data.

### Notable Real-World Incidents

- **2006 — `goggle.com`**: Redirected Google visitors to spyware distribution sites for years before Google acquired the domain.
- **2021 — PyPI Malware Campaign**: Multiple packages including `python-dateutil` typos and `jeepney` variants were uploaded to PyPI, collectively downloaded thousands of times before removal. The packages executed reverse shells and credential stealers.
- **2021 — Alex Birsan's Dependency Confusion Research**: Birsan earned over $130,000 in bug bounties from companies including Microsoft, Apple, PayPal, Netflix, and Uber by demonstrating that their internal package names could be typosquatted on public registries, causing automatic malicious package installation in CI/CD pipelines.
- **2022 — npm `colors` and `faker` Incident**: While not typosquatting, it demonstrated supply chain fragility; typosquatting attacks on these packages appeared within weeks.
- **2023 — `requests` PyPI Typosquats**: Packages named `requestss`, `request`, and `reqeusts` appeared repeatedly on PyPI, some achieving thousands of downloads before removal.

### Detection Indicators
- Spike in DNS queries for known typo variants (detectable via DNS logging)
- New SSL certificate issuances for typo domains (Certificate Transparency logs via crt.sh)
- User-reported redirect or login anomalies
- SIEM alerts on outbound connections to newly registered domains (< 30 days old)

---

## Defensive Measures

### For Organizations

**1. Proactive Domain Registration**
Register common misspellings, TLD variants, and combosquatting variants of your primary domain and redirect them to the legitimate site. Prioritize:
- Top 5–10 most common typo patterns (identified via dnstwist)
- All major gTLDs (`.com`, `.net`, `.org`, `.co`, `.io`)
- Country-code TLDs relevant to your user base

**2. Certificate Transparency Monitoring**
Monitor CT logs for new certificate issuances on typo-variant domains:
```bash
# Monitor CT logs using certstream
pip install certstream

# Python script to alert on new certs matching your domain pattern
import certstream
import re

def callback(message, context):
    if message['message_type'] == 'certificate_update':
        domains = message['data']['leaf_cert']['all_domains']
        for domain in domains:
            if re.search(r'(g[o0]{2}g[l1]e|g[o0]g[o0]le)', domain):
                print(f"[ALERT] Suspicious cert: {domain}")

certstream.listen_for_events(callback, url='wss://certstream.calidog.io/')
```

**3. DNS-Based Controls**
- Deploy [[DNS Filtering]] (e.g., Cisco Umbrella, Cloudflare Gateway, Pi-hole with blocklists) that includes typosquatting domain feeds
- Enable **DNSSEC** on your own domains to prevent DNS tampering
- Configure **DNS Response Policy Zones (RPZ)** to block known malicious typo domains

**4. Browser and Endpoint Controls**